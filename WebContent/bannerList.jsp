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
		
<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">배너명</th>
						<th style="background-color: #eeeeee; text-align: center;">반영여부</th>
					</tr>
				</thead>
				<tbody>
					<%
						BannerDAO bannerDAO = new BannerDAO(); // 인스턴스 생성
						ArrayList<Banner> list = bannerDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBannerID() %></td>
						<!-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
						<td><a href="bannerView.jsp?bannerID=<%= list.get(i).getBannerID() %>">
							<%= list.get(i).getBannerName() %></a></td>
						<td><%= list.get(i).getBannerReflect() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
			<!-- 페이징 처리 영역 -->
			<%
				if(pageNumber != 1){
			%>
				<a href="bannerList.jsp?pageNumber=<%=pageNumber - 1 %>"
					class="btn btn-success btn-arraw-left">이전</a>
			<%
				}if(bannerDAO.nextPage(pageNumber + 1)){
			%>
				<a href="bannerList.jsp?pageNumber=<%=pageNumber + 1 %>"
					class="btn btn-primary btn-arraw-left" >다음</a>
			<%
				}
			%>
			
			<!-- 글쓰기 버튼 생성 -->
			<a href="bannerAdd.jsp" class="btn btn-primary pull-right">배너 추가</a>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
					



	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>