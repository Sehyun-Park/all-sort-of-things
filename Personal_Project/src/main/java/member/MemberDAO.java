package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	// DB 연결 -------------------------------------------------------------------------------------
	
	private Connection getConnection() throws Exception {
			
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB"); // 자원위치
		Connection con = ds.getConnection();
		
		return con;
		
		
	}
	// finally close()  -------------------------------------------------------------------------------------	
	private void close(Connection con) {
		if(con != null) try { con.close(); } catch (Exception e2) { e2.printStackTrace(); }
	}
	
	private void close(PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close(); } catch (Exception e2) { e2.printStackTrace(); }
	}
	
	private void close(ResultSet rs) {
		if(rs != null) try { rs.close(); } catch (Exception e2) { e2.printStackTrace(); }
	}
	
	// memberBean 업데이트 -------------------------------------------------------------------------------------
	private void setMemberBean(ResultSet rs, MemberBean mb) {
		try {
			mb.setId(rs.getString("id"));
			mb.setPassword(rs.getString("password"));
			mb.setName(rs.getString("name"));
			mb.setEmail(rs.getString("email"));
			mb.setPostcode(rs.getString("postcode"));
			mb.setAddress(rs.getString("address"));
			mb.setDetailAddress(rs.getString("detailAddress"));
			mb.setExtraAddress(rs.getString("extraAddress"));
			mb.setPhoneNum(rs.getString("phoneNum"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 회원 등록 -------------------------------------------------------------------------------------

	public void insertMember(MemberBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();

			String sql = "INSERT INTO member VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPassword());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getEmail());
			pstmt.setString(5, mb.getPostcode());
			pstmt.setString(6, mb.getAddress());
			pstmt.setString(7, mb.getDetailAddress());
			pstmt.setString(8, mb.getExtraAddress());
			pstmt.setString(9, mb.getPhoneNum());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
			
		}
		
	}
		
	// 로그인( 회원 확인 ) ---------------------------------------------------------------------------
		
	public MemberBean userCheck(String id, String password) {
		
		MemberBean mb = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM member WHERE id = ? and password = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mb = new MemberBean();
				setMemberBean(rs, mb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return mb;
	}
	
	// 회원 조회 ---------------------------------------------------------------------------
	
	public MemberBean getMember(String id) {
		
		MemberBean mb = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mb = new MemberBean();
				setMemberBean(rs, mb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return mb;
	}
	
	// 회원 정보 수정 -----------------------------------------------------------------------
	
	public void updateMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE member SET name = ?, email = ?, postcode = ?, address = ?, detailAddress = ?, extraAddress = ?, phoneNum = ? WHERE id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mb.getName());
			pstmt.setString(2, mb.getEmail());
			pstmt.setString(3, mb.getPostcode());
			pstmt.setString(4, mb.getAddress());
			pstmt.setString(5, mb.getDetailAddress());
			pstmt.setString(6, mb.getExtraAddress());
			pstmt.setString(7, mb.getPhoneNum());
			pstmt.setString(8, mb.getId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	
	// 회원 삭제 -----------------------------------------------------------------------
	
	public void deleteMember(MemberBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			
			String sql = "DELETE FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
}
