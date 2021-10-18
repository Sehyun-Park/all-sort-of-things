<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/deletePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String password = request.getParameter("password");

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.userCheck(id, password);

if(mb != null) {
	mdao.deleteMember(mb);
	session.invalidate();
	%>
	<script type="text/javascript">
		alert("탈퇴가 완료되었습니다.");
		location.href = "../home/main.jsp";
	</script><%
} 
%>
</body>
</html>