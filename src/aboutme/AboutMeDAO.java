package aboutme;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import aboutme.AboutMeDTO;
import aboutme.AboutMeReply;
import freeboard.boardReply;



public class AboutMeDAO {
	private Connection conn;
	private ResultSet rs;
	
	public AboutMeDAO() {
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
	
	public int getNext() {
		String SQL = "SELECT aboutMeID from aboutme order by aboutMeID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; // 첫번째 게시글
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
	
	public int write(String aboutMeTitle, String userID, String aboutMeContent) {
		String SQL = "insert into aboutme values(?,?,?,now(),?,0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, aboutMeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, aboutMeContent);
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //db오류
	}
	
	
	
	
	public ArrayList<AboutMeDTO> getList(int pageNumber){
		String SQL = "SELECT * from aboutme where aboutMeID <? order by aboutMeID desc limit 10";
		ArrayList<AboutMeDTO> list = new ArrayList<AboutMeDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AboutMeDTO aboutMeDTO = new AboutMeDTO();
				aboutMeDTO.setAboutMeID(rs.getInt(1));
				aboutMeDTO.setAboutMeTitle(rs.getString(2));
				aboutMeDTO.setUserID(rs.getString(3));
				aboutMeDTO.setAboutMeDate(rs.getString(4));
				aboutMeDTO.setAboutMeContent(rs.getString(5));
				aboutMeDTO.setAboutMeHit(rs.getInt(6));
				list.add(aboutMeDTO);
			}
		}catch (Exception e) {
				e.printStackTrace();
		}
		return list; // 첫번째 게시글

	}
	
	
	public AboutMeDTO getAboutMe(int aboutMeID) {
		String SQL = "select * from aboutme where aboutMeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, aboutMeID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				AboutMeDTO aboutMeDTO = new AboutMeDTO();
				aboutMeDTO.setAboutMeID(rs.getInt(1));
				aboutMeDTO.setAboutMeTitle(rs.getString(2));
				aboutMeDTO.setUserID(rs.getString(3));
				aboutMeDTO.setAboutMeDate(rs.getString(4));
				aboutMeDTO.setAboutMeContent(rs.getString(5));
				aboutMeDTO.setAboutMeHit(rs.getInt(6));
				return aboutMeDTO;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return null;		
	}
	
	public int update(int aboutMeID, String aboutMeTitle, String aboutMeContent) {
		String SQL = "update aboutme set aboutMeTitle =?, aboutMeContent =? where aboutMeID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, aboutMeTitle);
			pstmt.setString(2, aboutMeContent);
			pstmt.setInt(3, aboutMeID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int delete(int aboutMeID) {
		String SQL = "delete from aboutme where aboutMeID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, aboutMeID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	public int hit(int aboutMeID) {
		String SQL = "update aboutme set aboutMeHit = aboutMeHit+1 where aboutMeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, aboutMeID);
			
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //db오류
	}
	
	
	
	
	/* 댓글 */
	public int replyNext() {
		String SQL = "SELECT replyID from aboutmereply order by replyID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; // 첫번째 게시글
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
	
	public int reply(int aboutMeID, String userID, String replyContent) {
		String SQL = "insert into aboutmereply values(?,now(),?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyNext());
			pstmt.setInt(2, aboutMeID);
			pstmt.setString(3, userID);
			pstmt.setString(4, replyContent);
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
	
	public ArrayList<AboutMeReply> getReply(int aboutMeID){
		String SQL = "SELECT * from aboutmereply where aboutMeID = ? order by replyID";
		ArrayList<AboutMeReply> replylist = new ArrayList<AboutMeReply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, aboutMeID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AboutMeReply aboutMeReply = new AboutMeReply();
				aboutMeReply.setReplyID(rs.getInt(1));
				aboutMeReply.setReplyDate(rs.getString(2));
				aboutMeReply.setAboutMeID(rs.getInt(3));
				aboutMeReply.setUserID(rs.getString(4));
				aboutMeReply.setReplyContent(rs.getString(5));
				replylist.add(aboutMeReply);
			}
		}catch (Exception e) {
				e.printStackTrace();
		}
		return replylist; // 첫번째 게시글

	}
	
	
	public int replyDelete(int replyID) {
		String SQL = "delete from aboutmereply where replyID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyID); 
			return pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; 
	}
	
	public int countReply(int aboutMeID) {
		int count = 0;
		String SQL = "select count(*) from aboutmereply where aboutMeID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, aboutMeID); 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return count; //db오류
	}
	
}
