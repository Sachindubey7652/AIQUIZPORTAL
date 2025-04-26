package com.aiquizportal.controller;

import com.aiquizportal.dao.QuestionDao;
import com.aiquizportal.model.Question;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class StartQuizServlet extends HttpServlet {
    private QuestionDao dao;

    @Override
    public void init() {
        dao = new QuestionDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String quizIdParam = req.getParameter("quizId");
        if (quizIdParam == null) {
            req.setAttribute("errorMessage", "Quiz ID missing");
            req.getRequestDispatcher("user/dashboard.jsp").forward(req, resp);
            return;
        }

        int quizId = Integer.parseInt(quizIdParam);
        List<Question> questions = dao.getByQuizId(quizId);

        req.setAttribute("quizId", quizId);
        req.setAttribute("questions", questions);
        req.getRequestDispatcher("user/quiz.jsp").forward(req, resp);
    }
}
