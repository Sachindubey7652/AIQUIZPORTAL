package com.aiquizportal.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                // Load JDBC driver (optional for JDBC 4.0+)
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = "jdbc:mysql://127.0.0.1:3306/aiquizdb";
                String username = "root";
                String password = "Hardest@321";

                connection = DriverManager.getConnection(url, username, password);

            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                throw new SQLException("MySQL JDBC Driver not found.");
            } catch (SQLException e) {
                e.printStackTrace();
                throw new SQLException("Unable to connect to database.");
            }
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
