package com.mysql;

import java.sql.*;

public class Mysql_Query {

    public static void main(String[] args) {

        Connection dbConnection = null;

        try {
            // Load Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/test?useSSL=false";
            String user = "root";
            String password = "password";          // Change if you have set a password

            dbConnection = DriverManager.getConnection(url, user, password);

            System.out.println("✅ Connected Successfully!");

            Statement st = dbConnection.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM coffee");

            while (rs.next()) {
                System.out.println(rs.getInt("id") + " | " + 
                                   rs.getString("coffee_name") + " | " + 
                                   rs.getInt("price"));
            }

        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver JAR not found. Please add the JAR properly.");
        } catch (SQLException e) {
            System.out.println("❌ Database Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (dbConnection != null) dbConnection.close();
            } catch (Exception e) {}
        }
    }
}