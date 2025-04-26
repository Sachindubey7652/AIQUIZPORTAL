package com.aiquizportal.controller;

import com.aiquizportal.dao.UserDao;
import com.aiquizportal.model.User;
import com.aiquizportal.util.EmailUtility;
import jakarta.mail.MessagingException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ForgotPasswordServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    // Show the forgot‐password form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("forgotPassword.jsp")
           .forward(req, resp);
    }

    // Handle form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");

        if (email == null || email.isBlank()) {
            req.setAttribute("error", "Please enter your email.");
            req.getRequestDispatcher("forgotPassword.jsp")
               .forward(req, resp);
            return;
        }

        User user = userDao.getByEmail(email);
        if (user == null) {
            req.setAttribute("error", "No account found with that email.");
            req.getRequestDispatcher("forgotPassword.jsp")
               .forward(req, resp);
            return;
        }

        // generate & persist a one‐time token
        String token = UserDao.generateToken();
        userDao.storeResetToken(user.getId(), token);

        // build the reset link
        String baseUrl = req.getRequestURL()
                            .toString()
                            .replace(req.getServletPath(), "");
        String link = baseUrl + "/resetpassword.jsp?token=" + token;

        try {
            EmailUtility.sendEmail(
                email,
                "AIQUIZPORTAL Password Reset",
                "Click the link below to reset your password:\n" + link
            );
            req.setAttribute("success", "A reset link has been sent to your email.");
        } catch (MessagingException e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to send email. Please try again later.");
        }

        req.getRequestDispatcher("forgotPassword.jsp")
           .forward(req, resp);
    }
}
