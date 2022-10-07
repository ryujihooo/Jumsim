<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.DBConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page import="shop.Shop" %>
<%@ page import="shop.ShopDAO" %>

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
	} else if(userID.equals("admin")) {
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자 로그인이 필요합니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	int shopID = 1;
	// 유효한 글이라면 구체적인 정보를 'bbs'라는 인스턴스에 담는다
	Shop shop = new ShopDAO().getshop(shopID);
	
	%>
	


<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" action="bannerUpdate.jsp?bannerID=<%= bannerID %>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">배너 추가</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">배너명</td>
							<td><%=banner.getBannerName() %></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">링크URL</td>
							<td><%=banner.getLinkURL() %></td>
						</tr>
						<tr>
							<td rowspan="2" style="background-color: #eeeeee; text-align: center;">배너이미지</td>
							<td><%=banner.getBannerImage() %></td>
						</tr>
						<tr>
							<td><img src="Upload/<%= banner.getBannerImage() %>" width=outo height="100"></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">반영여부</td>
							<td><%=banner.getBannerReflect()%></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="수정하기">
				<input type="button" name="delete2" class="btn btn-primary pull-right" value="삭제하기" onclick="javascript:location.href='bannerDelete.jsp?bannerID=<%= bannerID %>';"/>
				<input type="button" name="list" class="btn btn-primary pull-center" value="목록" onclick="javascript:location.href='bannerList.jsp';"/>
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
				

<script type="text/javascript">
	function update(){
		location.href="bannerList.jsp"
	}
	function delete2(){
		location.href="bannerDelete.jsp"
	}
</script>



	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>