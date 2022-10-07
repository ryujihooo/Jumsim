<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="db.DBConnection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
    
<%@ page import="shop.ShopDAO" %>
<%@ page import="shop.Shop" %>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/star.css">
<title>.SIM</title>
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
		
		Shop shop = new ShopDAO().getShop(shopID);
	%>
	
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;"><h3><%=shop.getShopName() %></h3></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="background-color: #eeeeee; text-align: center; width: 30%">대표자명</td>
							<td><%=shop.getUserName() %></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center; width: 30%">사업자주소</td>
							<td><%=shop.getShopAddress() %></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center; width: 30%">사업자등록번호</td>
							<td><%=shop.getShopNum() %></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center; width: 30%">운영시간</td>
							<td><%=shop.getOpenHours()%></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center; width: 30%">휴무일</td>
							<td><%=shop.getClosedDay()%></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center; width: 30%">가게 전화번호</td>
							<td><%=shop.getShopTel()%></td>
						</tr>
						<tr>
							<td style="background-color: #eeeeee; text-align: center; width: 30%">가게 소개</td>
							<td><%=shop.getShopInformation()%></td>
						</tr>
					</tbody>
			</table>
			<input type="submit" class="btn btn-dark" value="수정하기">
			<input type="button" name="delete2" class="btn btn-dark pull-right" value="폐업"/>
		</div>
		</div>
	
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>