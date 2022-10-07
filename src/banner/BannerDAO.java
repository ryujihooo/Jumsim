package banner;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BannerDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	//疫꿸퀡�궚 占쎄문占쎄쉐占쎌쁽
	public BannerDAO() {
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
	
	//野껊슣�뻻疫뀐옙 甕곕뜇�깈 �겫占쏙옙肉� 筌롫뗄�꺖占쎈굡
	public int getNext() {
		//占쎌겱占쎌삺 野껊슣�뻻疫뀐옙占쎌뱽 占쎄땀�뵳�눘媛먲옙�떄占쎌몵嚥∽옙 鈺곌퀬�돳占쎈릭占쎈연 揶쏉옙占쎌삢 筌띾뜆占쏙쭕占� 疫뀐옙占쎌벥 甕곕뜇�깈�몴占� �뤃�뗫립占쎈뼄
		String sql = "select bannerID from banner order by bannerID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //筌ｏ옙 甕곕뜆�럮 野껊슣�뻻�눧�눘�뵥 野껋럩�뒭
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //占쎈쑓占쎌뵠占쎄숲甕곗쥙�뵠占쎈뮞 占쎌궎�몴占�
	}
	
	//疫뀐옙占쎈쾺疫뀐옙 筌롫뗄�꺖占쎈굡
	public int write(String bannerName, String linkURL, String bannerImage, String bannerReflect) {
		String sql = "insert into banner values(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bannerName);
			pstmt.setString(3, linkURL);
			pstmt.setString(4, bannerImage);
			pstmt.setString(5, bannerReflect);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //占쎈쑓占쎌뵠占쎄숲甕곗쥙�뵠占쎈뮞 占쎌궎�몴占�
	}
	
	//野껊슣�뻻疫뀐옙 �뵳�딅뮞占쎈뱜 筌롫뗄�꺖占쎈굡
	public ArrayList<Banner> getList(int pageNumber){
		String sql = "select * from banner where bannerID < ? order by bannerID desc limit 10";
		ArrayList<Banner> list = new ArrayList<Banner>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Banner banner = new Banner();
				banner.setBannerID(rs.getInt(1));
				banner.setBannerName(rs.getString(2));
				banner.setLinkURL(rs.getString(3));
				banner.setBannerImage(rs.getString(4));
				banner.setBannerReflect(rs.getString(5));
				list.add(banner);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//野껊슣�뻻疫뀐옙 �뵳�딅뮞占쎈뱜 筌롫뗄�꺖占쎈굡
	public ArrayList<Banner> getReflectList(){
		String sql = "select * from banner where bannerReflect = ?";
		ArrayList<Banner> list = new ArrayList<Banner>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "Y");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Banner banner = new Banner();
				banner.setBannerID(rs.getInt(1));
				banner.setBannerName(rs.getString(2));
				banner.setLinkURL(rs.getString(3));
				banner.setBannerImage(rs.getString(4));
				banner.setBannerReflect(rs.getString(5));
				list.add(banner);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//占쎈읂占쎌뵠筌욑옙 筌ｌ꼶�봺 筌롫뗄�꺖占쎈굡
	public boolean nextPage(int pageNumber) {
		String sql = "select * from banner where bannerID < ?";
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
	
	//占쎈릭占쎄돌占쎌벥 野껊슣�뻻疫뀐옙占쎌뱽 癰귣��뮉 筌롫뗄�꺖占쎈굡
	public Banner getBanner(int bannerID) {
		String sql = "select * from banner where bannerID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bannerID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Banner banner = new Banner();
				banner.setBannerID(rs.getInt(1));
				banner.setBannerName(rs.getString(2));
				banner.setLinkURL(rs.getString(3));
				banner.setBannerImage(rs.getString(4));
				banner.setBannerReflect(rs.getString(5));
				return banner;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//野껊슣�뻻疫뀐옙 占쎈땾占쎌젟 筌롫뗄�꺖占쎈굡
	public int update(int bannerID, String bannerName, String linkURL, String bannerImage, String bannerReflect) {
		String sql = "update banner set bannerName = ?, linkURL = ?, bannerImage = ?, bannerReflect = ? where bannerID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bannerName);
			pstmt.setString(2, linkURL);
			pstmt.setString(3, bannerImage);
			pstmt.setString(4, bannerReflect);
			pstmt.setInt(5, bannerID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //占쎈쑓占쎌뵠占쎄숲甕곗쥙�뵠占쎈뮞 占쎌궎�몴占�
	}
	

}
