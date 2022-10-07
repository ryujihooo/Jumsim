<%@page import="java.io.PrintWriter"%>
<%@page import="sales.SalesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="sales" class="sales.Sales" scope="page" />
<jsp:setProperty name="sales" property="price" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>.SIM</title>
</head>
<body>
	<%
		SalesDAO salesDAO = new SalesDAO();
		int result = salesDAO.write(sales.getPrice());
		// 데이터베이스 오류인 경우
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메뉴 추가에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('결제완료')");
			script.println("location.href='sales.jsp'");
			script.println("</script>");
		}
%>
</body>
</html>