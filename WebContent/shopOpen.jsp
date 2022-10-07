<%@page import="java.io.PrintWriter"%>
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
<title>BBS</title>
<title>.SIM 가게개설</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

</head>
<body>
		<%@include file="header.jsp"%>
	<%
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		%>

		
<!-- 상점개설 양식 -->
	<div class="container">		<!-- 하나의 영역 생성 -->
		<div class="col-lg-4">	<!-- 영역 크기 -->
			<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="./shopRegister">
					<h3 style="text-align: center;">상점 개설</h3>
					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="대표자명" name="userName" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="상호명" name="shopName" maxlength="20">
					</div>
					<div class="input-group">
						 <input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호" name="shopPostNum" maxlength="20" readonly>
						 <span class="input-group-btn">
						       <button class="btn btn-default" onclick="sample6_execDaumPostcode()" type="button">번호 찾기</button>
						 </span>
					</div><!-- /input-group -->
					<div class="form-group">
						<input type="text" class="form-control" id="sample6_address" placeholder="사업자주소" name="shopAddress1" maxlength="20"readonly>
						<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소" name="shopAddress2" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="사업자등록번호" name="shopNum" maxlength="20">
					</div>
					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="운영시간" name="openHours" maxlength="50">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="휴무일" name="closedDay" maxlength="50">
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" placeholder="가게 전화번호" name="shopTel" maxlength="20">
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" placeholder="가게 소개" name="shopInformation" maxlength="500">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="매장 내 테이블 수" name="shopTable" maxlength="2">
					</div>
					<div style= "display:none">
						<input name="userID" value="<%=userID%>">
					</div>
								
					
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>				
					
					
					
					


					<input type="submit" class="btn btn-primary form-control" value="개설">
				</form>
			</div>
		</div>	
	</div>
	
	
	<!-- 회원가입 폼 끝 -->


	





	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>