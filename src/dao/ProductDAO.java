package dao;

import model.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Connection conn;

    public ProductDAO() {
        conn = DBConnection.getConnection();
    }

    // ✅ 1. Add Product
    public boolean addProduct(Product product) {
        boolean result = false;

        try {
            String query = "INSERT INTO products(name, description, price, category_id, image) VALUES(?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getCategoryId());
            ps.setString(5, product.getImage());

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 2. Get All Products (Pagination)
    public List<Product> getAllProducts(int offset, int limit) {
        List<Product> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM products ORDER BY id DESC LIMIT ?, ?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, offset);
            ps.setInt(2, limit);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getString("image")
                );
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 3. Get Product by ID
    public Product getProductById(int id) {
        Product product = null;

        try {
            String query = "SELECT * FROM products WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getString("image")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    // ✅ 4. Update Product
    public boolean updateProduct(Product product) {
        boolean result = false;

        try {
            String query = "UPDATE products SET name=?, description=?, price=?, category_id=?, image=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getCategoryId());
            ps.setString(5, product.getImage());
            ps.setInt(6, product.getId());

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 5. Delete Product
    public boolean deleteProduct(int id) {
        boolean result = false;

        try {
            String query = "DELETE FROM products WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, id);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 6. Get Total Product Count
    public int getTotalProductCount() {
        int count = 0;

        try {
            String query = "SELECT COUNT(*) FROM products";
            PreparedStatement ps = conn.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // ✅ 7. Search Products
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getString("image")
                );
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 8. Filter by Category
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM products WHERE category_id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getString("image")
                );
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}