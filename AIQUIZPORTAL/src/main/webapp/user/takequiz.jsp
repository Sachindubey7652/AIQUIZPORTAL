<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.aiquizportal.model.User" %>
<%
    String quizIdStr = request.getParameter("quizId");
    int quizId = Integer.parseInt(quizIdStr);

    // Get the logged-in user from session
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    User user = (User) sessionObj.getAttribute("user");

    // Fetch the quiz questions from the database
    Connection conn = com.aiquizportal.dao.DBUtil.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM questions WHERE quiz_id = ?");
    ps.setInt(1, quizId);
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Take Quiz</title>
    <style>
        body {
            font-family: Arial;
            margin: 30px;
        }
        .question {
            padding: 15px;
            margin-bottom: 10px;
            background: #fff;
            border-radius: 8px;
        }
        .options {
            margin-left: 20px;
        }
        .submit-btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>

    <h2>Welcome, <%= user.getName() %>!</h2>
    <h3>Quiz: <%= request.getParameter("quizTitle") %></h3>

    <form action="SubmitQuizServlet" method="POST">
        <% 
            int questionCount = 1;
            while (rs.next()) {
        %>
            <div class="question">
                <p><strong>Question <%= questionCount %>:</strong> <%= rs.getString("question") %></p>
                <div class="options">
                    <input type="radio" name="question_<%= rs.getInt("id") %>" value="1"> <%= rs.getString("option_1") %><br>
                    <input type="radio" name="question_<%= rs.getInt("id") %>" value="2"> <%= rs.getString("option_2") %><br>
                    <input type="radio" name="question_<%= rs.getInt("id") %>" value="3"> <%= rs.getString("option_3") %><br>
                    <input type="radio" name="question_<%= rs.getInt("id") %>" value="4"> <%= rs.getString("option_4") %><br>
                </div>
            </div>
        <%
            questionCount++;
            }
        %>
        <br>
        <button type="submit" class="submit-btn">Submit Quiz</button>
    </form>

</body>
</html>

<%
    // Close database connection
    rs.close();
    ps.close();
    conn.close();
%>
