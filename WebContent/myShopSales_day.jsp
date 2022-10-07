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

<h4>
총매출:
<%
	String day=sales.getDate().substring(8, 10);
	int sum=0;
	for(int i = 0; i < list.size(); i++){
		if (list.get(i).getSaleDate().substring(8, 10).equals(day)){
			sum += (int)list.get(i).getPrice();
		}
	}
%>

<%=sum %>원
</h4>

<canvas id="myChart" width=outo height=outo></canvas>

<script>
var ctx = document.getElementById("myChart");
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
    	<%
		int sum1 = 0;
		int sum2 = 0;
		int sum3 = 0;
		int sum4 = 0;
		int sum5 = 0;
		int sum6 = 0;
		int time1 = 0;
		int time2 = 0;
		int time3 = 0;
		int time4 = 0;
		int time5 = 0;
		int time6 = 0;
		
		for(int i = 0; i < list.size() ; i++){
			if (list.get(0).getSaleDate().substring(11, 13).equals(list.get(i).getSaleDate().substring(11, 13)) && list.get(i).getSaleDate().substring(8, 10).equals(day)){
				sum1 += (int)list.get(i).getPrice();
			} else {
				time2=i;
				if(list.get(time2).getSaleDate().substring(11, 13).equals(list.get(i).getSaleDate().substring(11, 13)) && list.get(i).getSaleDate().substring(8, 10).equals(day)){
					sum2 += (int)list.get(i).getPrice();
				} else {
					time3=i;
					if(list.get(time3).getSaleDate().substring(11, 13).equals(list.get(i).getSaleDate().substring(11, 13)) && list.get(i).getSaleDate().substring(8, 10).equals(day)){
    					sum3 += (int)list.get(i).getPrice();
    				} else {
    					time4=i;
    					if(list.get(time4).getSaleDate().substring(11, 13).equals(list.get(i).getSaleDate().substring(11, 13)) && list.get(i).getSaleDate().substring(8, 10).equals(day)){
        					sum4 += (int)list.get(i).getPrice();
        				} else {
        					time5=i;
        					if(list.get(time5).getSaleDate().substring(11, 13).equals(list.get(i).getSaleDate().substring(11, 13)) && list.get(i).getSaleDate().substring(8, 10).equals(day)){
            					sum5 += (int)list.get(i).getPrice();
            				} else {
            					time6=i;
            					if(list.get(time6).getSaleDate().substring(11, 13).equals(list.get(i).getSaleDate().substring(11, 13)) && list.get(i).getSaleDate().substring(8, 10).equals(day)){
                					sum6 += (int)list.get(i).getPrice();
                				}
            				}
        				}
    				}
				}
			}
		}
		String time11=list.get(time1).getSaleDate().substring(11, 13);
		String time22=list.get(time2).getSaleDate().substring(11, 13);
		String time33=list.get(time3).getSaleDate().substring(11, 13);
		String time44=list.get(time4).getSaleDate().substring(11, 13);
		String time55=list.get(time5).getSaleDate().substring(11, 13);
		String time66=list.get(time6).getSaleDate().substring(11, 13);
    	%>
    		
        labels: [<%= time11 %>+"시", 
        	<%= time22 %>+"시",
        	<%= time33 %>+"시",
        	<%= time44 %>+"시",
        	<%= time55 %>+"시",
        	<%= time66 %>+"시"],
        datasets: [{
            label: '# 매출',
            data: [<%= sum1 %>,
            	<%= sum2%>,
            	<%= sum3%>,
            	<%= sum4%>,
            	<%= sum5%>,
            	<%= sum6%>],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});

var myBarChart = new Chart(ctx, {


    type: 'bar',

    data: data,

    options: options

});
</script>



	


	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>