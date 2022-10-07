package user;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
//import java.text.SimpleDateFormat;
//import java.util.Date;





public class UserDAO {
    private Connection conn;   //�뜲�씠�꽣踰좎씠�뒪�뿉 �젒洹쇳븯湲� �쐞�븳 媛앹껜
    private PreparedStatement pstmt;  
    private ResultSet rs;   //�젙蹂대�� �떞�쓣 �닔 �엳�뒗 蹂��닔瑜� �깮�꽦
    
    public UserDAO() {
        try {
            //�깮�꽦�옄
            String dbURL="jdbc:mysql://52.78.34.134:3306/kiosk?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&characterEncoding=utf-8";
            String dbID="hangyu";
            String dbPassword="ab1415";
            Class.forName("com.mysql.jdbc.Driver"); 
            conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql); //sql荑쇰━臾몄쓣 ��湲� �떆�궓�떎
			pstmt.setString(1, userID); //泥ル쾲吏� '?'�뿉 留ㅺ컻蹂��닔濡� 諛쏆븘�삩 'userID'瑜� ���엯
			rs = pstmt.executeQuery(); //荑쇰━瑜� �떎�뻾�븳 寃곌낵瑜� rs�뿉 ���옣
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //濡쒓렇�씤 �꽦怨�
				}else
					return 0; //鍮꾨�踰덊샇 ��由�
			}
			return -1; //�븘�씠�뵒 �뾾�쓬
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //�삤瑜�
	}
	public int registerCheck(String userID) {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM user WHERE userID=?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,userID);
				rs = pstmt.executeQuery();
				if (rs.next()||userID.equals("")) {
					//System.out.println(rs.next());
					//System.out.println(userID);
					return 0; // �씠誘� 議댁옱 �쉶�썝
				}
				else
				{
					return 1; // 媛��엯 媛��뒫
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				try {
					if( rs!= null) rs.close();
					if (pstmt != null) pstmt.close();
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return -1; // �뜲�씠�꽣 踰좎씠�뒪 �삤瑜�
			
		
		
	}
	
	public String getDate() {
		String sql = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}	
	
	public String stringToDate(String birthday){
		String year = birthday.substring(0,4);
		String month = birthday.substring(4,6);
		String day = birthday.substring(6);
		//Date date = Date.valueOf(year+"-"+month+"-"+day);
		String date = year + "-" + month + "-" + day; 
        
        return date;   
    }



	
	
	
	
	public int regist(String userID,String userPassword,String userName,String nickName,String userGender,String userEmail,String userTel,String postNum,String userAddress,String userBirthday) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO user VALUES(null,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		//String SQL = "INSERT INTO USER(userID,userPassword,nickName,userName,birthday,address,postNum,email,MemberGrade,UserPhone,UserGender,RegDate,point) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		// id瑜� auto-increment�빐�꽌 sql臾몄씠 湲몄뼱吏� 異뷀썑 �뀒�씠釉� 援ъ“瑜� 蹂�寃쏀빐�빞�븿. ==> 2021.05.04 援ъ“ 蹂�寃쎌셿猷�
		
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, nickName);
			pstmt.setString(4, userName);
			pstmt.setString(5, stringToDate(userBirthday)); // 臾몄옄�뿴�쓣 date �삎�떇�쑝濡� 蹂�寃쏀빐�꽌 蹂대깂
			pstmt.setString(6, userAddress);
			pstmt.setString(7, postNum);
			pstmt.setString(8, userEmail);
			pstmt.setString(9, "1"); // membergrade "湲곕낯�쓣 1濡�"
			pstmt.setString(10, userTel);
			pstmt.setString(11, userGender);
			pstmt.setString(12, getDate()); // �삤�뒛�쓽 �궇吏� �엯�젰
			pstmt.setString(13, "0"); // �룷�씤�듃�뒗 "0"�쑝濡� 吏��젙, �떆媛꾩씠 �깮湲곕㈃ 愿�由ъ옄 �솃�럹�씠吏� �뿰�룞
			return pstmt.executeUpdate(); //�쉶�썝 �뾾�쓣 寃쎌슦 0
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if( rs!= null) rs.close();
				if (pstmt != null) pstmt.close();
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // �뜲�씠�꽣 踰좎씠�뒪 �삤瑜�
		
	
	
}
}
