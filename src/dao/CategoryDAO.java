package dao;

import model.Category;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    private Connection conn;

    public CategoryDAO() {
        conn = DBConnection.getConnection();
    }

    // ✅ 1. Add Category
    public boolean addCategory(Category category) {
        boolean result = false;

        try {
            String query = "INSERT INTO categories(name) VALUES(?)";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, category.getName());

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 2. Get All Categories
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM categories ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category(
                        rs.getInt("id"),
                        rs.getString("name")
                );
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 3. Delete Category
    public boolean deleteCategory(int id) {
        boolean result = false;

        try {
            String query = "DELETE FROM categories WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, id);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 4. Get Category by ID
    public Category getCategoryById(int id) {
        Category category = null;

        try {
            String query = "SELECT * FROM categories WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                category = new Category(
                        rs.getInt("id"),
                        rs.getString("name")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }
}