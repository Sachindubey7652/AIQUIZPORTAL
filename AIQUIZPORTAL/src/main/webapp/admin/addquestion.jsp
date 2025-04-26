<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="com.aiquizportal.model.User" %>
<%
// 1) Check login & role

// Check if user is logged in
if (session == null || session.getAttribute("user") == null) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

// Optional: Check if user is admin
User user = (User) session.getAttribute("user");
if (!"admin".equals(user.getRole())) {
response.sendRedirect(request.getContextPath() + "/unauthorized.jsp");
return;
}

// 2) Grab quizId from query string
String quizId = request.getParameter("quizId");
if (quizId == null) {
out.println("<p style='color:red; text-align:center;'>No quiz selected. "
         + "<a href='dashboard.jsp'>Back to Dashboard</a></p>");
return;
}

// 3) Optional feedback messages
String error   = (String) request.getAttribute("errorMessage");
String success = (String) request.getAttribute("successMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Question to Quiz #<%= quizId %></title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f7f6;
      margin: 0; padding: 0;
      display: flex; justify-content: center; align-items: center;
      min-height: 100vh;
    }
    .form-container {
      background: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      width: 100%; max-width: 600px;
    }
    h1 {
      margin-top: 0;
      color: #333;
      text-align: center;
    }
    .message {
      padding: 10px;
      margin-bottom: 20px;
      border-radius: 4px;
      text-align: center;
    }
    .error { background: #fdecea; color: #b71c1c; }
    .success { background: #e8f5e9; color: #256029; }
    label {
      display: block;
      font-weight: bold;
      margin-top: 15px;
      color: #333;
    }
    input[type="text"],
    textarea,
    select {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      box-sizing: border-box;
    }
    textarea { resize: vertical; }
    input:focus, textarea:focus, select:focus {
      border-color: #4CAF50;
      outline: none;
    }
    button {
      width: 100%;
      padding: 12px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 20px;
      transition: background-color 0.3s;
    }
    button:hover { background-color: #45a049; }

    @media screen and (max-width: 600px) {
      .form-container { padding: 20px; }
      input, textarea, select, button { font-size: 14px; }
    }
  </style>
</head>
<body>
  <div class="form-container">
    <h1>Add Question to Quiz #<%= quizId %></h1>

    <% if (error != null) { %>
      <div class="message error"><%= error %></div>
    <% } else if (success != null) { %>
      <div class="message success"><%= success %></div>
    <% } %>

   <form action="<%= request.getContextPath() %>/admin/AddQuestionServlet" method="post">

      <input type="hidden" name="quizId" value="<%= quizId %>"/>

      <label for="questionText">Question</label>
      <textarea id="questionText" name="questionText" rows="3"
                placeholder="Type your question here…" required></textarea>

      <label for="optionA">Option A</label>
      <input type="text" id="optionA" name="optionA"
             placeholder="Enter text for option A" required/>

      <label for="optionB">Option B</label>
      <input type="text" id="optionB" name="optionB"
             placeholder="Enter text for option B" required/>

      <label for="optionC">Option C</label>
      <input type="text" id="optionC" name="optionC"
             placeholder="Enter text for option C" required/>

      <label for="optionD">Option D</label>
      <input type="text" id="optionD" name="optionD"
             placeholder="Enter text for option D" required/>

      <label for="correctAnswer">Correct Answer</label>
      <select id="correctAnswer" name="correctAnswer" required>
        <option value="">— select A, B, C or D —</option>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
      </select>

      <button type="submit">Add Question</button>
    </form>
  </div>
</body>
</html>
