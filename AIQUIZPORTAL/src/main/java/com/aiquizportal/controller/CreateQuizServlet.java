package com.aiquizportal.controller;

import com.aiquizportal.dao.DBUtil;
import com.aiquizportal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CreateQuizServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ensure user is logged in and is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }

        // Read form inputs
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        // Insert into DB
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
               "INSERT INTO quizzes (title, description) VALUES (?, ?)")) {
            ps.setString(1, title);
            ps.setString(2, description);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Error creating quiz", e);
        }

        // Redirect back to admin dashboard
        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
    }
}
