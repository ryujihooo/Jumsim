<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="sales.SalesDAO" %>
<%@ page import="sales.Sales" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="sales" class="sales.SalesDAO" scope="page" />
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
		int pageNumber = 1; //기본은 1 페이지를 할당
		// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면
		// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNumber'변수에 저장한다
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
%>
<script src="js/Chart.js"></script>
<%
SalesDAO salesDAO = new SalesDAO(); // 인스턴스 생성
ArrayList<Sales> list = salesDAO.getList();
%>

<body> 
	<div class="container"> 
			<div class="col-lg-6"> 
				<div class="card"> 
					<div class="card-body"> 
						<canvas id="myChart2" width=outo height=outo></canvas> 
					</div> 
					<div class="card card-body text-center bg-primary"> 
					</div> 
				</div> 
			</div> 
		</div> 
	</div> 
	<!-- 부트스트랩 --> 
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> 
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> 
	<!-- 차트 --> 
	<script> 
	data = { 
			datasets: [{ 
				backgroundColor: ['red','yellow','blue'], 
				data: [10, 20, 30] 
			}], 
			// 라벨의 이름이 툴팁처럼 마우스가 근처에 오면 나타남 
			labels: ['red','yellow','blue'] 
	}; 
	
	// 도넛형 차트 
	var ctx2 = document.getElementById("myChart2"); 
	var myDoughnutChart = new Chart(ctx2, { 
		type: 'doughnut', 
		data: data, 
		options: {} 
	}); 
	</script> 
</body> 

</html>

