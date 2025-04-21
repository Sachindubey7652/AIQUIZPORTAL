package com.aiquizportal.dao;

import com.aiquizportal.model.Question;
import java.sql.*;

public class QuestionDao {
    private static final String URL = "jdbc:mysql://localhost:3306/aiquizdb";  // Database URL
    private static final String USER = "root";  // Database username
    private static final String PASSWORD = "Hardest@321";  // Database password

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Insert new question into the database
    public boolean addQuestion(Question question) {
        String query = "INSERT INTO questions (questionText, optionA, optionB, optionC, optionD, correctAnswer) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            
            pst.setString(1, question.getQuestionText());
            pst.setString(2, question.getOptionA());
            pst.setString(3, question.getOptionB());
            pst.setString(4, question.getOptionC());
            pst.setString(5, question.getOptionD());
            pst.setString(6, question.getCorrectAnswer());

            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
