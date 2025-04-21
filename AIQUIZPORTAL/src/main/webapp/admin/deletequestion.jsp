<%@ page import="java.sql.*" %>
<%
    int questionId = Integer.parseInt(request.getParameter("questionId"));
    int quizId = Integer.parseInt(request.getParameter("quizId"));

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = com.aiquizportal.dao.DBUtil.getConnection();
        ps = conn.prepareStatement("DELETE FROM questions WHERE id=?");
        ps.setInt(1, questionId);
        ps.executeUpdate();
        response.sendRedirect("viewquestions.jsp?quizId=" + quizId);
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
