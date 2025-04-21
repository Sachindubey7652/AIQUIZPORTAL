package com.aiquizportal.controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import com.aiquizportal.model.Question;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class StartQuizServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String quizId = request.getParameter("quizId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aiquizdb", "root", "Hardest@321");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM questions WHERE quiz_id = ?");
            ps.setString(1, quizId);
            ResultSet rs = ps.executeQuery();

            ArrayList<Question> questions = new ArrayList<>();
            while (rs.next()) {
                Question question = new Question();
                question.setQuestionId(rs.getInt("id"));
                question.setQuestionText(rs.getString("question_text"));
                question.setOptionA(rs.getString("option_a"));
                question.setOptionB(rs.getString("option_b"));
                question.setOptionC(rs.getString("option_c"));
                question.setOptionD(rs.getString("option_d"));
                question.setCorrectAnswer(rs.getString("correct_option"));
                questions.add(question);
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("quizId", quizId);
            request.setAttribute("questions", questions);

            RequestDispatcher rd = request.getRequestDispatcher("user/quiz.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading quiz: " + e.getMessage());
            request.getRequestDispatcher("user/dashboard.jsp").forward(request, response);
        }
    }
}
