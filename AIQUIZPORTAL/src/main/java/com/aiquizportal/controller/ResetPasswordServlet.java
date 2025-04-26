package com.aiquizportal.controller;

import com.aiquizportal.dao.UserDao;
import org.mindrot.jbcrypt.BCrypt;   // Add this import
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ResetPasswordServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String token = req.getParameter("token");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (token == null || token.trim().isEmpty()) {
            req.setAttribute("error", "Invalid or expired token.");
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("resetpassword.jsp?token=" + token).forward(req, resp);
            return;
        }

        // ⚡ Hash the new password before saving
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        boolean updated = userDao.updatePassword(token, hashedPassword);
        if (updated) {
            req.setAttribute("msg", "Password reset successful. You can now login.");
        } else {
            req.setAttribute("error", "Failed to reset password. Try again.");
        }

        req.getRequestDispatcher("resetpassword.jsp?token=" + token).forward(req, resp);
    }
}
