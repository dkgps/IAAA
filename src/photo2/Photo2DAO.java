package photo2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import photo1.Photo1DTO;

public class Photo2DAO {
	
	private Connection conn;
	private ResultSet rs;
		
	public Photo2DAO(){
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
	
	public int getNext() {
		String SQL = "select photoID from photo2 order by photoID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	
	
	public int write(String photoTitle, String photoContent, String userID, String fileName, String realFileName) {
		String SQL = "insert into photo2 values (?,?,?,?,now(),?,?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, photoTitle);
			pstmt.setString(3, photoContent);
			pstmt.setString(4, userID);
			pstmt.setString(5, fileName);
			pstmt.setString(6, realFileName);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	 
	public ArrayList<Photo2DTO> getList(int pageNumber) {
		String SQL = "select * from photo2 where photoID<? order by photoID desc";
		ArrayList<Photo2DTO> list = new ArrayList<Photo2DTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 6);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Photo2DTO photo2 = new Photo2DTO();
				photo2.setPhotoID(rs.getInt("PhotoID"));
				photo2.setPhotoTitle(rs.getString("photoTitle"));
				photo2.setPhotoContent(rs.getString("photoContent"));
				photo2.setUserID(rs.getString("userID"));
				photo2.setPhotoDate(rs.getString("photoDate").substring(0,11) + rs.getString("photoDate").substring(11,13)+"시" +rs.getString("photoDate").substring(14,16)+"분" );
				photo2.setFileName(rs.getString("fileName"));
				photo2.setRealFileName(rs.getString("realFileName"));
				list.add(photo2);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return list;		
	}
	
	public Photo2DTO getData(int photoID) {
		String SQL = "select * from photo2 where photoID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, photoID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Photo2DTO photo2 = new Photo2DTO();
				photo2.setPhotoID(rs.getInt("PhotoID"));
				photo2.setPhotoTitle(rs.getString("photoTitle"));
				photo2.setPhotoContent(rs.getString("photoContent"));
				photo2.setUserID(rs.getString("userID"));
				photo2.setPhotoDate(rs.getString("photoDate").substring(0,11) + rs.getString("photoDate").substring(11,13)+"시" +rs.getString("photoDate").substring(14,16)+"분" );
				photo2.setFileName(rs.getString("fileName"));
				photo2.setRealFileName(rs.getString("realFileName"));
				return photo2;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return null;		
	}

	public String getPhoto(int photoID) {
		String SQL = "select realFileName from photo2 where photoID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, photoID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("realFileName").equals("")){
					return "http://localhost:8080/WebPractice/iaaaphoto/noimage.jpg";
				}
				return "http://localhost:8080/WebPractice/iaaaphoto/" + rs.getString("realFileName");
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return "http://localhost:8080/WebPractice/iaaaphoto/noimage.jpg";	
	}
	
	public int update(int photoID, String photoTitle, String photoContent,String fileName, String realFileName) {
		String SQL = "update photo2 set photoTitle =?, photoContent=?, fileName=?, realFileName=? where photoID =?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, photoTitle);
			pstmt.setString(2, photoContent);
			pstmt.setString(3, fileName);
			pstmt.setString(4, realFileName);
			pstmt.setInt(5, photoID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int delete(int photoID) {
		String SQL = "delete from photo2 where photoID =?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, photoID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	

	public boolean nextPage(int pageNumber) {
		String SQL = "select * from photo2 where photoID >= ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pageNumber * 6);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	 
}
