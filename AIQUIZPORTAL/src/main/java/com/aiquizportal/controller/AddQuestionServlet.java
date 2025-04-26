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
 protected void doPost(HttpServletRequest req, HttpServletResponse resp)
         throws ServletException, IOException {

     // 1) read the quizId from the hidden field
     int quizId = Integer.parseInt(req.getParameter("quizId"));

     // 2) read all question fields
     String text    = req.getParameter("questionText");
     String a       = req.getParameter("optionA");
     String b       = req.getParameter("optionB");
     String c       = req.getParameter("optionC");
     String d       = req.getParameter("optionD");
     String correct = req.getParameter("correctAnswer");

     // 3) create model and persist
     Question q = new Question(quizId, text, a, b, c, d, correct);
     boolean ok = questionDao.addQuestion(q);

     // 4) redirect back to admin dashboard (or error)
     String ctx = req.getContextPath();
     if (ok) {
         resp.sendRedirect(ctx + "/admin/dashboard.jsp");
     } else {
         resp.sendRedirect(ctx + "/admin/error.jsp");
     }
 }
}
