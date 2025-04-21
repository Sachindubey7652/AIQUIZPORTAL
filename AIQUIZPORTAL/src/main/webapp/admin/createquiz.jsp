<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aiquizportal.model.User" %>
<%
    // Ensure only admins access this page
    // 'session' is already provided by JSP, so don’t redeclare it.
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    User user = (User) session.getAttribute("user");
    if (!"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Create New Quiz</title>
  <style>
    body { font-family: Arial; margin: 30px; }
    input, textarea { width: 100%; padding: 8px; margin-bottom: 15px; }
    .btn { padding: 10px 20px; background: #4CAF50; color: white; border: none; border-radius: 4px; }
  </style>
</head>
<body>
  <h2>Create a New Quiz</h2>
  <form action="${pageContext.request.contextPath}/CreateQuizServlet" method="post">
    <label>Title:</label><br>
    <input type="text" name="title" required><br>
    <label>Description:</label><br>
    <textarea name="description" rows="4" required></textarea><br>
    <button type="submit" class="btn">Create Quiz</button>
    &nbsp;<a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Cancel</a>
  </form>
</body>
</html>
