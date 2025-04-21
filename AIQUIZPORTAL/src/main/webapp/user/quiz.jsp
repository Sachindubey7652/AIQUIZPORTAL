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
    String quizId = (String) request.getAttribute("quizId");

    if (questions == null || questions.isEmpty()) {
        out.println("<h3>No questions available for this quiz.</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attempt Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
        }
        .question {
            margin-bottom: 30px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 15px;
        }
        .submit-btn {
            padding: 10px 20px;
            background: green;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<h2>Quiz Time!</h2>

<form method="post" action="SubmitQuizServlet">
    <input type="hidden" name="quizId" value="<%= quizId %>"/>

    <%
        int qno = 1;
        for (Question q : questions) {
    %>
        <div class="question">
            <p><strong>Q<%= qno++ %>:</strong> <%= q.getQuestionText() %></p>
            <label><input type="radio" name="q<%= q.getQuestionId() %>" value="A" required> <%= q.getOptionA() %></label><br>
            <label><input type="radio" name="q<%= q.getQuestionId() %>" value="B"> <%= q.getOptionB() %></label><br>
            <label><input type="radio" name="q<%= q.getQuestionId() %>" value="C"> <%= q.getOptionC() %></label><br>
            <label><input type="radio" name="q<%= q.getQuestionId() %>" value="D"> <%= q.getOptionD() %></label><br>
        </div>
    <% } %>

    <button type="submit" class="submit-btn">Submit Quiz</button>
</form>

</body>
</html>
