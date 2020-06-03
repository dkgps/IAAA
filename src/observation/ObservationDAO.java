package observation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class ObservationDAO {
	private Connection conn;
	private ResultSet rs;
	
	public ObservationDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/iaaa";
			String dbID ="root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int getNext() {
		String SQL = "select observationID from observation order by observationID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int write(String userID, int observationYear, String observationDivide, String observationTitle, String observationContent) {
		String SQL = "insert into observation values(?,?,?,?,?,?,now(),0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, observationYear);
			pstmt.setString(4, observationDivide);
			pstmt.setString(5, observationTitle);
			pstmt.setString(6, observationContent);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	public ArrayList<ObservationDTO> getList(int pageNumber){
		String SQL = "select * from observation where observationID <? order by observationID desc limit 8";
		ArrayList<ObservationDTO> list = new ArrayList<ObservationDTO>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*8);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ObservationDTO observationDTO = new ObservationDTO();
				observationDTO.setObservationID(rs.getInt(1));
				observationDTO.setUserID(rs.getString(2));
				observationDTO.setObservationYear(rs.getInt(3));
				observationDTO.setObservationDivide(rs.getString(4));
				observationDTO.setObservationTitle(rs.getString(5));
				observationDTO.setObservationContent(rs.getString(6));
				observationDTO.setObservationDate(rs.getString(7));
				observationDTO.setLikeCount(rs.getInt(8));
				list.add(observationDTO);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	public ObservationDTO getObservation(int observationID){
		String SQL = "select * from observation where observationID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,observationID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ObservationDTO observationDTO = new ObservationDTO();
				observationDTO.setObservationID(rs.getInt(1));
				observationDTO.setUserID(rs.getString(2));
				observationDTO.setObservationYear(rs.getInt(3));
				observationDTO.setObservationDivide(rs.getString(4));
				observationDTO.setObservationTitle(rs.getString(5));
				observationDTO.setObservationContent(rs.getString(6));
				observationDTO.setObservationDate(rs.getString(7));
				observationDTO.setLikeCount(rs.getInt(8));
				return observationDTO;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public int update(int observationID, int observationYear, String observationDivide, String observationTitle, String observationContent) {
		String SQL = "update observation set observationYear = ?, observationDivide=?, observationTitle=?, observationContent=? where observationID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, observationYear);
			pstmt.setString(2, observationDivide);
			pstmt.setString(3, observationTitle);
			pstmt.setString(4, observationContent);
			pstmt.setInt(5, observationID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	public int delete(int observationID) {
		String SQL = "delete from observation where observationID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, observationID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from observation where observationID > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber -1) * 8);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/* 추천기능 */
	public int like(String userID, int observationID, String userIP) {
		String SQL = "insert into likey values (?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, observationID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int likeUp(int observationID) {
		String SQL = "update observation set likeCount = likeCount + 1 where observationID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //준비
			pstmt.setInt(1, observationID);
			return pstmt.executeUpdate();
			
		}catch (Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	
	public ArrayList<ObservationDTO> getList(String observationDivide, String searchType, String search, int pageNumber){
		if(observationDivide.equals("전체")) {
			observationDivide = "";
		}
		ArrayList<ObservationDTO> observationList = null;
		String SQL = "";
		PreparedStatement pstmt = null;
		try {
			if(searchType.equals("최신순")) {
				SQL = "select * from observation where observationDivide like ? and concat(observationTitle, observationContent) like " +
			"? order by observationID desc limit " + (pageNumber-1) * 8 + "," + (pageNumber-1) * 8 +9;
			}else if(searchType.equals("추천순")){
				SQL = "select * from observation where observationDivide like ? and concat(observationTitle, observationContent) like " +
				"? order by likeCount desc limit " + (pageNumber-1) * 8 + "," + (pageNumber-1) * 8 +9;		
			}
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%"+observationDivide+"%");
			pstmt.setString(2, "%"+search+"%");
			rs = pstmt.executeQuery();
			observationList = new ArrayList<ObservationDTO>();
			while(rs.next()) {
				ObservationDTO observationDTO = new ObservationDTO();
				observationDTO.setObservationID(rs.getInt(1));
				observationDTO.setUserID(rs.getString(2));
				observationDTO.setObservationYear(rs.getInt(3));
				observationDTO.setObservationDivide(rs.getString(4));
				observationDTO.setObservationTitle(rs.getString(5));
				observationDTO.setObservationContent(rs.getString(6));
				observationDTO.setObservationDate(rs.getString(7));
				observationDTO.setLikeCount(rs.getInt(8));
				observationList.add(observationDTO);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return observationList;
	}
	
}
