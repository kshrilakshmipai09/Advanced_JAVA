package com.sql;

import java.sql.*;

public class Mysql_Update {

    public static void main(String[] args) {

        Connection conn = null;

        try {
            // Load Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/test?useSSL=false";
            String username = "root";
            String password = "password";        // ← Change if you have password

            conn = DriverManager.getConnection(url, username, password);

            System.out.println("✅ Connected Successfully to Database!");

            // Test Query
            String query = "SELECT * FROM coffee";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                System.out.println(rs.getInt("id") + " | " + 
                                 rs.getString("coffee_name") + " | " + 
                                 rs.getInt("price"));
            }

        } catch (ClassNotFoundException e) {
            System.out.println("❌ Driver Not Found - JAR not added properly");
        } catch (SQLException e) {
            System.out.println("❌ Database Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}