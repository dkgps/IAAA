package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import user.UserDTO;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/iaaa";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL ="select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}else {
					return 0;
				}
			}
			return -1;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) {pstmt.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		
		return -2;
		
	}
	
	
	public int join(UserDTO user) {
		String SQL = "insert into user values (?,?,?,?,?,false)";
		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserEmailHash());
			return pstmt.executeUpdate(); // 1:성공
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) {pstmt.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		
		return -1;
	}
	
	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "select userEmailChecked from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) {pstmt.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		
		return false;
	}
	
	public boolean setUserEmailCheck(String userID) {
		String SQL = "update user set userEmailChecked = true where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) {pstmt.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		
		return false;
	}
	
	public String getUserEmail(String userID) {
		String SQL = "select userEmail from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) {pstmt.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		
		return null;
	}
}
