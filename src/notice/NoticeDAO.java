package notice;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDAO {
	private Connection conn;
	private ResultSet rs;
		
	public NoticeDAO(){
		try {
			String dbURL = "jdbc:mysql://localhost:3306/notice";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//날짜 가져오기
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			
		}
		
		return ""; //db오류
	}
	
	public int getNext() {
		String SQL = "SELECT noticeID from notice order by noticeID desc";
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
	
	public int write(String noticeTitle, String userID, String noticeContent) {
		String SQL = "insert into notice values(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, noticeContent);
			pstmt.setInt(6, 1); //처음엔 삭제x : 1
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
	
	public ArrayList<Notice> getList(int pageNumber){
		String SQL = "SELECT * from notice where noticeID <? and noticeAvailable = 1 order by noticeID desc limit 10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				list.add(notice);
			}
		}catch (Exception e) {
				e.printStackTrace();
		}
		return list; // 첫번째 게시글

	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from notice where noticeID > ? and noticeAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Notice getNotice(int noticeID){
		String SQL = "select * from notice where noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				return notice;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public int update(int noticeID, String noticeTitle, String noticeContent) {
		String SQL = "update notice set noticeTitle=?, noticeContent =? where noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeContent);
			pstmt.setInt(3, noticeID);
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
	public int delete(int noticeID) {
		String SQL = "update notice set noticeAvailable=0 where noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
		
}
