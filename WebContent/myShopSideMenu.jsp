<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 
    <%
        String pageChange;
    %>
    <div class="collapse navbar-collapse">
		<a href="?pageChange=review.jsp?shopID=<%= session.getAttribute("shopID") %>">리뷰</a>
    	<br>
    	<br>
   		<a href="?pageChange=menu.jsp?shopID=<%= session.getAttribute("shopID") %>">메뉴</a>
   		<br>
   		<br>
   		<a href="?pageChange=myShopInfo.jsp?shopID=<%= session.getAttribute("shopID") %>">가게 정보</a>
   		<br>
   		<br>
   		매출통계
   		<br><a href="?pageChange=myShopSales_day.jsp">- 오늘</a>
   		<br><a href="?pageChange=myShopSales_month.jsp">- 월간</a>
   		<br><a href="?pageChange=myShopSales_menu.jsp">- 메뉴별</a>
   	</div>
</body>
</html>

