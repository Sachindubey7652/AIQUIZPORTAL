<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aiquizportal.model.User" %>
<%
    // The 'session' object is implicitly available in JSP—no need to import or redeclare it.

    // If there is no session or no 'user' in it, send back to login
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Retrieve the logged‑in user
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile</title>
</head>
<body>
  <h1>Welcome to Your Profile, <%= user.getName() %>!</h1>
  <p><strong>Email:     </strong> <%= user.getEmail() %></p>
  <p><strong>Role:      </strong> <%= user.getRole() %></p>
 <form action="${pageContext.request.contextPath}/LogoutServlet" method="get">
  <button type="submit">Logout</button>
</form>
</body>
</html>
