package com.aiquizportal.controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import com.aiquizportal.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Establish connection to the database
            Connection conn = com.aiquizportal.dao.DBUtil.getConnection();

            // Prepare the query to find user by email
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            // Check if the user exists
            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // Check if the provided password matches the stored hashed password
                if (BCrypt.checkpw(password, storedPassword)) {
                    // Create a new User object and store it in the session
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));

                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);

                    // ✅ Role-based redirection
                    String role = user.getRole();
                    if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("admin/dashboard.jsp");
                    } else if ("user".equalsIgnoreCase(role)) {
                        response.sendRedirect("user/dashboard.jsp");
                    } else {
                        // Unknown role
                        request.setAttribute("errorMessage", "Invalid user role.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }

                } else {
                    // Invalid password
                    request.setAttribute("errorMessage", "Invalid password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // User not found
                request.setAttribute("errorMessage", "No user found with this email.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            // Close connections
            rs.close();
            ps.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
