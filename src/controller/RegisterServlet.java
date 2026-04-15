package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // ✅ Show Register Page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("user/register.jsp").forward(request, response);
    }

    // ✅ Handle Registration
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 🔍 Basic Validation
        if (name == null || name.isEmpty() ||
            email == null || email.isEmpty() ||
            password == null || password.isEmpty()) {

            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("user/register.jsp").forward(request, response);
            return;
        }

        // 🔐 Create User Object
        User user = new User(name, email, password);

        boolean success = userDAO.registerUser(user);

        if (success) {
            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration Failed!");
            request.getRequestDispatcher("user/register.jsp").forward(request, response);
        }
    }
}