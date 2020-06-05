package photo1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class Photo1DAO {

	private Connection conn;
	private ResultSet rs;
		
	public Photo1DAO(){
		try {
			String dbURL = "jdbc:mysql://localhost:3306/iaaa";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int write(String photoTitle, String photoContent, String userID, String fileName) {
		String SQL = "insert into photo1 values (?,?,?,?,now(),?)";
		try{
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
}
