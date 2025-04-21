<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aiquizportal.dao.DBUtil, com.aiquizportal.model.Quiz" %>
<%@ page import="java.sql.*" %>
<%
    String quizId = request.getParameter("quizId");
    if (quizId == null) {
        out.println("<p>No quiz specified.</p>");
        return;
    }

    Quiz quiz = null;
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT * FROM quizzes WHERE id = ?")) {
        ps.setInt(1, Integer.parseInt(quizId));
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setTitle(rs.getString("title"));
                quiz.setDescription(rs.getString("description"));
            }
        }
    } catch (Exception e) {
        throw new ServletException(e);
    }

    if (quiz == null) {
        out.println("<p>Quiz not found.</p>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Quiz</title>
</head>
<body>
  <h2>Edit Quiz #<%= quiz.getId() %></h2>
  <form action="<%= request.getContextPath() %>/UpdateQuizServlet" method="post">
    <input type="hidden" name="id" value="<%= quiz.getId() %>">
    <p>Title:<br>
       <input type="text" name="title" value="<%= quiz.getTitle() %>" required>
    </p>
    <p>Description:<br>
       <textarea name="description" rows="5" cols="50" required><%= quiz.getDescription() %></textarea>
    </p>
    <p><button type="submit">Save Changes</button></p>
  </form>
  <p><a href="<%= request.getContextPath() %>/admin/dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>