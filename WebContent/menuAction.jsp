<%@page import="java.io.PrintWriter"%>
<%@page import="menu.MenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="menu" class="menu.Menu" scope="page" />
<jsp:setProperty name="menu" property="menuName" />
<jsp:setProperty name="menu" property="menuPrice" />
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
		String shID = request.getParameter("shopID");
		int shopID = Integer.parseInt(shID);
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{
			// 입력이 안 된 부분이 있는지 체크한다
			if(menu.getMenuName() == null || menu.getMenuPrice() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
				MenuDAO menuDAO = new MenuDAO();
				int result = menuDAO.write(shopID, menu.getMenuName(), menu.getMenuPrice()); //shopID =1인거 수정
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
					script.println("alert('메뉴 추가 성공')");
					script.println("location.href='myShop.jsp'");
					script.println("</script>");
				}
			}	
		}

%>
</body>
</html>