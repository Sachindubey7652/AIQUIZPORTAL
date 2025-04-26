package com.aiquizportal.controller;

import java.io.*;
import javax.servlet.*;
import java.sql.*;
import com.aiquizportal.dao.DBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DeleteQuizServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int quizId = Integer.parseInt(request.getParameter("quizId"));

        try (Connection conn = DBUtil.getConnection()) {

            // Delete related questions first
            String deleteQuestionsSQL = "DELETE FROM questions WHERE quiz_id = ?";
            try (PreparedStatement psQ = conn.prepareStatement(deleteQuestionsSQL)) {
                psQ.setInt(1, quizId);
                psQ.executeUpdate();
            }

            // Delete the quiz
            String sql = "DELETE FROM quizzes WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, quizId);
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin/dashboard.jsp");

    }
}

