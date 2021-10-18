package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {
	
	public Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		
		return con;
	}
	
	// ---------------------------------------------------------------------------
	
	private void close(Connection con) {
		if(con != null) try { con.close(); } catch (SQLException e) {}
	}
	private void close(PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
	}
	private void close(ResultSet rs) {
		if(rs != null) try { rs.close(); } catch (SQLException e) {}
	}
	
	// ---------------------------------------------------------------------------
	
	public void insertComment(CommentBean cb) {
		
		Connection con = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		
		try {
			con = getConnection();
			
			String sql1 = "SELECT MAX(commNum) FROM comment";
			pstmt1 = con.prepareStatement(sql1);
			rs = pstmt1.executeQuery();
			if(rs.next()) {
				cb.setCommNum(rs.getInt("MAX(commNum)") + 1);
			}
			
			String sql2 = "INSERT INTO comment VALUES(?, ?, ?, ?, ?)";
			pstmt2 = con.prepareStatement(sql2);
			
			pstmt2.setInt(1, cb.getCommNum());
			pstmt2.setString(2, cb.getCommName());
			pstmt2.setString(3, cb.getCommContent());
			pstmt2.setTimestamp(4, cb.getCommDate());
			pstmt2.setInt(5, cb.getBoardNum());
			
			pstmt2.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt2);
			close(rs);
			close(pstmt1);
			close(con);
		}
		
	}
	
	// ---------------------------------------------------------------------------
	
	public void updateComment(CommentBean cb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE comment SET commContent=?, commDate=? where commNum=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, cb.getCommContent());
			pstmt.setTimestamp(2, cb.getCommDate());
			pstmt.setInt(3, cb.getCommNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		
	}
	
	// -----------------------------------------------------------------------------------------------------
	
	public void deleteComment(int commNum) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "DELETE FROM comment WHERE commNum=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, commNum);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	
	// ---------------------------------------------------------------------------
	
	public List<CommentBean> getCommentList(int boardNum) {
		
		List<CommentBean> commentList = new ArrayList<CommentBean>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM comment WHERE boardNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentBean cb = new CommentBean();
				
				cb.setCommNum(rs.getInt("commNum"));
				cb.setCommName(rs.getString("commName"));
				cb.setCommContent(rs.getString("commContent"));
				cb.setCommDate(rs.getTimestamp("commDate"));
				
				commentList.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(pstmt);
			close(con);
		}
		
		return commentList;
	}
	
	
	// ---------------------------------------------------------------------------
	public CommentBean getComment(int commNum) {
		CommentBean cb = new CommentBean();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM comment WHERE commNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				setCommentBean(rs, cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return cb;
	}
	// ---------------------------------------------------------------------------
	
	public void setCommentBean(ResultSet rs, CommentBean cb) {
		try {
			cb.setCommNum(rs.getInt("commNum"));
			cb.setCommName(rs.getString("commName"));
			cb.setCommContent(rs.getString("commContent"));
			cb.setCommDate(rs.getTimestamp("commDate"));
			cb.setBoardNum(rs.getInt("boardNum"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
