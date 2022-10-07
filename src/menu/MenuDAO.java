package menu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class MenuDAO {

	private Connection conn;
	private ResultSet rs;
	
	//湲곕낯 �깮�꽦�옄
	public MenuDAO() {
		try {
            String dbURL="jdbc:mysql://52.78.34.134:3306/kiosk?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&characterEncoding=utf-8";
            String dbID="hangyu";
            String dbPassword="ab1415";
            Class.forName("com.mysql.jdbc.Driver"); 
            conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//寃뚯떆湲� 踰덊샇 遺��뿬 硫붿냼�뱶
	public int getNext() {
		//�쁽�옱 寃뚯떆湲��쓣 �궡由쇱감�닚�쑝濡� 議고쉶�븯�뿬 媛��옣 留덉�留� 湲��쓽 踰덊샇瑜� 援ы븳�떎
		String sql = "select menuID from menu order by menuID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //泥� 踰덉㎏ 寃뚯떆臾쇱씤 寃쎌슦
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	//湲��벐湲� 硫붿냼�뱶
	public int write(int shopID, String menuName, String menuPrice) {
		String sql = "insert into menu values(?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, shopID);
			pstmt.setString(3, menuName);
			pstmt.setString(4, menuPrice);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
			
	
	//寃뚯떆湲� 由ъ뒪�듃 硫붿냼�뱶
	public ArrayList<Menu> getList(int pageNumber, int shopID){
		String sql = "select * from menu where menuID < ? and shopID = ? order by menuID desc limit 10";
		ArrayList<Menu> list = new ArrayList<Menu>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setInt(2, shopID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Menu menu = new Menu();
				menu.setMenuID(rs.getInt(1));
				menu.setShopID(rs.getInt(2));
				menu.setMenuName(rs.getString(3));
				menu.setMenuPrice(rs.getString(4));
				list.add(menu);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	//�럹�씠吏� 泥섎━ 硫붿냼�뱶
	public boolean nextPage(int pageNumber) {
		String sql = "select * from menu where menuID";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//�븯�굹�쓽 寃뚯떆湲��쓣 蹂대뒗 硫붿냼�뱶
	public Menu getMenu(int menuID) {
		String sql = "select * from menu where shopID = 1"; //샵아이디 수정하기...
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, menuID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Menu menu = new Menu();
				menu.setMenuID(rs.getInt(1));
				menu.setMenuName(rs.getString(2));
				menu.setMenuPrice(rs.getString(3));
				return menu;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int menuID, String menuName, String menuPrice) {
		String sql = "update menu set menuName = ?, menuPrice = ? where menuID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, menuName);
			pstmt.setString(2, menuPrice);
			pstmt.setInt(3, menuID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	//寃뚯떆湲� �궘�젣 硫붿냼�뱶
	public int delete(int menuID) {
		//�떎�젣 �뜲�씠�꽣瑜� �궘�젣�븯�뒗 寃껋씠 �븘�땲�씪 寃뚯떆湲� �쑀�슚�닽�옄瑜� '0'�쑝濡� �닔�젙�븳�떎
		String sql = "update menu where menuID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, menuID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�뜲�씠�꽣踰좎씠�뒪 �삤瑜� 
	}
	
}