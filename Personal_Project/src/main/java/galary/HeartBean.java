package galary;

public class HeartBean {
	private int hNum;
	private int galNum;
	private String id;
	
	public HeartBean() {
		super();
	}

	public HeartBean(int hNum, int galNum, String id) {
		super();
		this.hNum = hNum;
		this.galNum = galNum;
		this.id = id;
	}

	public int gethNum() {
		return hNum;
	}

	public void sethNum(int hNum) {
		this.hNum = hNum;
	}

	public int getGalNum() {
		return galNum;
	}

	public void setGalNum(int galNum) {
		this.galNum = galNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
}
