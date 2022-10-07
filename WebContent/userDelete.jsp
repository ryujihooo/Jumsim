<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.DBConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>
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
<%
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}else if (session.getAttribute("userID") == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");	
	}

	Connection con = null;
	PreparedStatement pstmt = null;
	
	int n = 0;
	
	try{
		con = DBConnection.getCon();
		String sql = "delete from user where userID=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,userID);
		
		n = pstmt.executeUpdate();
		
	} catch(SQLException se){
		System.out.println(se.getMessage());
	} finally{
		if(pstmt != null) {pstmt.close();}
		if(con != null) {con.close();}
	}
	
	session.invalidate();
%>

	<script>
		alert('탈퇴 되었습니다.');
		location.href = "main.jsp";
	</script>

</body>
</html>