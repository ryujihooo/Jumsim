<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
<%@ page import="java.util.ArrayList" %>
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
	
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<%						
			ReviewDAO reviewDAO = new ReviewDAO(); // 인스턴스 생성
			ArrayList<Review> list = reviewDAO.getList(pageNumber, shopID);
			
			double StarSum = 0;
			double ReviewSum = 0;
			double average = 0;
			for (int i = 0; i < list.size(); i++){
				StarSum += (double)list.get(i).getReviewStar();
				ReviewSum++;
			}
			average= StarSum/ReviewSum;
			String average2 = String.format("%.1f", average);
			%>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;" colspan="4"><h4>평점: <%= average2 %> / 5.0 </h4></th>
					</tr>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">별점</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">리뷰</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%
							if( list.get(i).getReviewStar() == 1 ){
						%>
								<img style="width: outo; height: 20px;" src="images/starrate/star1.png">
						<%
							}
							else if( list.get(i).getReviewStar() == 2 ){
						%>
								<img style="width: outo; height: 20px;" src="images/starrate/star2.png">
						<%
							}
							else if( list.get(i).getReviewStar() == 3 ){
						%>
								<img style="width: outo; height: 20px;" src="images/starrate/star3.png">
						<%
							}
							else if( list.get(i).getReviewStar() == 4 ){
						%>
								<img style="width: outo; height: 20px;" src="images/starrate/star4.png">
						<%
							}
							else if( list.get(i).getReviewStar() == 5 ){
						%>
								<img style="width: outo; height: 20px;" src="images/starrate/star5.png">
						<%
							}
						%></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getReviewContent() %></td>
						<td><%= list.get(i).getReviewDate().substring(0, 11) + list.get(i).getReviewDate().substring(11, 13) + "시"
							+ list.get(i).getReviewDate().substring(14, 16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
	
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>