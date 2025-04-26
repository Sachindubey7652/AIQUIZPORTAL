package com.aiquizportal.dao;

import com.aiquizportal.model.User;
import java.sql.*;
import java.util.UUID;

public class UserDao {
    private static final String URL  = "jdbc:mysql://localhost:3306/aiquizdb";
    private static final String USER = "root";
    private static final String PASS = "Hardest@321";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private Connection getCon() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public User getByEmail(String email) {
        String sql = "SELECT id, name, email, password, reset_token FROM users WHERE email = ?";
        try (Connection c = getCon();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setName(rs.getString("name"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setResetToken(rs.getString("reset_token"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean storeResetToken(int userId, String token) {
        String sql = "UPDATE users SET reset_token = ? WHERE id = ?";
        try (Connection c = getCon();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String token, String hashedPassword) {
        String sql = "UPDATE users SET password = ?, reset_token = NULL WHERE reset_token = ?";
        try (Connection c = getCon();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, hashedPassword); // hashed password here
            ps.setString(2, token);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Utility to generate a random token **/
    public static String generateToken() {
        return UUID.randomUUID().toString();
    }
}
