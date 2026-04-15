package dao;

import model.Order;
import model.OrderItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private Connection conn;

    public OrderDAO() {
        conn = DBConnection.getConnection();
    }

    // ✅ 1. Place Order (Cart → Order)
    public boolean placeOrder(Order order, List<OrderItem> items) {
        boolean result = false;

        try {
            conn.setAutoCommit(false); // Transaction start

            // Insert into orders table
            String orderQuery = "INSERT INTO orders(user_id, total_price, status) VALUES(?,?,?)";
            PreparedStatement orderStmt = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);

            orderStmt.setInt(1, order.getUserId());
            orderStmt.setDouble(2, order.getTotalPrice());
            orderStmt.setString(3, order.getStatus());

            int orderResult = orderStmt.executeUpdate();

            if (orderResult > 0) {
                ResultSet rs = orderStmt.getGeneratedKeys();

                if (rs.next()) {
                    int orderId = rs.getInt(1);

                    // Insert order items
                    String itemQuery = "INSERT INTO order_items(order_id, product_id, quantity, price) VALUES(?,?,?,?)";
                    PreparedStatement itemStmt = conn.prepareStatement(itemQuery);

                    for (OrderItem item : items) {
                        itemStmt.setInt(1, orderId);
                        itemStmt.setInt(2, item.getProductId());
                        itemStmt.setInt(3, item.getQuantity());
                        itemStmt.setDouble(4, item.getPrice());
                        itemStmt.addBatch();
                    }

                    itemStmt.executeBatch();
                    conn.commit(); // Commit transaction
                    result = true;
                }
            } else {
                conn.rollback();
            }

        } catch (Exception e) {
            try {
                conn.rollback(); // Rollback on error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();

        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return result;
    }

    // ✅ 2. Get Orders by User
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM orders WHERE user_id=? ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setDate(rs.getTimestamp("date"));

                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 3. Get Order Items by Order ID
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> list = new ArrayList<>();

        try {
            String query = "SELECT oi.*, p.name, p.image " +
                           "FROM order_items oi " +
                           "JOIN products p ON oi.product_id = p.id " +
                           "WHERE oi.order_id=?";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();

                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));

                // Extra fields
                item.setProductName(rs.getString("name"));
                item.setImage(rs.getString("image"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 4. Get All Orders (Admin)
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM orders ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setDate(rs.getTimestamp("date"));

                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 5. Update Order Status (Admin)
    public boolean updateOrderStatus(int orderId, String status) {
        boolean result = false;

        try {
            String query = "UPDATE orders SET status=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, status);
            ps.setInt(2, orderId);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}