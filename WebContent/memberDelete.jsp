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
<%
	Connection con = null;
	PreparedStatement pstmt = null;
	
	String userID = request.getParameter("userID");
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
	response.sendRedirect("memberManagement.jsp");
%>

</body>
</html>