<%@ page import="java.sql.*, java.util.*" %>
<%
    int quizId = Integer.parseInt(request.getParameter("quizId"));
    Connection conn = com.aiquizportal.dao.DBUtil.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT id, correct_option FROM questions WHERE quiz_id = ?");
    ps.setInt(1, quizId);
    ResultSet rs = ps.executeQuery();

    int total = 0, correct = 0;
    while (rs.next()) {
        total++;
        String userAns = request.getParameter("q" + rs.getInt("id"));
        String correctAns = rs.getString("correct_option");

        if (userAns != null && userAns.equalsIgnoreCase(correctAns)) {
            correct++;
        }
    }
%>

<html>
<head><title>Quiz Result</title></head>
<body>
    <h2>Quiz Completed</h2>
    <p>You answered <b><%= correct %></b> out of <b><%= total %></b> questions correctly.</p>
    <a href="dashboard.jsp">Go Back to Dashboard</a>
</body>
</html>
