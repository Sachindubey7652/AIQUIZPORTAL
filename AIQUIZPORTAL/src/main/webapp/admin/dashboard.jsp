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
    if (!"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../user/dashboard.jsp");
        return;
    }

    String search = request.getParameter("search");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
        }
        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        .header-nav {
            text-align: right;
            margin-bottom: 20px;
        }
        .header-nav a {
            margin-left: 15px;
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }
        h2, h3 {
            color: #2c3e50;
        }
        .btn {
            padding: 8px 14px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
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
        .btn-create {
            background-color: #27ae60;
            margin-bottom: 10px;
        }
        .btn-create:hover {
            background-color: #1e8449;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            background-color: #fff;
        }
        th {
            background-color: #ecf0f1;
        }
        .actions a {
            margin-right: 10px;
        }
        .summary-box {
            margin: 20px 0;
            padding: 15px;
            background: #ecf0f1;
            border-radius: 8px;
        }
        .search-box {
            margin-bottom: 20px;
        }
        .search-box input[type="text"] {
            padding: 8px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-box input[type="submit"] {
            padding: 8px 14px;
            background-color: #2980b9;
            color: white;
            border: none;
            border-radius: 5px;
            margin-left: 5px;
        }
        .search-box input[type="submit"]:hover {
            background-color: #21618c;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-nav">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="createquiz.jsp">Create Quiz</a>
        <a href="../LogoutServlet">Logout</a>
    </div>

    <h2>Welcome, Admin <%= user.getName() %> 👋</h2>

    <div class="summary-box">
        <p><strong>Admin Panel:</strong> Use the search to filter quizzes or add new ones.</p>
    </div>

    <a href="createquiz.jsp" class="btn btn-create">+ Create New Quiz</a>

    <!-- New Add Question Button -->
    <a href="addquestion.jsp" class="btn btn-create">+ Add Question</a>

    <div class="search-box">
        <form method="get" action="dashboard.jsp">
            <input type="text" name="search" placeholder="Search by quiz title..." value="<%= (search != null) ? search : "" %>"/>
            <input type="submit" value="Search"/>
        </form>
    </div>

    <h3>All Quizzes</h3>

<%
    try {
        conn = com.aiquizportal.dao.DBUtil.getConnection();
        String sql = "SELECT * FROM quizzes";
        if (search != null && !search.trim().isEmpty()) {
            sql += " WHERE title LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + search.trim() + "%");
        } else {
            ps = conn.prepareStatement(sql);
        }

        rs = ps.executeQuery();
%>
    <table>
        <thead>
        <tr>
            <th>Quiz Title</th>
            <th>Description</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            boolean hasQuizzes = false;
            while (rs.next()) {
                hasQuizzes = true;
        %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getTimestamp("created_at") %></td>
            <td class="actions">
                <a href="editquiz.jsp?quizId=<%= rs.getInt("id") %>" class="btn">Edit</a>
                <a href="deletequiz.jsp?quizId=<%= rs.getInt("id") %>" class="btn btn-danger"
                   onclick="return confirm('Are you sure you want to delete this quiz?');">Delete</a>
                <!-- Link to Add Questions Page -->
         <a href="addquestion.jsp?quizId=<%= rs.getInt("id") %>" class="btn">Add Question</a>



            </td>
        </tr>
        <%
            }
            if (!hasQuizzes) {
        %>
        <tr>
            <td colspan="4" style="text-align:center;">No quizzes found.</td>
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
</div>

</body>
</html>
