package sales;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SalesDAO {

	private Connection conn;
	private ResultSet rs;
	
	//湲곕낯 �깮�꽦�옄
	public SalesDAO() {
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

	//�옉�꽦�씪�옄 硫붿냼�뱶
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
	
	
	
	//湲��벐湲� 硫붿냼�뱶
	public int write(int price) {
		String sql = "insert into sales values(?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, price);
			pstmt.setString(2, getDate());
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	//寃뚯떆湲� 由ъ뒪�듃 硫붿냼�뱶
	public ArrayList<Sales> getList(){
		String sql = "select * from sales order by saleDate desc";
		ArrayList<Sales> list = new ArrayList<Sales>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Sales sales = new Sales();
				sales.setPrice(rs.getInt(1));
				sales.setSaleDate(rs.getString(2));
				list.add(sales);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}