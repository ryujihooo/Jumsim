<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>.SIM</title>
</head>

<style type="text/css">
	a:link {text-decoration: none; color:#7A7A7A;}
	a:visited {text-decoration: none; color:#7A7A7A;}
	a:hover {text-decoration: none; color:black;}
	a:active {text-decoration: none; color:black;}
</style>

<body>   
	<%@include file="header.jsp"%>
    <%
   		if (session.getAttribute("shopID")==null){
    		String shopID= (String)request.getParameter("id");
  			session.setAttribute("shopID",shopID);
    	}
   
        String select = request.getParameter("pageChange");
 
        if (select == null) {
            select = "";
        }
        session.getAttribute("shopID");
    %>
 

 
 
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd"height="100%" width=100%>
        <tr>
            <td style="background-color: #eeeeee; width: 10%"><jsp:include page="myShopSideMenu.jsp" flush="false" /></td>
            <td style= "width: 90%">
            	<jsp:include page="<%=select%>" flush="false">
            		<jsp:param value="shopID" name="shopID"/>
            	</jsp:include>
            </td>
        </tr>
    </table>
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>