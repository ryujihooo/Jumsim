<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="menu.MenuDAO" %>
<%@ page import="menu.Menu" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.DBConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<jsp:useBean id="shop" class="shop.Shop" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<title>MENU</title>

<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/slideshow.css">


<!-- ajax를 시작 -->
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		String shID = request.getParameter("shopID");
		int shopID = Integer.parseInt(shID);
		
		int pageNumber = 1; //기본은 1 페이지를 할당
		// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면
		// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNumber'변수에 저장한다
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		
	%>
	


	
<!-- 메뉴 추가 양식 -->
	<div class="container">		<!-- 하나의 영역 생성 -->
		<div class="col-lg-4">	<!-- 영역 크기 -->
			<form method="post" action="menuAction.jsp" >
				<div class="form-group" style="float:left; width:35%;">
					<input type="text" class="form-control" placeholder="이름" name="menuName" maxlength="20">
				</div>
				<div class="form-group" style="float:left; width:35%;">
					<input type="text" class="form-control" placeholder="가격" name="menuPrice" maxlength="20">
				</div>
				<div class="form-group" style="float:left; width:30%;">
					<p><input type="submit"class="btn btn-dark" value="메뉴 추가" >
				</div>
				<div style= "display:none">
					<input name="shopID" value="<%= shopID %>">
				</div>						
			</form>
		</div>	
	</div>
	
<!-- 메뉴 리스트 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
					<p><h3>MENU LIST</h3>
						<th style="background-color: #eeeeee; width: 40%; text-align: center;">이름</th>
						<th style="background-color: #aaaaaa; width: 40%; text-align: center;">가격</th>
					</tr>
				</thead>
				<tbody>
					<tbody>
					<%
						MenuDAO menuDAO = new MenuDAO(); // 인스턴스 생성
						ArrayList<Menu> list = menuDAO.getList(pageNumber, shopID);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getMenuName() %></td>
						<td><%= list.get(i).getMenuPrice() + "원" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
				</tbody>
			</table>
			
		</div>
	</div>
	<!-- 메뉴 리스트 영역 끝 -->
	
	<!-- 페이징 처리 영역 -->
			<%
				if(pageNumber != 1){
			%>
				<a href="menu.jsp?pageNumber=<%=pageNumber - 1 %>"
					class="btn btn-success btn-arraw-left">이전</a>
			<%
				}if(menuDAO.nextPage(pageNumber + 1)){
			%>
				<a href="menu.jsp?pageNumber=<%=pageNumber + 1 %>"
					class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

	
</body>
</html>