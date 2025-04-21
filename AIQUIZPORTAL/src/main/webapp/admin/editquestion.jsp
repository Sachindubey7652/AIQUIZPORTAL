<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int questionId = Integer.parseInt(request.getParameter("questionId"));
    int quizId = Integer.parseInt(request.getParameter("quizId"));
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String question = "", a = "", b = "", c = "", d = "", correct = "";

    try {
        conn = com.aiquizportal.dao.DBUtil.getConnection();
        ps = conn.prepareStatement("SELECT * FROM questions WHERE id=?");
        ps.setInt(1, questionId);
        rs = ps.executeQuery();
        if (rs.next()) {
            question = rs.getString("question");
            a = rs.getString("option_a");
            b = rs.getString("option_b");
            c = rs.getString("option_c");
            d = rs.getString("option_d");
            correct = rs.getString("correct_option");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Question</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f4f4f4;
        }
        input[type=text], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
        }
        .btn {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<h2>Edit Question</h2>

<form method="post" action="updatequestion.jsp">
    <input type="hidden" name="id" value="<%= questionId %>"/>
    <input type="hidden" name="quizId" value="<%= quizId %>"/>

    <label>Question</label>
    <input type="text" name="question" value="<%= question %>" required/>

    <label>Option A</label>
    <input type="text" name="optionA" value="<%= a %>" required/>

    <label>Option B</label>
    <input type="text" name="optionB" value="<%= b %>" required/>

    <label>Option C</label>
    <input type="text" name="optionC" value="<%= c %>" required/>

    <label>Option D</label>
    <input type="text" name="optionD" value="<%= d %>" required/>

    <label>Correct Option (A/B/C/D)</label>
    <input type="text" name="correctOption" value="<%= correct %>" required/>

    <button type="submit" class="btn">Update Question</button>
</form>

</body>
</html>
