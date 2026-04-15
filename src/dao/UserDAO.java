package dao;

import model.User;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private Connection conn;

    public UserDAO() {
        conn = DBConnection.getConnection();
    }

    // ✅ 1. Register User
public boolean registerUser(User user) {
    try {
        String query = "INSERT INTO users(name, email, password) VALUES(?,?,?)";
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setString(1, user.getName());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPassword());

        int rows = ps.executeUpdate();

        System.out.println("Inserted rows: " + rows);

        return rows > 0;

    } catch (SQLException e) {

        System.out.println("❌ SQL ERROR:");
        System.out.println("Message: " + e.getMessage());
        System.out.println("Code: " + e.getErrorCode());

        e.printStackTrace();
    }

    return false;
}

    // ✅ 2. Login User
    public User login(String email, String password) {
        User user = null;

        try {
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // ✅ 3. Get All Users (Admin)
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM users ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password")
                );
                list.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ 4. Delete User
    public boolean deleteUser(int id) {
        boolean result = false;

        try {
            String query = "DELETE FROM users WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, id);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ✅ 5. Get User by ID
    public User getUserById(int id) {
        User user = null;

        try {
            String query = "SELECT * FROM users WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}