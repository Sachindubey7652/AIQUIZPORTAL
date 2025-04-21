package com.aiquizportal.controller;

import com.aiquizportal.dao.QuestionDao;
import com.aiquizportal.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


public class AddQuestionServlet extends HttpServlet {
    private QuestionDao questionDao;

    @Override
    public void init() {
        questionDao = new QuestionDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String questionText = request.getParameter("questionText");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctAnswer = request.getParameter("correctAnswer");

        Question question = new Question(0, questionText, optionA, optionB, optionC, optionD, correctAnswer);
        
        boolean isAdded = questionDao.addQuestion(question);
        
        if (isAdded) {
            response.sendRedirect("questionAdded.jsp");  // Redirect to confirmation page
        } else {
            response.sendRedirect("error.jsp");  // Redirect to error page if the question wasn't added
        }
    }
}
