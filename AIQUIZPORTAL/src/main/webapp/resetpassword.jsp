<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Your Password</h2>

    <% String token = request.getParameter("token"); %>

    <form action="ResetPasswordServlet" method="post">
        <input type="hidden" name="token" value="<%= token %>"/>

        <label>New Password:</label>
        <input type="password" name="newPassword" required><br><br>

        <label>Confirm Password:</label>
        <input type="password" name="confirmPassword" required><br><br>

        <input type="submit" value="Reset Password">
    </form>

    <% if(request.getAttribute("error") != null) { %>
        <p style="color:red;"><%= request.getAttribute("error") %></p>
    <% } else if(request.getAttribute("msg") != null) { %>
        <p style="color:green;"><%= request.getAttribute("msg") %></p>
    <% } %>
</body>
</html>
