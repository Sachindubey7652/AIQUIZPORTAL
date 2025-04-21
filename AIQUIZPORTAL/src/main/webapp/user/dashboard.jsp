<%@ page import="java.util.*, java.sql.*, com.aiquizportal.model.User" %>
<%@ page session="true" %>
<%
    // Retrieve the user object from session
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - AI Quiz Portal</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
        }
        .container {
            width: 90%;
            margin: auto;
            padding-top: 30px;
        }
        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }
        nav {
            text-align: right;
            margin-top: -40px;
            margin-right: 20px;
        }
        nav a {
            margin-left: 15px;
            color: #ecf0f1;
            text-decoration: none;
            font-weight: bold;
        }
        .welcome {
            font-size: 24px;
            color: #34495e;
            margin: 20px 0;
        }
        .quiz-card {
            background-color: #fff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .quiz-card h3 {
            margin: 0;
            color: #2980b9;
        }
        .quiz-card p {
            margin-top: 10px;
        }
        .start-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #27ae60;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
        }
        .start-btn:hover {
            background-color: #1e8449;
        }
    </style>
</head>
<body>

<header>
    <h1>AI Quiz Portal</h1>
    <nav>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="profile.jsp">Profile</a>
        <a href="../LogoutServlet">Logout</a>
    </nav>
</header>

<div class="container">
    <div class="welcome">Welcome, <%= user.getName() %>!</div>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aiquizdb", "root", "Hardest@321");

            String query = "SELECT * FROM quizzes";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                String quizId = rs.getString("id");
                String quizTitle = rs.getString("title");
                String quizDesc = rs.getString("description");
    %>
        <div class="quiz-card">
            <h3><%= quizTitle %></h3>
            <p><%= quizDesc %></p>
            <a class="start-btn" href="../StartQuizServlet?quizId=<%= quizId %>">Start Quiz</a>
        </div>
    <%
            }
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</div>

</body>
</html>
