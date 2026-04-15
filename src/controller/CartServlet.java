package controller;

import dao.CartDAO;
import model.Cart;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // 🔐 Check login
        if (user == null) {
            response.sendRedirect("user/login.jsp");
            return;
        }

        int userId = user.getId();

        if (action == null) action = "view";

        switch (action) {

            // ✅ View Cart
            case "view":
                List<Cart> cartList = cartDAO.getCartByUser(userId);
                double total = cartDAO.getTotalPrice(userId);

                request.setAttribute("cartList", cartList);
                request.setAttribute("total", total);

                request.getRequestDispatcher("user/cart.jsp").forward(request, response);
                break;

            // ✅ Remove Item
            case "remove":
                int cartId = Integer.parseInt(request.getParameter("id"));
                cartDAO.removeFromCart(cartId);
                response.sendRedirect("cart?action=view");
                break;

            default:
                response.sendRedirect("cart?action=view");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // 🔐 Check login
        if (user == null) {
            response.sendRedirect("user/login.jsp");
            return;
        }

        int userId = user.getId();

        switch (action) {

            // ✅ Add to Cart
            case "add":
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                cartDAO.addToCart(userId, productId, quantity);

                response.sendRedirect("cart?action=view");
                break;

            // ✅ Update Quantity
            case "update":
                int cartId = Integer.parseInt(request.getParameter("cartId"));
                int qty = Integer.parseInt(request.getParameter("quantity"));

                cartDAO.updateQuantity(cartId, qty);

                response.sendRedirect("cart?action=view");
                break;

            default:
                response.sendRedirect("cart?action=view");
                break;
        }
    }
}