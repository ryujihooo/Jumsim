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
<title>.SIM 회원가입</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/custom.css">

<!-- ajax를 시작 -->

 

	
<script type="text/javascript">
	function registerCheckFunction(){
		var userID = $('#userID').val();
		$.ajax({
			type : 'POST',
			url: './UserRegisterCheckServlet',
			data:{userID: userID},
			success: function(result){
				if (result==1){
					$('#checkMessage').html('사용할 수 있는 아이디입니다.');
					$('#checkType').attr('class','modal-content panel-success');
				}
				else{
					$('#checkMessage').html('사용할 수 없는 아이디입니다.');
					$('#checkType').attr('class','modal-content panel-warning');
				}
				$('#checkModal').modal("show");
			}
		})
	}
	function passwordCheckFunction(){
		var userPassword1 = $('#userPassword').val()
		var userPassword2 = $('#userPasswordCheck').val();
		if(userPassword1=="" && (userPassword1 != userPassword2||userPassword1 == userPassword2)){
			$("#userPasswordCheck").css("background-color","#FFCECEC");
		}
		else if(userPassword1 != userPassword2){
			$("#userPasswordCheck").css("background-color","#B0F6AC");
			
		}
		else{
			$("#userPasswordCheck").css("background-color","#FFCECE");
		}
	}

	
</script>







</head>
<body>
	<%@include file="header.jsp"%>
	<%
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
					
		}
	
	%>

		

	
<!-- 회원가입 양식 -->
	<div class="container">		<!-- 하나의 영역 생성 -->
		<div class="col-lg-4">	<!-- 영역 크기 -->
			<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="./userRegister">
					<h3 style="text-align: center;">회원가입</h3>
					
						
					<div class="input-group">
						 <input type="text" class="form-control" placeholder="아이디" name="userID" id="userID" maxlength="20">
						 <span class="input-group-btn">
						       <button class="btn btn-default" onclick="registerCheckFunction();"  type="button">중복확인</button>
						 </span>
					</div><!-- /input-group -->
					
					
					<div class="form-group">
						
					</div>
					<div class="form-group">
						<input type="password" class="form-control" onkeyup="passwordCheckFunction();" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" onkeyup="passwordCheckFunction();" placeholder="비밀번호 확인" name="userPasswordCheck" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="별명" name="nickName" maxlength="20">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일 ( abcd@naver.com)" name="userEmail" maxlength="20">
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" placeholder="연락처" name="userTel" maxlength="20">
					</div>
					<div class="input-group">
						 <input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호" name="postNum" maxlength="20" readonly>
						 <span class="input-group-btn">
						       <button class="btn btn-default" onclick="sample6_execDaumPostcode()" type="button">번호 찾기</button>
						 </span>
					</div><!-- /input-group -->
					
					
					<div class="form-group">
						<input type="text" class="form-control" id="sample6_address" placeholder="주소" name="userAddress1" maxlength="20"readonly>
						<input type="tel" class="form-control" id="sample6_detailAddress" placeholder="상세주소" name="userAddress2" maxlength="20">
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" placeholder="생년월일(19001231)" name="userBirthday" maxlength="20">
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
					
					
					
					


					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
			</div>
		</div>	
	</div>
	
	
	<!-- 회원가입 폼 끝 -->

	<!-- 모달 창 시작 -->
	<%
        String messageContent = null;
		
        if (session.getAttribute("messageContent") != null) {
            messageContent = (String) session.getAttribute("messageContent");
            
        }
        String messageType = null;
        if (session.getAttribute("messageType") != null) {
            messageType = (String) session.getAttribute("messageType");
        }
        if (messageContent != null) {
    %>
    <div class="modal fade" id="messageModal" tableindex="-1" role="dialog"
        aria-hidden="true">
        <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
            <div
                class="modal-content
               
                <%if (messageType.equals("오류 메시지"))
                    out.println("panel-warning");
                else
                    out.println("panel-success");%>">
                <div class="modal-header panel-heading">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span> <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title">
                        <%=messageType%>
                    </h4>
                </div>
                <div class="modal-body">
                    <%=messageContent%>
                </div>
                <div class= "modal-footer">
                	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
        </div>
    </div>
    <script>
    //div class안의 messageModal
        $('#messageModal').modal("show");
    </script>
    <%
    //다 끝나면 Attribute를 삭제해줘야함
     // if(mes)
			if(messageType.equals("성공 메시지")){
				session.setAttribute("userID","userID");
	        	session.removeAttribute("messageContent");
	        	session.removeAttribute("messageType");
	   
				response.sendRedirect("main.jsp");			
			}
       		
        	session.removeAttribute("messageContent");
        	session.removeAttribute("messageType");
        }
    %>


<!--  종복 체크를 위한 모달 -->
 <div class="modal fade" id="checkModal" tableindex="-1" role="dialog"
        aria-hidden="true">
        <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
            <div id="checkType" class="modal-content panel-info">
                <div class="modal-header panel-heading">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span> <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title">
                        확인 메시지
                    </h4>
                </div>
                <div class="modal-body" id="checkMessage">

                </div>
                <div class= "modal-footer">
                	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
        </div>
    </div>


	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>