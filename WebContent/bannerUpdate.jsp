<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="db.DBConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page import="banner.Banner" %>
<%@ page import="banner.BannerDAO" %>
<%@page import="java.util.*"%>

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
	int bannerID = 0;
	if(request.getParameter("bannerID") != null){
		bannerID = Integer.parseInt(request.getParameter("bannerID"));
	}
	if(bannerID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않습니다')");
		script.println("location.href='bannerList.jsp'");
		script.println("</script>");
	}
	// 유효한 글이라면 구체적인 정보를 'bbs'라는 인스턴스에 담는다
	Banner banner = new BannerDAO().getBanner(bannerID);
	
	%>



<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" accept-charset="utf-8" action="bannerUpdateAction.jsp?bannerID=<%= bannerID %>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">배너 추가</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">배너명</td>
							<td colspan="2"><input type="text" class="form-control" name="bannerName" maxlength="50" value="<%=banner.getBannerName() %>"></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">링크URL</td>
							<td colspan="2"><input type="text" class="form-control" name="linkURL" maxlength="50" value="<%=banner.getLinkURL() %>"></td>
						</tr>
						<tr>
							<td rowspan="2" style="background-color: #eeeeee; text-align: center;" >배너이미지</td>
							<td><input type="text" name="bannerImage" class="form-control" value="<%=banner.getBannerImage() %>"></td>
						<%-- NULL나옴
							<td><input type="file" name="bannerImage" accept=".gif, .jpg, .png" class="form-control" value="<%=banner.getBannerImage() %>"></td>
						--%>
							<td><input type="hidden" name="bannerImage" value="<%=banner.getBannerImage() %>"></td>
						</tr>
						<tr>
							<td colspan="2"><img src="Upload/<%= banner.getBannerImage() %>" width=outo height="100"></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center;">반영여부</td>
							<td colspan="2">
							<input type="text" name="bannerReflect" class="form-control" value="<%=banner.getBannerReflect() %>">
							<%-- NULL나옴
								<select name="bannerReflection" class="form-control">
									<option value="Y" <%="Y".equals(banner.getBannerReflect() )?"selected":"" %>>Y</option>
									<option value="N" <%="N".equals(banner.getBannerReflect() )?"selected":"" %>>N</option>
								</select>
							--%>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="저장">
				<input type="button" name="list" class="btn btn-primary pull-center" value="목록" onclick="javascript:location.href='bannerList.jsp';"/>
				
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->

	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>