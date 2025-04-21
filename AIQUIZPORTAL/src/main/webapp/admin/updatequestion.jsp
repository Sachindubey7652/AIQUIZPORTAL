<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int quizId = Integer.parseInt(request.getParameter("quizId"));

    String question = request.getParameter("question");
    String optionA = request.getParameter("optionA");
    String optionB = request.getParameter("optionB");
    String optionC = request.getParameter("optionC");
    String optionD = request.getParameter("optionD");
    String correctOption = request.getParameter("correctOption");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = com.aiquizportal.dao.DBUtil.getConnection();
        ps = conn.prepareStatement("UPDATE questions SET question=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_option=? WHERE id=?");
        ps.setString(1, question);
        ps.setString(2, optionA);
        ps.setString(3, optionB);
        ps.setString(4, optionC);
        ps.setString(5, optionD);
        ps.setString(6, correctOption);
        ps.setInt(7, id);

        ps.executeUpdate();
        response.sendRedirect("viewquestions.jsp?quizId=" + quizId);
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
