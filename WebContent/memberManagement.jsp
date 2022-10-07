<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.DBConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>

<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>.SIM</title>
</head>
<body>
	<%@include file="header.jsp"%>  
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
				<p><h3>회원 목록</h3>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">아이디</th>
						<th style="background-color: #eeeeee; text-align: center;">닉네임</th>
						<th style="background-color: #eeeeee; text-align: center;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;">생일</th>
						<th style="background-color: #eeeeee; text-align: center;">성별</th>
						<th style="background-color: #eeeeee; text-align: center;">휴대전화</th>
						<th style="background-color: #eeeeee; text-align: center;">포인트</th>
						<th style="background-color: #eeeeee; text-align: center;">등급</th>
						
						<th style="background-color: #eeeeee; text-align: center;">등급변경</th>
						<th style="background-color: #eeeeee; text-align: center;">회원삭제</th>
					</tr>
				</thead>
				<tbody>
					<%
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try{
						con = DBConnection.getCon();
						String sql = "select * from user";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()){
							String userId = rs.getString("userID");
							String nickName = rs.getString("nickName");
							String userName = rs.getString("userName");
							String birthday = rs.getString("birthday");
							String UserGender = rs.getString("UserGender");
							String UserPhone = rs.getString("UserPhone");
							String point = rs.getString("point");
							String MemberGrade = rs.getString("MemberGrade");
					%>
					<tr>
						<td><%=userId %></td>
						<td><%=nickName %></td>
						<td><%=userName %></td>
						<td><%=birthday %></td>
						<td><%=UserGender %></td>
						<td><%=UserPhone %></td>
						<td><%=point %></td>
						<td><%=MemberGrade %></td>
						<td><a href="gradeUpdate.jsp?userID=<%=userId %>">변경</a></td>
						<td><a href="memberDelete.jsp?userID=<%=userId %>">삭제</a></td>
					</tr>
					<%
						}
					} catch(SQLException se){
						System.out.println(se.getMessage());
					} finally {
						try{
							if(rs != null) {rs.close();}
							if(pstmt != null) {pstmt.close();}
							if(con != null) {con.close();}
						} catch(SQLException se){
							System.out.println(se.getMessage());
						}
					}
					%>
				</tbody>
			</table>
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>