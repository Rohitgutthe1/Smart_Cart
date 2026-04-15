package dao;

import model.Cart;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    private Connection conn;

    public CartDAO() {
        conn = DBConnection.getConnection();
    }

    // ✅ 1. Add to Cart
    public boolean addToCart(int userId, int productId, int quantity) {
        boolean result = false;

        try {
            // Check if product already exists in cart
            String checkQuery = "SELECT * FROM cart WHERE user_id=? AND product_id=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);

            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // If exists → update quantity
                String updateQuery = "UPDATE cart SET quantity = quantity + ? WHERE user_id=? AND product_id=?";
                PreparedStatement ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, quantity);
                ps.setInt(2, userId);
                ps.setInt(3, productId);

                result = ps.executeUpdate() > 0;

            } else {
                // Insert new item
                String insertQuery = "INSERT INTO cart(user_id, product_id, quantity) VALUES(?,?,?)";
                PreparedStatement ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);

                result = ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 2. Get Cart Items by User
    public List<Cart> getCartByUser(int userId) {
        List<Cart> list = new ArrayList<>();

        try {
            String query = "SELECT c.*, p.name, p.price, p.image " +
                           "FROM cart c JOIN products p ON c.product_id = p.id " +
                           "WHERE c.user_id = ?";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();

                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("quantity"));

                // Extra fields
                cart.setProductName(rs.getString("name"));
                cart.setPrice(rs.getDouble("price"));
                cart.setImage(rs.getString("image"));

                list.add(cart);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 3. Update Quantity
    public boolean updateQuantity(int cartId, int quantity) {
        boolean result = false;

        try {
            String query = "UPDATE cart SET quantity=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, quantity);
            ps.setInt(2, cartId);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 4. Remove Item from Cart
    public boolean removeFromCart(int cartId) {
        boolean result = false;

        try {
            String query = "DELETE FROM cart WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, cartId);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 5. Clear Cart after Order
    public boolean clearCart(int userId) {
        boolean result = false;

        try {
            String query = "DELETE FROM cart WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, userId);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 6. Get Total Price of Cart
    public double getTotalPrice(int userId) {
        double total = 0;

        try {
            String query = "SELECT SUM(c.quantity * p.price) AS total " +
                           "FROM cart c JOIN products p ON c.product_id = p.id " +
                           "WHERE c.user_id=?";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
}