package com.aiquizportal.controller;

import com.aiquizportal.dao.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UpdateQuizServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        if (idParam == null || title == null || description == null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            return;
        }

        int id = Integer.parseInt(idParam);
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE quizzes SET title = ?, description = ? WHERE id = ?")) {
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
    }
}