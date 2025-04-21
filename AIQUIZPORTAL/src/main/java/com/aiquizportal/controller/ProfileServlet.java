package com.aiquizportal.controller;


import com.aiquizportal.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/user/profile.jsp");
        dispatcher.forward(request, response);
    }
}
