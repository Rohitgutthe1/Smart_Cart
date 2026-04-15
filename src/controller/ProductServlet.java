package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/product")
@MultipartConfig
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    // ✅ HANDLE GET REQUESTS
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) action = "list";

        switch (action) {

            // ✅ Show Products (Pagination)
            case "list":
                int page = 1;
                int limit = 5;

                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }

                int offset = (page - 1) * limit;

                List<Product> products = productDAO.getAllProducts(offset, limit);
                int totalProducts = productDAO.getTotalProductCount();
                int totalPages = (int) Math.ceil((double) totalProducts / limit);

                request.setAttribute("products", products);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);

                request.getRequestDispatcher("user/products.jsp").forward(request, response);
                break;

            // ✅ Product Details
            case "view":
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = productDAO.getProductById(id);

                request.setAttribute("product", product);
                request.getRequestDispatcher("user/product-details.jsp").forward(request, response);
                break;

            // ✅ Search
            case "search":
                String keyword = request.getParameter("keyword");

                List<Product> searchResults = productDAO.searchProducts(keyword);

                request.setAttribute("products", searchResults);
                request.getRequestDispatcher("user/products.jsp").forward(request, response);
                break;

            // ✅ Filter by Category
            case "category":
                int categoryId = Integer.parseInt(request.getParameter("id"));

                List<Product> filtered = productDAO.getProductsByCategory(categoryId);

                request.setAttribute("products", filtered);
                request.getRequestDispatcher("user/products.jsp").forward(request, response);
                break;

            // ✅ Admin: Delete Product
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                productDAO.deleteProduct(deleteId);
                response.sendRedirect("admin?action=products");
                break;

            // ✅ Admin: Load Add Product Page
            case "addPage":
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("admin/add-product.jsp").forward(request, response);
                break;

            // ✅ Admin: Load Edit Product Page
            case "editPage":
                int editId = Integer.parseInt(request.getParameter("id"));

                request.setAttribute("product", productDAO.getProductById(editId));
                request.setAttribute("categories", categoryDAO.getAllCategories());

                request.getRequestDispatcher("admin/edit-product.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect("product?action=list");
                break;
        }
    }

    // ✅ HANDLE POST REQUESTS
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {

            // ✅ Add Product (WITH IMAGE UPLOAD)
            case "add":
                try {
                    String name = request.getParameter("name");
                    String desc = request.getParameter("description");
                    double price = Double.parseDouble(request.getParameter("price"));
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

                    // 📸 Image Upload
                    Part filePart = request.getPart("image");
                    String fileName = filePart.getSubmittedFileName();

                    String uploadPath = getServletContext().getRealPath("") + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();

                    filePart.write(uploadPath + File.separator + fileName);

                    Product product = new Product(name, desc, price, categoryId, fileName);
                    productDAO.addProduct(product);

                    response.sendRedirect("admin?action=products");

                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;

            // ✅ Update Product
            case "update":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("name");
                    String desc = request.getParameter("description");
                    double price = Double.parseDouble(request.getParameter("price"));
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

                    String image = request.getParameter("oldImage");

                    // If new image uploaded
                    Part filePart = request.getPart("image");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = filePart.getSubmittedFileName();

                        String uploadPath = getServletContext().getRealPath("") + "uploads";
                        filePart.write(uploadPath + File.separator + fileName);

                        image = fileName;
                    }

                    Product product = new Product(id, name, desc, price, categoryId, image);
                    productDAO.updateProduct(product);

                    response.sendRedirect("admin?action=products");

                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;

            default:
                response.sendRedirect("product?action=list");
                break;
        }
    }
}