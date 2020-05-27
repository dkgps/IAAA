package freeboard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import freeboard.FreeBoard;


public class FreeBoardDAO {
	private Connection conn;
	private ResultSet rs;
		
	public FreeBoardDAO(){
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
			String SQL = "SELECT freeBoardID from freeboard order by freeBoardID desc";
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
			
	
	public int write(String freeBoardTitle, String userID, String freeBoardContent) {
		String SQL = "insert into freeboard values(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, freeBoardTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, freeBoardContent);
			pstmt.setInt(6, 1); //처음엔 삭제x : 1
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
	public ArrayList<FreeBoard> getList(int pageNumber){
		String SQL = "SELECT * from freeboard where freeBoardID <? and freeBoardAvailable = 1 order by freeBoardID desc limit 10";
		ArrayList<FreeBoard> list = new ArrayList<FreeBoard>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FreeBoard freeboard = new FreeBoard();
				freeboard.setFreeBoardID(rs.getInt(1));
				freeboard.setFreeBoardTitle(rs.getString(2));
				freeboard.setUserID(rs.getString(3));
				freeboard.setFreeBoardDate(rs.getString(4));
				freeboard.setFreeBoardContent(rs.getString(5));
				freeboard.setFreeBoardAvailable(rs.getInt(6));
				list.add(freeboard);
			}
		}catch (Exception e) {
				e.printStackTrace();
		}
		return list; // 첫번째 게시글

	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from freeboard where freeBoardID > ? and freeBoardAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pageNumber);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public FreeBoard getFreeBoard(int freeBoardID) {
		String SQL = "select * from freeboard where freeBoardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, freeBoardID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				FreeBoard freeBoard = new FreeBoard();
				freeBoard.setFreeBoardID(rs.getInt(1));
				freeBoard.setFreeBoardTitle(rs.getString(2));
				freeBoard.setUserID(rs.getString(3));
				freeBoard.setFreeBoardDate(rs.getString(4));
				freeBoard.setFreeBoardContent(rs.getString(5));
				freeBoard.setFreeBoardAvailable(rs.getInt(6));
				return freeBoard;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return null;		
	}
	
	public int freeBoardUpdate(int freeBoardID, String freeBoardTitle, String freeBoardContent) {
		String SQL = "update freeboard set freeBoardTitle= ?, freeBoardContent=? where freeBoardID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, freeBoardTitle);
			pstmt.setString(2, freeBoardContent);
			pstmt.setInt(3, freeBoardID); 
			return pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; 
	}
	
	public int freeBoardDelete(int freeBoardID) {
		String SQL = "delete from freeboard where freeBoardID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, freeBoardID); 
			return pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; 
	}
	
	public int replyNext() {
		String SQL = "SELECT replyID from boardreply order by replyID desc";
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
	
	
	public int reply(int freeBoardID, String userID, String replyContent) {
		String SQL = "insert into boardreply values(?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyNext());
			pstmt.setString(2, getDate());
			pstmt.setInt(3, freeBoardID);
			pstmt.setString(4, userID);
			pstmt.setString(5, replyContent);
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			
		}
		
		return -1; //db오류
	}
	
	public ArrayList<boardReply> getReply(int freeBoardID){
		String SQL = "SELECT * from boardReply where freeBoardID = ? order by replyID";
		ArrayList<boardReply> replylist = new ArrayList<boardReply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, freeBoardID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				boardReply boardreply = new boardReply();
				boardreply.setReplyID(rs.getInt(1));
				boardreply.setReplyDate(rs.getString(2));
				boardreply.setFreeBoardID(rs.getInt(3));
				boardreply.setUserID(rs.getString(4));
				boardreply.setReplyContent(rs.getString(5));
				replylist.add(boardreply);
			}
		}catch (Exception e) {
				e.printStackTrace();
		}
		return replylist; // 첫번째 게시글

	}
	
	public int delete(int replyID) {
		String SQL = "delete from boardreply where replyID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyID); 
			return pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; 
	}
	
}
