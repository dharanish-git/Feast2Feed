<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="jakarta.servlet.http.HttpSession" %>
<%
    // Invalidate current session if exists
    HttpSession se = request.getSession(false);
    if (se != null) {
        se.invalidate();
    }
    // Redirect to login page after logout
    response.sendRedirect("login.jsp");
%>
