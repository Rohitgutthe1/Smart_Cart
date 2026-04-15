package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection conn = null;

    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/smartcart";
    private static final String USER = "root";
    private static final String PASSWORD = "root123"; // change this

    // Private constructor (Singleton pattern)
    private DBConnection() {}

    public static Connection getConnection() {

        try {
            if (conn == null || conn.isClosed()) {

                // Load MySQL Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Create Connection
                conn = DriverManager.getConnection(URL, USER, PASSWORD);

                System.out.println("✅ Database Connected Successfully...");
            }

        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver Not Found");
            e.printStackTrace();

        } catch (SQLException e) {
            System.out.println("❌ Database Connection Failed");
            e.printStackTrace();
        }

        return conn;
    }
}