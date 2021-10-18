package galary;

import java.sql.Timestamp;

public class GalaryBean {
	private int galNum;
	private String galName;
	private String galTitle;
	private String galFile;
	private Timestamp galDate;
	private int heartCount;
	
	public GalaryBean() {
		super();
	}
	
	public GalaryBean(int galNum, String galName, String galTitle, String galFile, Timestamp galDate, int heartCount) {
		super();
		this.galNum = galNum;
		this.galName = galName;
		this.galTitle = galTitle;
		this.galFile = galFile;
		this.galDate = galDate;
		this.heartCount = heartCount;
	}

	public int getGalNum() {
		return galNum;
	}
	public void setGalNum(int galNum) {
		this.galNum = galNum;
	}
	public String getGalName() {
		return galName;
	}
	public void setGalName(String galName) {
		this.galName = galName;
	}
	public String getGalTitle() {
		return galTitle;
	}
	public void setGalTitle(String galTitle) {
		this.galTitle = galTitle;
	}
	public Timestamp getGalDate() {
		return galDate;
	}
	public void setGalDate(Timestamp galDate) {
		this.galDate = galDate;
	}
	public String getGalFile() {
		return galFile;
	}
	public void setGalFile(String galFile) {
		this.galFile = galFile;
	}
	public int getHeartCount() {
		return heartCount;
	}
	public void setHeartCount(int heartCount) {
		this.heartCount = heartCount;
	}
	
}
