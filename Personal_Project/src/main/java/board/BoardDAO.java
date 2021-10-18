package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
	// DB 연결 ----------------------------------------------------------------------------------
	public Connection getConnection() throws Exception {
		
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		
		return con;
	}
	
	// 글 등록 ----------------------------------------------------------------------------------
	public void insertBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		
		try {
			con = getConnection();
			
			String sql1 = "SELECT MAX(num) FROM board";
			pstmt1 = con.prepareStatement(sql1);
			rs = pstmt1.executeQuery();
			
			if(rs.next()) {
				bb.setNum(rs.getInt("MAX(num)") + 1);
			}
			
			String sql2 = "INSERT INTO board VALUES(?, ?, ?, ?, ?, ?)";
			pstmt2 = con.prepareStatement(sql2);
			
			pstmt2.setInt(1, bb.getNum());
			pstmt2.setString(2, bb.getName());
			pstmt2.setString(3, bb.getTitle());
			pstmt2.setString(4, bb.getContent());
			pstmt2.setInt(5, bb.getHit());
			pstmt2.setTimestamp(6, bb.getDate());
			
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
	public void updateBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE board SET title = ?, content = ? WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getTitle());
			pstmt.setString(2, bb.getContent());
			pstmt.setInt(3, bb.getNum());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	
	// 글 삭제 ---------------------------------------------------------------------------
	public void deleteBoard(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "DELETE FROM board WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	
	// 글 목록 불러오기 ---------------------------------------------------------------------------
	public List<BoardBean> getBoardList(int startRow, int pageSize) {
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM board ORDER BY num DESC LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				
				setBoardBean(rs, bb);
				
				boardList.add(bb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return boardList;
	}
	
	
	// 전체 글 수 ---------------------------------------------------------------------------
	public int getBoartCount() {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(*) FROM board";
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
	
	// 검색 목록 불러오기 -------------------------------------------------------------------
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM board WHERE title LIKE ? ORDER BY num DESC LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				setBoardBean(rs, bb);
				boardList.add(bb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return boardList;
	}
	
	// 검색 글 수 ---------------------------------------------------------------------------
	public int getBoartCount(String search) {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(*) FROM board WHERE title LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
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
	public BoardBean getBoard(int num) {
		BoardBean bb = new BoardBean();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM board WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bb = new BoardBean();
				setBoardBean(rs, bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return bb;
	}
	
	// hit 설정 ---------------------------------------------------------------------------
	public void updateHit(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE board SET hit = hit + 1 WHERE num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	
	// delete 후 글 번호 정렬 ------------------------------------------------------------------
	public void updateBoardNum() {
		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		
		try {
			con = getConnection();
			
			String sql1="SET @count = 0";
			pstmt1 = con.prepareStatement(sql1);
			
			pstmt1.executeUpdate();
			
			String sql2="UPDATE board SET num = @count:=@count+1";
			pstmt2 = con.prepareStatement(sql2);
			
			pstmt2.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// select 후 boardBean 저장 ------------------------------------------------------------------	
	public void setBoardBean(ResultSet rs, BoardBean bb) {
		try {
			bb.setNum(rs.getInt("num"));
			bb.setName(rs.getString("name"));
			bb.setTitle(rs.getString("title"));
			bb.setContent(rs.getString("content"));
			bb.setHit(rs.getInt("hit"));
			bb.setDate(rs.getTimestamp("date"));
		} catch (Exception e) {
			// TODO: handle exception
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
