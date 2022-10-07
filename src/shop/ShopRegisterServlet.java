package shop;
import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class ShopRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException , IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		String shopName = request.getParameter("shopName");
		String shopPostNum = request.getParameter("shopPostNum");
		String shopAddress1 = request.getParameter("shopAddress1");
		String shopAddress2 = request.getParameter("shopAddress2");
		String shopAddress = shopAddress1 + " " + shopAddress2;
		String shopNum = request.getParameter("shopNum");
		String openHours = request.getParameter("openHours");
		String closedDay = request.getParameter("closedDay");
		String shopTel = request.getParameter("shopTel");
		String shopInformation = request.getParameter("shopInformation");
		String shopTable = request.getParameter("shopTable");
		String userID = request.getParameter("userID");
		
		if(userName == null || userName.equals("") || shopName == null || shopName.equals("")
				|| shopPostNum == null || shopPostNum.equals("")|| shopAddress1 == null || shopAddress1.equals("")
				|| shopAddress2 == null || shopAddress2.equals("") || shopNum==null||shopNum.equals("")
				|| openHours == null || openHours.equals("")||closedDay == null || closedDay.equals("")
				|| shopTel == null || shopTel.equals("") || shopInformation == null || shopInformation.equals("")) {

			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","모든 내용을 입력하세요");
			//System.out.println("모든 내용을 입력하세요");
			response.sendRedirect("shopOpen.jsp");
			return;
		}

		//테이블
		if(!isNan(shopTable)) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","매장 내 테이블 갯수는 숫자만 입력가능합니다.");
			//System.out.println("매장 내 테이블 갯수는 숫자만 입력가능합니다.");
			response.sendRedirect("shopOpen.jsp");
			return;
		}
		//전화번호
		if(!isNan(shopTel)) {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","전화번호는 - 제외한 숫자만 입력해주세요.");
			//System.out.println("전화번호는 - 제외한 숫자만 입력해주세요.");
			response.sendRedirect("shopOpen.jsp");
			return;
		}
			
		int result = new ShopDAO().regist(userName,shopName,shopPostNum,shopAddress,shopNum,openHours,closedDay,shopTel,shopInformation,shopTable,userID);
		if (result == 1) {
			request.getSession().setAttribute("messageType","성공 메시지");
			request.getSession().setAttribute("messageContent","가게 개설에 성공하였습니다.");	
			//System.out.println("회원가입 성공");
			response.sendRedirect("main.jsp");
			return;
		}
		else {
			request.getSession().setAttribute("messageType","오류 메시지");
			request.getSession().setAttribute("messageContent","sql 에러입니다.");	
			//System.out.println("sql 에러입니다.");
			response.sendRedirect("shopOpen.jsp"); 	
			return;
		}
		
	}
	
	
	//숫자체크
	private boolean isNan(String str) {
		boolean result = true;
		if (str==null) { result = true; }
		for(char c : str.toCharArray()){
			if(!Character.isDigit(c)){ //숫자가 아닐 경우
				result = false;
			}
		}
		return result;
	}
}
		
