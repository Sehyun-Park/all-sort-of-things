package galary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class HeartDAO {
	// DB 연결 ----------------------------------------------------------------------------------
	public Connection getConnection() throws Exception {
		
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		
		return con;
	}
	
	// 글 등록 ----------------------------------------------------------------------------------
	public int insertLike(HeartBean hb) {
		Connection con = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		
		int result = 0;
		
		try {
			con = getConnection();
			
			String sql1 = "INSERT INTO heart VALUES(null,?,?)";
			pstmt1 = con.prepareStatement(sql1);
			pstmt1.setInt(1, hb.getGalNum());
			pstmt1.setString(2, hb.getId());
			
			int likeCount = pstmt1.executeUpdate();
			
			if(likeCount == 1) {
				String sql2 = "UPDATE galary SET heartCount=heartCount+1 WHERE galNum = (SELECT galNum FROM heart WHERE hNum=(SELECT max(hNum) FROM heart));";
				pstmt2 = con.prepareStatement(sql2);
				result = pstmt2.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt2);
			close(rs);
			close(pstmt1);
			close(con);
		}
		
		return result;
	}
	
	// ----------------------------------------------------------------------------------------------
	public boolean checkLike(int galNum, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean like = false;
		
		try {
			
			con = getConnection();
			
			String sql = "SELECT * FROM heart WHERE galNum=? and id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, galNum);
			pstmt.setString(2, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				like = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return like;
		
	}
	
	// ----------------------------------------------------------------------------------------------
	public int unLike(int galNum, String id) {
		Connection con = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		
		int result = 0;
		try {
			
			con = getConnection();
			
			String sql1 = "DELETE FROM heart WHERE galNum=? AND id=?";
			pstmt1 = con.prepareStatement(sql1);
			pstmt1.setInt(1, galNum);
			pstmt1.setString(2, id);
			
			int deleteCount = pstmt1.executeUpdate();
			
			if(deleteCount >= 1) {
				String sql2 = "UPDATE galary SET heartCount=heartCount-? WHERE galNum = ?";
				pstmt2 = con.prepareStatement(sql2);
				pstmt2.setInt(1, deleteCount);
				pstmt2.setInt(2, galNum);
				result = pstmt2.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt2);
			close(rs);
			close(pstmt1);
			close(con);
		}
		
		return result;
		
	}
	
	
	// ----------------------------------------------------------------------------------------------
	private void close(Connection con) {
		if(con != null) try { con.close(); } catch (Exception e2) { e2.printStackTrace(); }
	}
	
	private void close(PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close(); } catch (Exception e2) { e2.printStackTrace(); }
	}
	
	private void close(ResultSet rs) {
		if(rs != null) try { rs.close(); } catch (Exception e2) { e2.printStackTrace(); }
	}
}
