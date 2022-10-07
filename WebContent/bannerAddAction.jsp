<%@page import="java.io.PrintWriter"%>
<%@page import="banner.BannerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="banner.BannerDAO" %>
<%@ page import="banner.Banner" %>
<%@page import="java.io.File"%> 
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<jsp:useBean id="banner" class="banner.BannerDAO" />
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>.SIM</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
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
	
	
		 request.setCharacterEncoding("euc-kr");
		 String realFolder = "";
		 int maxSize = 1024*1024*5;
		 String encType = "UTF-8";
		 String savefile = "Upload";
		 ServletContext scontext = getServletContext();
		 realFolder = scontext.getRealPath(savefile);
		 MultipartRequest multi = null;
		 multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
		
		try {
			String bannerName = multi.getParameter("bannerName");
			String linkURL = multi.getParameter("linkURL");
			String bannerReflect = multi.getParameter("bannerReflect");
			
			String bannerImage = multi.getFilesystemName("bannerImage"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
			String orgBannerImage = multi.getOriginalFileName("bannerImage"); // name=file1의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)
			
			if(bannerName == null || bannerImage == null){
	            PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('배너명과 배너이미지는 필수입력사항입니다.')");
	            script.println("history.back()");
	            script.println("</script>");
	         }else{
	            // 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
				int result = banner.write(bannerName, linkURL, bannerImage, bannerReflect);
	            // 데이터베이스 오류인 경우
	            if(result == -1){
	               PrintWriter script = response.getWriter();
	               script.println("<script>");
	               script.println("alert('등록에 실패했습니다')");
	               script.println("history.back()");
	               script.println("</script>");
	            // 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
	            }else {
	               PrintWriter script = response.getWriter();
	               script.println("<script>");
	               script.println("alert('등록 성공')");
	               script.println("location.href='bannerList.jsp'");
	               script.println("</script>");
	            }
	         }
	
		} catch (Exception e) {
			
		} // 업로드 종료
		
		
		
	

		
	%>
</body>
</html>