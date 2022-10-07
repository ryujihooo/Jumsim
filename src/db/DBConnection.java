package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getCon() throws SQLException{
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://52.78.34.134:3306/kiosk?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&characterEncoding=utf-8";
			con = DriverManager.getConnection(url, "hangyu", "ab1415");
			return con;
		} catch(ClassNotFoundException ce) {
			System.out.println(ce.getMessage());
			return null;
		}
	}
}
