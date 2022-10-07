<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.DBConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP JSW 게시판 웹사이트 </title>
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

	request.setCharacterEncoding("UTF-8");
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		con = DBConnection.getCon();
		String sql = "select * from user where userID = ?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,userID);
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		String userPassword = rs.getString("userPassword");
		String nickName = rs.getString("nickName");
		String userName = rs.getString("userName");
		String birthday = rs.getString("birthday");
		String address = rs.getString("address");
		String postNum = rs.getString("postNum");
		String email = rs.getString("email");
		String UserPhone = rs.getString("UserPhone");
		String UserGender = rs.getString("UserGender");
%>

<div class="container">
<form name='myInfo' method='post' action='userUpdateAction.jsp'>
<h4 style="text-align: center"> 내 정보</h4>
<table style="text-align: center; border: 1px solid #dddddd; width: 70%; margin:auto;">
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">아이디</td>
		<td><%=userID %><input type="hidden" style="width:95%" name="userID" value="<%=userID %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">비밀번호</td>
		<td><input type="text" style="width:95%" name="userPassword" value=<%=userPassword %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">별명</td>
		<td><input type="text" style="width:95%" name="nickName" value=<%=nickName %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">이름</td>
		<td><input type="text" style="width:95%" name="userName" value=<%=userName %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">생일</td>
		<td><input type="text" style="width:95%" name="birthday" value=<%=birthday %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">주소</td>
		<td><input type="text" style="width:95%" name="address" value="<%=address %>"></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">우편번호</td>
		<td><input type="text" style="width:95%" name="postNum" value=<%=postNum %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">이메일</td>
		<td><input type="email" style="width:95%" name="email" value=<%=email %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">휴대전화</td>
		<td><input type="tel" style="width:95%" name="UserPhone" value=<%=UserPhone %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">성별</td>
		<td>	
			<select name="UserGender">
				<option value="남자" <%="남자".equals(UserGender)?"selected":"" %>>남자</option>
				<option value="여자" <%="여자".equals(UserGender)?"selected":"" %>>여자</option>
					
			</select>
			<p>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
		<input type="button" name="update" class="btn btn-primary pull-center" value="수정" onclick="javascript:myInfo.submit();"/>
		<input type="button" name="delete2" class="btn btn-primary pull-center" value="탈퇴" onclick="javascript:location.href='userDelete.jsp';"/>
		</td>
	</tr>
</table>
</form>
</div>				
<%	
		}
	} catch(SQLException se){
		System.out.println(se.getMessage());
	} finally{
		try{
			if(rs != null) {rs.close();}
			if(pstmt != null) {pstmt.close();}
			if(con != null) {con.close();}
		} catch(SQLException se){
			System.out.println(se.getMessage());
		}
	}
%>

<script type="text/javascript">
	function update(){
		document.userUpdateAction.submit();
	}
	function delete2(){
		location.href="userDelete.jsp"
	}
</script>

</body>
</html>