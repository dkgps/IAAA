package photo1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import photo1.Photo1DTO;
import java.io.File;
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
	
	public int getNext() {
		String SQL = "select photoID from photo1 order by photoID desc";
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
		String SQL = "insert into photo1 values (?,?,?,?,now(),?,?)";
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
	 
	public ArrayList<Photo1DTO> getList(int pageNumber) {
		String SQL = "select * from photo1 where photoID<? order by photoID desc";
		ArrayList<Photo1DTO> list = new ArrayList<Photo1DTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 6);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Photo1DTO photo1 = new Photo1DTO();
				photo1.setPhotoID(rs.getInt("PhotoID"));
				photo1.setPhotoTitle(rs.getString("photoTitle"));
				photo1.setPhotoContent(rs.getString("photoContent"));
				photo1.setUserID(rs.getString("userID"));
				photo1.setPhotoDate(rs.getString("photoDate").substring(0,11) + rs.getString("photoDate").substring(11,13)+"시" +rs.getString("photoDate").substring(14,16)+"분" );
				photo1.setFileName(rs.getString("fileName"));
				photo1.setRealFileName(rs.getString("realFileName"));
				list.add(photo1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return list;		
	}
	
	public String getPhoto(int photoID) {
		String SQL = "select realFileName from photo1 where photoID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, photoID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("realFileName").equals("")){
					return "http://localhost:8080/WebPractice/starphoto/noimage.jpg";
				}
				return "http://localhost:8080/WebPractice/starphoto/" + rs.getString("realFileName");
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return "http://localhost:8080/WebPractice/starphoto/noimage.jpg";	
	}
}
