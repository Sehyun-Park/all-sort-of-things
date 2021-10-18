package board;

import java.sql.Timestamp;

public class BoardBean {
	private int num;
	private String name;
	private String title;
	private String content;
	private int hit;
	private Timestamp date;
	
	public BoardBean() {
		super();
	}
	
	public BoardBean(int num, String name, String title, String content, int hit, Timestamp date) {
		super();
		this.num = num;
		this.name = name;
		this.title = title;
		this.content = content;
		this.hit = hit;
		this.date = date;
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	
	
	

}
