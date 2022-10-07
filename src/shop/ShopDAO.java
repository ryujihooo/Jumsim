package shop;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;
import menu.Menu;

import java.sql.Date;
//import java.text.SimpleDateFormat;
//import java.util.Date;





public class ShopDAO {
    private Connection conn;   //�뜲�씠�꽣踰좎씠�뒪�뿉 �젒洹쇳븯湲� �쐞�븳 媛앹껜
    private PreparedStatement pstmt;  
    private ResultSet rs;   //�젙蹂대�� �떞�쓣 �닔 �엳�뒗 蹂��닔瑜� �깮�꽦
    
    public ShopDAO() {
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

	
	public int regist(String userName,String shopName,String shopPostNum,String shopAddress,String shopNum,String openHours,String closedDay,String shopTel,String shopInformation, String shopTable, String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO shop VALUES(null,?,?,?,?,?,?,?,?,?,?,?)";

		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, shopName);
			pstmt.setString(3, shopPostNum);
			pstmt.setString(4, shopAddress);
			pstmt.setString(5, shopNum);
			pstmt.setString(6, openHours);
			pstmt.setString(7, closedDay);
			pstmt.setString(8, shopTel);
			pstmt.setString(9, shopInformation);
			pstmt.setString(10, shopTable);
			pstmt.setString(11, userID);
			return pstmt.executeUpdate();
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
	
	public String myShop(String userID) {
		String sql = "select shopName from shop where userID=?";
		try {
			pstmt = conn.prepareStatement(sql); //sql荑쇰━臾몄쓣 ��湲� �떆�궓�떎
			pstmt.setString(1, userID); 
			rs = pstmt.executeQuery(); //荑쇰━瑜� �떎�뻾�븳 寃곌낵瑜� rs�뿉 ���옣
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	//寃뚯떆湲� 由ъ뒪�듃 硫붿냼�뱶
	public ArrayList<Shop> getList(String userID){
		String sql = "select * from shop where userID = ?";
		ArrayList<Shop> list = new ArrayList<Shop>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Shop shop = new Shop();
				shop.setId(rs.getInt(1));
				shop.setShopName(rs.getString(3));
				list.add(shop);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
			//�븯�굹�쓽 寃뚯떆湲��쓣 蹂대뒗 硫붿냼�뱶
	public Shop getShop(int shopID) {
		String sql = "select * from shop where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shopID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Shop shop = new Shop();
				shop.setId(rs.getInt(1));
				shop.setUserName(rs.getString(2));
				shop.setShopName(rs.getString(3));
				shop.setShopPostNum(rs.getString(4));
				shop.setShopAddress(rs.getString(5));
				shop.setShopNum(rs.getString(6));
				shop.setOpenHours(rs.getString(7));
				shop.setClosedDay(rs.getString(8));
				shop.setShopTel(rs.getString(9));
				shop.setShopInformation(rs.getString(10));
				shop.setShopTable(rs.getString(11));
				shop.setUserID(rs.getString(12));
				return shop;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
