package controller;

import dao.CartDAO;
import dao.OrderDAO;
import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private CartDAO cartDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        cartDAO = new CartDAO();
    }

    // ✅ Handle GET (View Orders)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // 🔐 Check login
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = user.getId();

        if (action == null) action = "list";

        switch (action) {

            // ✅ View Orders
            case "list":
                List<Order> orders = orderDAO.getOrdersByUser(userId);

                // Load items for each order
                for (Order o : orders) {
                    o.setItems(orderDAO.getOrderItems(o.getId()));
                }

                request.setAttribute("orders", orders);
                request.getRequestDispatcher("user/orders.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect("order?action=list");
                break;
        }
    }

    // ✅ Handle POST (Place Order)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // 🔐 Check login
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = user.getId();

        if ("place".equals(action)) {

            // 1️⃣ Get cart items
            List<Cart> cartList = cartDAO.getCartByUser(userId);

            if (cartList.isEmpty()) {
                response.sendRedirect("cart?action=view");
                return;
            }

            // 2️⃣ Convert cart → order items
            List<OrderItem> orderItems = new ArrayList<>();
            double total = 0;

            for (Cart c : cartList) {
                OrderItem item = new OrderItem(
                        0,
                        c.getProductId(),
                        c.getQuantity(),
                        c.getPrice()
                );
                orderItems.add(item);
                total += c.getTotalPrice();
            }

            // 3️⃣ Create order
            Order order = new Order(userId, total, "Pending");

            // 4️⃣ Save order
            boolean success = orderDAO.placeOrder(order, orderItems);

            if (success) {
                // 5️⃣ Clear cart
                cartDAO.clearCart(userId);

                response.sendRedirect("order?action=list");
            } else {
                response.sendRedirect("cart?action=view");
            }
        }
    }
}