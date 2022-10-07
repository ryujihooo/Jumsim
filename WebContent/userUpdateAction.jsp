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
	request.setCharacterEncoding("UTF-8");

	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
	String nickName = request.getParameter("nickName");
	String userName = request.getParameter("userName");
	String birthday = request.getParameter("birthday");
	String address = request.getParameter("address");
	String postNum = request.getParameter("postNum");
	String email = request.getParameter("email");
	String UserPhone = request.getParameter("UserPhone");
	String UserGender = request.getParameter("UserGender");

	Connection con = null;
	PreparedStatement pstmt = null;
	String sql = "update user set userPassword=?, nickName=?, userName=?, birthday=?, address=?, postNum=?, email=?, UserPhone=?, UserGender=? where userID=?";
	int n = 0;
	
	try{
		con = DBConnection.getCon();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userPassword);
		pstmt.setString(2, nickName);
		pstmt.setString(3, userName);
		pstmt.setString(4, birthday);
		pstmt.setString(5, address);
		pstmt.setString(6, postNum);
		pstmt.setString(7, email);
		pstmt.setString(8, UserPhone);
		pstmt.setString(9, UserGender);
		pstmt.setString(10, userID);
		n = pstmt.executeUpdate();
	} catch(SQLException se){
		System.out.println(se.getMessage());
	} finally{
		try{
			if(pstmt != null) {pstmt.close();}
			if(con != null) {con.close();}
		} catch(SQLException se){
			System.out.println(se.getMessage());
		}
	}
%>

<script type="text/javascript">
	alert('수정 되었습니다.');
	location.href="userUpdate.jsp";

</script>

</body>
</html>