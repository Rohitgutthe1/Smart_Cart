package controller;

import dao.*;
import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private UserDAO userDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        userDAO = new UserDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // 🔐 Check admin login
        if (session.getAttribute("admin") == null && !"login".equals(action)) {
            response.sendRedirect("admin/admin-login.jsp");
            return;
        }

        if (action == null) action = "dashboard";

        switch (action) {

            // ✅ Dashboard
            case "dashboard":
                List<User> users = userDAO.getAllUsers();
                List<Product> products = productDAO.getAllProducts(0, 100);
                List<Order> orders = orderDAO.getAllOrders();

                request.setAttribute("totalUsers", users.size());
                request.setAttribute("totalProducts", products.size());
                request.setAttribute("totalOrders", orders.size());

                double revenue = 0;
                for (Order o : orders) {
                    revenue += o.getTotalPrice();
                }
                request.setAttribute("revenue", revenue);

                request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
                break;

            // ✅ Manage Products
            case "products":
                List<Product> productList = productDAO.getAllProducts(0, 100);
                request.setAttribute("products", productList);
                request.getRequestDispatcher("admin/manage-products.jsp").forward(request, response);
                break;

            case "deleteProduct":
                int productId = Integer.parseInt(request.getParameter("id"));
                productDAO.deleteProduct(productId);
                response.sendRedirect("admin?action=products");
                break;

            // ✅ Add Product Page
            case "addProductPage":
                request.setAttribute("categories", categoryDAO.getAllCategories());
                request.getRequestDispatcher("admin/add-product.jsp").forward(request, response);
                break;

            // ✅ Edit Product Page
            case "editProductPage":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("product", productDAO.getProductById(id));
                request.setAttribute("categories", categoryDAO.getAllCategories());
                request.getRequestDispatcher("admin/edit-product.jsp").forward(request, response);
                break;

            // ✅ Categories
            case "categories":
                request.setAttribute("categories", categoryDAO.getAllCategories());
                request.getRequestDispatcher("admin/manage-categories.jsp").forward(request, response);
                break;

            case "deleteCategory":
                int catId = Integer.parseInt(request.getParameter("id"));
                categoryDAO.deleteCategory(catId);
                response.sendRedirect("admin?action=categories");
                break;

            // ✅ Users
            case "users":
                request.setAttribute("users", userDAO.getAllUsers());
                request.getRequestDispatcher("admin/manage-users.jsp").forward(request, response);
                break;

            case "deleteUser":
                int userId = Integer.parseInt(request.getParameter("id"));
                userDAO.deleteUser(userId);
                response.sendRedirect("admin?action=users");
                break;

            // ✅ Orders
            case "orders":
                request.setAttribute("orders", orderDAO.getAllOrders());
                request.getRequestDispatcher("admin/manage-orders.jsp").forward(request, response);
                break;

            case "updateOrderStatus":
                int orderId = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                orderDAO.updateOrderStatus(orderId, status);
                response.sendRedirect("admin?action=orders");
                break;

            // ✅ Logout
            case "logout":
                session.invalidate();
                response.sendRedirect("admin/admin-login.jsp");
                break;

            default:
                response.sendRedirect("admin?action=dashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // ✅ Admin Login
        if ("login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if ("admin".equals(username) && "admin123".equals(password)) {
                session.setAttribute("admin", username);
                response.sendRedirect("admin?action=dashboard");
            } else {
                request.setAttribute("error", "Invalid Credentials!");
                request.getRequestDispatcher("admin/admin-login.jsp").forward(request, response);
            }
        }

        // ✅ Add Category
        else if ("addCategory".equals(action)) {
            String name = request.getParameter("name");
            categoryDAO.addCategory(new Category(name));
            response.sendRedirect("admin?action=categories");
        }

        // ✅ Add Product
        else if ("addProduct".equals(action)) {
            try {
                String name = request.getParameter("name");
                String desc = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));

                String image = request.getParameter("image"); // simplified

                Product product = new Product(name, desc, price, categoryId, image);
                productDAO.addProduct(product);

                response.sendRedirect("admin?action=products");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ✅ Update Product
        else if ("updateProduct".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String desc = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String image = request.getParameter("image");

                Product product = new Product(id, name, desc, price, categoryId, image);
                productDAO.updateProduct(product);

                response.sendRedirect("admin?action=products");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}