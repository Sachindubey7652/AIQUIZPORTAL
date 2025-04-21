<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="com.aiquizportal.model.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
    int quizId = Integer.parseInt(request.getParameter("quizId"));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attempt Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }
        .question {
            margin-bottom: 20px;
        }
        input[type="radio"] {
            margin-right: 10px;
        }
        .btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>

    <h2>Welcome, <%= user.getName() %></h2>
    <h3>Quiz: <%= quizId %></h3>

    <form action="SubmitQuizServlet" method="POST">
        <input type="hidden" name="quizId" value="<%= quizId %>">
        
        <%
            // Fetch questions from database for the selected quiz
            Connection conn = com.aiquizportal.dao.DBUtil.getConnection();
            String sql = "SELECT * FROM questions WHERE quiz_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            int questionCount = 1;
            while (rs.next()) {
        %>
        
        <div class="question">
            <p><%= questionCount++ + ". " + rs.getString("question") %></p>
            <input type="radio" name="question_<%= rs.getInt("id") %>" value="A"> <%= rs.getString("option_a") %><br>
            <input type="radio" name="question_<%= rs.getInt("id") %>" value="B"> <%= rs.getString("option_b") %><br>
            <input type="radio" name="question_<%= rs.getInt("id") %>" value="C"> <%= rs.getString("option_c") %><br>
            <input type="radio" name="question_<%= rs.getInt("id") %>" value="D"> <%= rs.getString("option_d") %><br>
        </div>

        <% } %>

        <button type="submit" class="btn">Submit Quiz</button>
    </form>

</body>
</html>

<%
    rs.close();
    ps.close();
    conn.close();
%>
