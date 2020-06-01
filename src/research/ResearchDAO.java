package research;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class ResearchDAO {
	private Connection conn;
	private ResultSet rs;
		
	public ResearchDAO(){
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

			
	
	public int write(String userID, String researchTitle, String researchContent, String researchFile, String researchRealFile) {
		String SQL = "insert into research select ?, ifnull((select max(researchID)+1 from research),1), ?,?, now(), 0, ?,?,ifnull((select max(researchGroup)+1 from research),0) , 0, 0";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, researchTitle);
			pstmt.setString(3, researchContent);
			pstmt.setString(4, researchFile);
			pstmt.setString(5, researchRealFile);
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //db오류
	}
	
	public ArrayList<ResearchDTO> getList(){
		String SQL = "SELECT * from research order by researchGroup desc, researchSequence asc";
		ArrayList<ResearchDTO> list = new ArrayList<ResearchDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ResearchDTO research = new ResearchDTO();
				research.setUserID(rs.getString("userID"));
				research.setResearchID(rs.getInt("researchID"));
				research.setResearchTitle(rs.getString("researchTitle").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll(" ", "<br>;"));
				research.setResearchContent(rs.getString("researchContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll(" ", "<br>;"));
				research.setResearchDate(rs.getString("researchDate").substring(0,11) + rs.getString("researchDate").substring(11,13)+"시" +rs.getString("researchDate").substring(14,16)+"분" );
				research.setResearchHit(rs.getInt("researchHit"));
				research.setResearchFile(rs.getString("researchFile"));
				research.setResearchRealFile(rs.getString("researchRealFile"));
				research.setResearchGroup(rs.getInt("researchGroup"));
				research.setResearchSequence(rs.getInt("researchSequence"));
				research.setResearchLevel(rs.getInt("researchLevel"));
				list.add(research);
			}
		}catch (Exception e) {
				e.printStackTrace();
		}
		return list; // 첫번째 게시글

	}
	
	
	
	public ResearchDTO getResearch(int researchID) {
		String SQL = "select * from research where researchID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, researchID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ResearchDTO research = new ResearchDTO();
				research.setUserID(rs.getString("userID"));
				research.setResearchID(rs.getInt("researchID"));
				research.setResearchTitle(rs.getString("researchTitle").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll(" ", "<br>;"));
				research.setResearchContent(rs.getString("researchContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll(" ", "<br>;"));
				research.setResearchDate(rs.getString("researchDate").substring(0,11) + rs.getString("researchDate").substring(11,13)+"시" +rs.getString("researchDate").substring(14,16)+"분" );
				research.setResearchHit(rs.getInt("researchHit"));
				research.setResearchFile(rs.getString("researchFile"));
				research.setResearchRealFile(rs.getString("researchRealFile"));
				research.setResearchGroup(rs.getInt("researchGroup"));
				research.setResearchSequence(rs.getInt("researchSequence"));
				research.setResearchLevel(rs.getInt("researchLevel"));
				return research;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return null;		
	}
	
	public int hit(int researchID) {
		String SQL = "update research set researchHit = researchHit+1 where researchID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, researchID);
			
			return pstmt.executeUpdate(); //성공시 1
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //db오류
	}
	

	
	public String getResearchFile(int researchID) {
		String SQL = "select researchFile from research where researchID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, researchID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("researchFile");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return "";		
	}
	
	public String getResearchRealFile(int researchID) {
		String SQL = "select researchRealFile from research where researchID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, researchID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("researchRealFile");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
				
		return "";		
	}
	
	public int researchUpdate(int researchID, String researchTitle, String researchContent, String researchFile, String researchRealFile) {
		String SQL = "update research set researchTitle= ?, researchContent=?, researchFile=?, researchRealFile=? where researchID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, researchTitle);
			pstmt.setString(2, researchContent);
			pstmt.setString(3, researchFile);
			pstmt.setString(4, researchRealFile);
			pstmt.setInt(5, researchID); 
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
	
	
	
}
