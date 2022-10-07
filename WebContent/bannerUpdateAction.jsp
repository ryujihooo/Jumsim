<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.DBConnection" %>

<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("utf-8"); %>
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
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%@include file="header.jsp"%>
	<%
	request.setCharacterEncoding("UTF-8");
	
	//유저아이디
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
	//배너아이디
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

	if(request.getParameter("bannerName") == null || request.getParameter("bannerImage") == null
		|| request.getParameter("bannerName").equals("") || request.getParameter("bannerImage").equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('"+request.getParameter("bannerImage")+"')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		// 정상적으로 입력이 되었다면 글 수정 로직을 수행한다
		BannerDAO bannerDAO = new BannerDAO();
		int result = bannerDAO.update(bannerID, request.getParameter("bannerName"), request.getParameter("linkURL"), request.getParameter("bannerImage"),  request.getParameter("bannerReflect"));
		// 데이터베이스 오류인 경우
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('배너 수정에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		// 글 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 성공')");
			script.println("location.href='bannerList.jsp'");
			script.println("</script>");
		}
	}

	%>
</body>
</html>