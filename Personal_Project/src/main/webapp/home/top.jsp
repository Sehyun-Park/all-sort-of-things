<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home/top.jsp</title>
	<link href="../css/home.css" rel="stylesheet" type="text/css">
<style>

</style>
</head>
<body>
<header>
<!-- 로그인, 회원가입 -->
<!-- logo -->
	<div id="logo">
		<h1><a href="../home/main.jsp">all sort of things</a></h1>
	</div>
<%
String id = (String)session.getAttribute("id");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
if(id == null) {
%>
	<div id ="miniMenu">
		<a href="../member/login.jsp">login</a>&nbsp;&nbsp;<a href="../member/join.jsp">sign up</a>
	</div>
	<%
} else {
	%>
	<div id ="miniMenu">
		<span id="miniMenuName"><%=mb.getName()%> 님</span>&nbsp;&nbsp;<a href="../member/update.jsp">info</a>&nbsp;&nbsp;<a href="../member/logout.jsp">logout</a>
	</div>
<%
}
%>
	<div class="clear"></div>

</header>
</body>
</html>