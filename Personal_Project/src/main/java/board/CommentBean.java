package board;

import java.sql.Timestamp;

public class CommentBean {
	private int commNum;
	private String commName;
	private String commContent;
	private Timestamp commDate;
	private int boardNum;
	
	
	public CommentBean() {
	}
	
	public CommentBean(int commNum, String commName, String commContent, Timestamp commDate, int boardNum) {
		super();
		this.commNum = commNum;
		this.commName = commName;
		this.commContent = commContent;
		this.commDate = commDate;
		this.boardNum = boardNum;
	}
	
	public int getCommNum() {
		return commNum;
	}
	public void setCommNum(int commNum) {
		this.commNum = commNum;
	}
	public String getCommName() {
		return commName;
	}
	public void setCommName(String commName) {
		this.commName = commName;
	}
	public String getCommContent() {
		return commContent;
	}
	public void setCommContent(String commContent) {
		this.commContent = commContent;
	}
	public Timestamp getCommDate() {
		return commDate;
	}
	public void setCommDate(Timestamp commDate) {
		this.commDate = commDate;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	
	
}
