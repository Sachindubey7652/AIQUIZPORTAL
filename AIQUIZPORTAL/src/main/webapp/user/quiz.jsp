<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.aiquizportal.model.Question" %>
<%
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    if (questions == null || questions.isEmpty()) {
%>
    <h2>No questions found for this quiz.</h2>
<%
    return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>AI Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            padding: 30px;
        }
        .quiz-box {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            max-width: 800px;
            margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        .question {
            margin-bottom: 20px;
        }
        .question h3 {
            margin: 10px 0;
        }
        .options label {
            display: block;
            margin: 5px 0;
        }
        .submit-btn {
            padding: 10px 20px;
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<div class="quiz-box">
    <h2>AI Quiz</h2>
    <form method="post" action="SubmitQuizServlet">
        <%
            int qNo = 1;
            for (Question q : questions) {
        %>
        <div class="question">
            <h3>Q<%= qNo++ %>: <%= q.getQuestionText() %></h3>
            <div class="options">
                <label><input type="radio" name="q<%= q.getQuestionId() %>" value="A" required> <%= q.getOptionA() %></label>
                <label><input type="radio" name="q<%= q.getQuestionId() %>" value="B"> <%= q.getOptionB() %></label>
                <label><input type="radio" name="q<%= q.getQuestionId() %>" value="C"> <%= q.getOptionC() %></label>
                <label><input type="radio" name="q<%= q.getQuestionId() %>" value="D"> <%= q.getOptionD() %></label>
            </div>
        </div>
        <% } %>

        <!-- You can pass the quizId as hidden if needed in your SubmitQuizServlet -->
        <input type="hidden" name="quizId" value="<%= questions.get(0).getQuizId() %>">

        <button type="submit" class="submit-btn">Submit Quiz</button>
    </form>
</div>

</body>
</html>
