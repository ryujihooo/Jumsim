package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import review.Review;

public class ReviewDAO {
	private Connection conn;
	private ResultSet rs;
	//湲곕낯 �깮�꽦�옄
	public ReviewDAO() {
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
	
	//寃뚯떆湲� 踰덊샇 遺��뿬 硫붿냼�뱶
	public int getNext() {
		//�쁽�옱 寃뚯떆湲��쓣 �궡由쇱감�닚�쑝濡� 議고쉶�븯�뿬 媛��옣 留덉�留� 湲��쓽 踰덊샇瑜� 援ы븳�떎
		String sql = "select reviewID from review order by reviewID desc";
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
	public int write(String userID, int reviewStar, String reviewContent) {
		String sql = "insert into review values(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, reviewStar);
			pstmt.setString(4, reviewContent);
			pstmt.setString(5, getDate());
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	//寃뚯떆湲� 由ъ뒪�듃 硫붿냼�뱶
	public ArrayList<Review> getList(int pageNumber, int shopID){
		String sql = "select * from review where reviewID < ? and shopID = ? order by reviewID desc limit 10";
		ArrayList<Review> list = new ArrayList<Review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setInt(2, shopID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Review review = new Review();
				review.setReviewID(rs.getInt(1));
				review.setUserID(rs.getString(2));
				review.setReviewStar(rs.getInt(3));
				review.setReviewContent(rs.getString(4));
				review.setReviewDate(rs.getString(5));
				list.add(review);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//�럹�씠吏� 泥섎━ 硫붿냼�뱶
	public boolean nextPage(int pageNumber) {
		String sql = "select * from review where reviewID < ?";
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
	public Review getReview(int reviewID) {
		String sql = "select * from review where reviewID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Review review = new Review();
				review.setReviewID(rs.getInt(1));
				review.setUserID(rs.getString(2));
				review.setReviewStar(rs.getInt(3));
				review.setReviewContent(rs.getString(4));
				review.setReviewDate(rs.getString(5));
				return review;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Review getReviewStar(int reviewstar, int reviewID) {
		String sql = "select reviewStar from review where reviewID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewID);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
