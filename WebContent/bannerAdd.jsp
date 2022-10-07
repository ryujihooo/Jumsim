<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="banner.BannerDAO" %>
<%@ page import="banner.Banner" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/slideshow.css">
<title>.SIM</title>
</head>
<body>
	<%@include file="header.jsp"%>
	<%
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	} 
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	} else if(userID.equals("admin")) {
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자 로그인이 필요합니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	%>
		
<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" action="bannerAddAction.jsp" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">배너 추가</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">배너명</td>
							<td><input type="text" class="form-control" name="bannerName" maxlength="50"></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">링크URL</td>
							<td><input type="text" class="form-control" name="linkURL" maxlength="50"></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">배너이미지</td>
							<td><input type="file" name="bannerImage" accept=".gif, .jpg, .png" class="form-control" ></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">반영여부</td>
							<td>
								<select name="bannerReflect" class="form-control">
									<option value="Y" selected>Y</option>
									<option value="N">N</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="저장">
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
					



	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>