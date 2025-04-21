package com.aiquizportal.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteQuizServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int quizId = Integer.parseInt(request.getParameter("quizId"));

        // Delete quiz from database
        try {
            Connection conn = com.aiquizportal.dao.DBUtil.getConnection();
            String sql = "DELETE FROM quizzes WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quizId);
            ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Redirect back to the dashboard
        response.sendRedirect("dashboard.jsp");
    }
}
