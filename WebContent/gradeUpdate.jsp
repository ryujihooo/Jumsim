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
	request.setCharacterEncoding("euc-kr");
	String userId = request.getParameter("userID");
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		con = DBConnection.getCon();
		String sql = "select * from user where userID = ?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,userId);
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		String userPassword = rs.getString("userPassword");
		String nickName = rs.getString("nickName");
		String userName = rs.getString("userName");
		String birthday = rs.getString("birthday");
		String address = rs.getString("address");
		String postNum = rs.getString("postNum");
		String email = rs.getString("email");
		String MemberGrade = rs.getString("MemberGrade");
		String UserPhone = rs.getString("UserPhone");
		String UserGender = rs.getString("UserGender");
		String regDate = rs.getString("regDate");
		String point = rs.getString("point");
%>

<div class="container">
<form name='userInfo' method='post' action='gradeUpdateAction.jsp'>
<table style="text-align: center; border: 1px solid #dddddd; width:100%">
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">아이디</td>
		<td><%=userId %><input type="hidden" name="userID" value="<%=userId %>"/></td>
	</tr>
	
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">비밀번호</td>
		<td><%=userPassword %><input type="hidden" name="userPassword" value="<%=userPassword %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">별명</td>
		<td><%=nickName %><input type="hidden" name="nickName" value="<%=nickName %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">이름</td>
		<td><%=userName %><input type="hidden" name="userName" value="<%=userName %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">생일</td>
		<td><%=birthday %><input type="hidden" name="birthday" value="<%=birthday %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">주소</td>
		<td><%=address %><input type="hidden" name="address" value="<%=address %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">우편번호</td>
		<td><%=postNum %><input type="hidden" name="postNum" value="<%=postNum %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">이메일</td>
		<td><%=email %><input type="hidden" name="email" value="<%=email %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">등급</td>
		<td><input type="text" name="MemberGrade" value=<%=MemberGrade %>></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">휴대전화</td>
		<td><%=UserPhone %><input type="hidden" name="UserPhone" value="<%=UserPhone %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">성별</td>
		<td><%=UserGender %><input type="hidden" name="UserGender" value="<%=UserGender %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">가입날짜</td>
		<td><%=regDate %><input type="hidden" name="regDate" value="<%=regDate %>"/></td>
	</tr>
	<tr>
		<td style="background-color: #eeeeee; text-align: center;">포인트</td>
		<td><%=point %><input type="hidden" name="point" value="<%=point %>"/></td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
		<input type="button" name="save" value="저장" onclick="javascript:userInfo.submit();"/>
		<input type="button" name="list" value="목록" onclick="javascript:location.href='memberManagement.jsp';"/>
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
		document.gradeUpdateAction.submit();
	}
	function list(){
		location.href="memberManagement.jsp"
	}
</script>

</body>
</html>