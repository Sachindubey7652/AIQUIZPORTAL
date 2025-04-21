package com.aiquizportal.controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import com.aiquizportal.model.Question;
import com.aiquizportal.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class SubmitQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String quizId = request.getParameter("quizId");
        HttpSession sessionObj = request.getSession(false);

        // Check if the user is logged in
        if (sessionObj == null || sessionObj.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) sessionObj.getAttribute("user");
        int score = 0;
        ArrayList<Question> questions = new ArrayList<>();

        try {
            // Retrieve the questions from the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aiquizdb", "root", "Hardest@321");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM questions WHERE quiz_id = ?");
            ps.setString(1, quizId);
            ResultSet rs = ps.executeQuery();

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

            // Calculate the score based on user's answers
            for (Question q : questions) {
                String userAnswer = request.getParameter("q" + q.getQuestionId()); // Get the user answer for the specific question
                if (userAnswer != null && userAnswer.equals(q.getCorrectAnswer())) {
                    score++;
                }
            }

            // Set score and questions as request attributes to pass to result.jsp
            request.setAttribute("score", score);
            request.setAttribute("questions", questions);

            // Forward to result.jsp
            RequestDispatcher rd = request.getRequestDispatcher("user/result.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error submitting quiz: " + e.getMessage());
            request.getRequestDispatcher("user/quiz.jsp").forward(request, response);
        }
    }
}
