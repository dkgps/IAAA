package aboutme;

public class AboutMeReply {
	private int replyID;
	private String replyDate;
	private int aboutMeID;
	private String userID;
	private String replyContent;
	public int getReplyID() {
		return replyID;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	public int getAboutMeID() {
		return aboutMeID;
	}
	public void setAboutMeID(int aboutMeID) {
		this.aboutMeID = aboutMeID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public void setReplyID(int replyID) {
		this.replyID = replyID;
	}
	
	
	
	
}
