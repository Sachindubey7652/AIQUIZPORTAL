<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String quizIdParam = request.getParameter("quizId");
    if (quizIdParam == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    int quizId = Integer.parseInt(quizIdParam);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Questions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #34495e;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            background-color: #fff;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #ecf0f1;
        }
        .btn {
            padding: 6px 12px;
            margin-right: 5px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .btn-danger {
            background-color: #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<h2>Questions for Quiz ID: <%= quizId %></h2>

<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = com.aiquizportal.dao.DBUtil.getConnection();
        String query = "SELECT * FROM questions WHERE quiz_id = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, quizId);
        rs = ps.executeQuery();
%>

<table>
    <thead>
        <tr>
            <th>Question</th>
            <th>Options</th>
            <th>Correct</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <%
        while (rs.next()) {
    %>
        <tr>
            <td><%= rs.getString("question") %></td>
            <td>
                A. <%= rs.getString("option_a") %><br/>
                B. <%= rs.getString("option_b") %><br/>
                C. <%= rs.getString("option_c") %><br/>
                D. <%= rs.getString("option_d") %>
            </td>
            <td><%= rs.getString("correct_option") %></td>
            <td>
                <a href="editquestion.jsp?questionId=<%= rs.getInt("id") %>&quizId=<%= quizId %>" class="btn">Edit</a>
                <a href="deletequestion.jsp?questionId=<%= rs.getInt("id") %>&quizId=<%= quizId %>" class="btn btn-danger"
                   onclick="return confirm('Are you sure you want to delete this question?');">Delete</a>
            </td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>

<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

</body>
</html>
