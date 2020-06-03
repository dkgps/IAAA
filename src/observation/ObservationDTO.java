package observation;

public class ObservationDTO {
	private int observationID;
	private String userID;
	private int observationYear;
	private String observationDivide;
	private String observationTitle;
	private String observationContent;
	private String observationDate;
	private int likeCount;
	
	
	
	
	public int getObservationYear() {
		return observationYear;
	}
	public void setObservationYear(int observationYear) {
		this.observationYear = observationYear;
	}
	public int getObservationID() {
		return observationID;
	}
	public void setObservationID(int observationID) {
		this.observationID = observationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getObservationDivide() {
		return observationDivide;
	}
	public void setObservationDivide(String observationDivide) {
		this.observationDivide = observationDivide;
	}
	public String getObservationTitle() {
		return observationTitle;
	}
	public void setObservationTitle(String observationTitle) {
		this.observationTitle = observationTitle;
	}
	public String getObservationContent() {
		return observationContent;
	}
	public void setObservationContent(String observationContent) {
		this.observationContent = observationContent;
	}
	public String getObservationDate() {
		return observationDate;
	}
	public void setObservationDate(String observationDate) {
		this.observationDate = observationDate;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
}
