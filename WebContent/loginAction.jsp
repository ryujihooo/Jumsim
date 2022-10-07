<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<title>JSP 게시판 웹 사이트</title>
</head>
<body>

       <!-- 모달창 -->
            <div class="modal fade" id="defaultModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">알림</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            <!--// 모달창 -->

	<%
		//현재 세션을 확인한다.
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String)session.getAttribute("userID");
		}
		//이미 로그인하면 못하도록.
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
	
	
		String msg = "";
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){
			PrintWriter script = response.getWriter();
			session.setAttribute("userID",user.getUserID());
			script.println("<script>");
			script.println("alert('로그인 성공')");
			//script.println("modalContents.text('로그인성공');");
			//script.println("modal.modal('show');");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else if(result == 0){
			//PrintWriter script = response.getWriter();
			//script.println("<script>");
			//script.println("alert('비밀번호가 틀립니다')");
			//script.println("history.back()");
			//script.println("</script>");
			msg = "login.jsp?msg=0";
			response.sendRedirect(msg);
		}else if(result == -1){
			//PrintWriter script = response.getWriter();
			//script.println("<script>");
			//script.println("alert('존재하지 않는 아이디입니다')");
			//script.println("history.back()");
			//script.println("</script>");
			msg = "login.jsp?msg=-1";
			response.sendRedirect(msg);
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		
	%>
	



	
	
</body>
</html>