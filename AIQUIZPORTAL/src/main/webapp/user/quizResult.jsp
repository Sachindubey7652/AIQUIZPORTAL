<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aiquizportal.model.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");

    String scoreParam = request.getParameter("score");
    int score = 0;
    if (scoreParam != null && !scoreParam.isEmpty()) {
        score = Integer.parseInt(scoreParam);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Quiz Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            text-align: center;
        }
        .result-box {
            background-color: #f0f0f0;
            border: 2px solid #28a745;
            display: inline-block;
            padding: 30px;
            border-radius: 10px;
        }
        .score {
            font-size: 28px;
            color: #28a745;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            background: #007bff;
            color: white;
            border: none;
            font-size: 16px;
            text-decoration: none;
            border-radius: 6px;
        }
    </style>
</head>
<body>

    <div class="result-box">
        <h2>Well Done, <%= user.getName() %>!</h2>
        <p class="score">Your Score: <strong><%= score %></strong></p>
        <a href="dashboard.jsp" class="btn">Back to Dashboard</a>
    </div>

</body>
</html>
