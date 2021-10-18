<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/loginPro.jsp</title>
</head>
<body>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.userCheck(id, password);

if(mb != null){
	session.setAttribute("id", id);
	response.sendRedirect("../home/main.jsp");
} else {
	%>
	<script type="text/javascript">
		alert("입력하신 정보가 틀립니다.");
		history.back();
	</script>
	<%
}
%>
</body>
</html>