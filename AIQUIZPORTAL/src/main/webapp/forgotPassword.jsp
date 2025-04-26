<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session != null && session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
        return;
    }
    String err = (String) request.getAttribute("errorMessage");
    String ok  = (String) request.getAttribute("msg");

%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Forgot Password</title>
</head>
<body>
  <h2>Forgot Password</h2>
  <form action="ForgotPasswordServlet" method="post">
    <input type="email" name="email" placeholder="Enter your email" required />
    <br><br>
    <input type="submit" value="Send OTP" />
  </form>

  <%
    String error = (String) request.getAttribute("error");
    String msg = (String) request.getAttribute("msg");
    if (error != null) { out.print("<p style='color:red;'>" + error + "</p>"); }
    if (msg != null) { out.print("<p style='color:green;'>" + msg + "</p>"); }
  %>
</body>
</html>
