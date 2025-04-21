<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.aiquizportal.model.Question" %>
<%@ page import="com.aiquizportal.model.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
    ArrayList<Question> questions = (ArrayList<Question>) request.getAttribute("questions");
    int score = (Integer) request.getAttribute("score"); // assuming you pass score in request attribute
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result</title>
</head>
<body>

<h2>Quiz Result</h2>

<p><strong>User:</strong> <%= user.getName() %></p>
<p><strong>Score:</strong> <%= score %> / <%= questions.size() %></p>

<h3>Questions & Answers</h3>
<%
    int qno = 1;
    for (Question q : questions) {
%>
        <p><strong>Q<%= qno++ %>:</strong> <%= q.getQuestionText() %></p>
        <p>Your Answer: <%= request.getParameter("q" + q.getQuestionId()) %></p>
        <p>Correct Answer: <%= q.getCorrectAnswer() %></p>
        <hr>
<% } %>

</body>
</html>
