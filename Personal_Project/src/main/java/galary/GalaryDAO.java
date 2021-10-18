package galary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import galary.GalaryBean;

public class GalaryDAO {
	// DB 연결 ----------------------------------------------------------------------------------
	public Connection getConnection() throws Exception {
		
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		
		return con;
	}
	// 글 등록 ----------------------------------------------------------------------------------
	public void insertGalary(GalaryBean gb) {
		Connection con = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		
		try {
			con = getConnection();
			
			String sql1 = "SELECT MAX(galNum) FROM galary";
			pstmt1 = con.prepareStatement(sql1);
			rs = pstmt1.executeQuery();
			
			if(rs.next()) {
				gb.setGalNum(rs.getInt("MAX(galNum)") + 1);
			}
			
			String sql2 = "INSERT INTO galary VALUES(?, ?, ?, ?, ?, ?)";
			pstmt2 = con.prepareStatement(sql2);
			
			pstmt2.setInt(1, gb.getGalNum());
			pstmt2.setString(2, gb.getGalName());
			pstmt2.setString(3, gb.getGalTitle());
			pstmt2.setString(4, gb.getGalFile());
			pstmt2.setTimestamp(5, gb.getGalDate());
			pstmt2.setInt(6, gb.getHeartCount());
			
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
	
	// 글 수정 ---------------------------------------------------------------------------
	public void updateGalary(GalaryBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE galary SET galTitle = ?, galFile = ? WHERE galNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getGalTitle());
			pstmt.setString(2, bb.getGalFile());
			pstmt.setInt(3, bb.getGalNum());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	
	// 글 삭제 ---------------------------------------------------------------------------
	public void deleteGalary(int galNum) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "DELETE FROM galary WHERE galNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, galNum);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	// galary list ----------------------------------------------------------------------------------
	public List<GalaryBean> getGalaryList(int startRow, int pageSize) {
		
		List<GalaryBean> galaryList = new ArrayList<GalaryBean>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM galary ORDER BY galNum DESC LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GalaryBean gb = new GalaryBean();
				
				setGalayBean(rs, gb);
				
				galaryList.add(gb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return galaryList;
	}
	// 전체 글 수 ---------------------------------------------------------------------------
	public int getGalaryCount() {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(*) FROM galary";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return count;
	}
	// n번째 글 불러오기 --------------------------------------------------------------------
	public GalaryBean getGalary(int galNum) {
		GalaryBean gb = new GalaryBean();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM galary WHERE galNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, galNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				gb = new GalaryBean();
				setGalayBean(rs, gb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return gb;
	}	
	
	// update 용 boardBean 저장 ------------------------------------------------------------------	
	public void setGalayBean(ResultSet rs, GalaryBean gb) {
		try {
			gb.setGalNum(rs.getInt("galNum"));
			gb.setGalName(rs.getString("galName"));
			gb.setGalTitle(rs.getString("galTitle"));
			gb.setGalFile(rs.getString("galFile"));
			gb.setGalDate(rs.getTimestamp("galDate"));
			gb.setHeartCount(rs.getInt("heartCount"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// finally close()  ---------------------------------------------------------------------------	
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
