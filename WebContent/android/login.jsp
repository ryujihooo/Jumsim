<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   UserDAO userDAO = new UserDAO();
   
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   
   int returns = userDAO.login(id, pw);

   System.out.println(returns);

   // 안드로이드로 전송
   out.println(returns);
%>