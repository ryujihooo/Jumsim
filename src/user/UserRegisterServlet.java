package user;
import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException , IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		String userPasswordCheck = request.getParameter("userPasswordCheck");
		String userName = request.getParameter("userName");
		String nickName = request.getParameter("nickName");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userTel = request.getParameter("userTel");
		String postNum = request.getParameter("postNum");
		String userAddress1 = request.getParameter("userAddress1");
		String userAddress2 = request.getParameter("userAddress2");
		String userBirthday = request.getParameter("userBirthday");
		String userAddress = userAddress1 + " " + userAddress2;
		
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("")
				|| userPasswordCheck == null || userPasswordCheck.equals("")|| userName == null || userName.equals("")
				|| nickName == null || nickName.equals("") || userGender==null||userGender.equals("")
				|| userEmail == null || userEmail.equals("")||userTel == null || userTel.equals("")
				|| postNum == null || postNum.equals("")||userAddress1 == null || userAddress1.equals("")
				|| userAddress2 == null || userAddress2.equals("")||userBirthday == null||userBirthday.equals("")) {

			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","모든 내용을 입력하세요");
			//System.out.println("모든 내용을 입력하세요");
			response.sendRedirect("join.jsp");
			return;
		}
		
		//비밀번호
		if(!isPasswd(userPassword)) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","비밀번호는 숫자,영문,특수문자를 포함하여 8자리 이상으로 설정해주세요.");
			//System.out.println("생년월일은 숫자만 입력가능합니다.");
			response.sendRedirect("join.jsp");
			return;
		}
		if(!userPassword.equals(userPasswordCheck) ) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","비밀번호가 서로 일치하지 않습니다.");
			//System.out.println("비밀번호가 서로 일치하지 않습니다.");
			response.sendRedirect("join.jsp");
			return;
		}
		
		//생년월일
		if(!isNan(userBirthday)) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","생년월일은 숫자만 입력가능합니다.");
			//System.out.println("생년월일은 숫자만 입력가능합니다.");
			response.sendRedirect("join.jsp");
			return;
		}
		if(userBirthday.length() != 8 ) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","생년월일은 8자로 입력해주세요");
			//System.out.println("생년월일은 8자로 입력해주세요");
			response.sendRedirect("join.jsp");
			return;
		}
		
		//전화번호
		if(!isNan(userTel)) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","전화번호는 - 제외한 숫자만 입력해주세요.");
			//System.out.println("전화번호는 - 제외한 숫자만 입력해주세요.");
			response.sendRedirect("join.jsp");
			return;
		}
		if(userTel.length() != 11) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","전화번호를 다시 확인해주세요.(아직이거11자린지만ㅠ)");
			//System.out.println("전화번호를 다시 확인해주세요.");
			response.sendRedirect("join.jsp");
			return;
		}
		
		
		int result = new UserDAO().regist(userID,userPassword,userName,nickName,userGender,userEmail,userTel,postNum,userAddress,userBirthday);
		if (result == 1) {
			request.getSession().setAttribute("messageType","성공 메시지");
			request.getSession().setAttribute("messageContent","회원가입에 성공하였습니다.");	
			//System.out.println("회원가입 성공");
			response.sendRedirect("join.jsp");
			return;
		}
		else {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","sql 에러입니다.");	
			//System.out.println("sql 에러입니다.");
			response.sendRedirect("join.jsp"); 	
			return;
		}
	
	}

	//비밀번호 조건
	private boolean isPasswd(String str) {
		boolean result = true;
		if(Pattern.matches("^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z[0-9]$@$!%*#?&]{8,}$", str)) {
			result =  true;
		}
		else { result = false; }
		return result;
	}
	
	//생일, 전화번호 숫자체크
	private boolean isNan(String str) {
		boolean result = true;
		for(char c : str.toCharArray()){
			if(!Character.isDigit(c)){ //숫자가 아닐 경우
				result = false;
			}
		}
		return result;
	}
	
	

}
