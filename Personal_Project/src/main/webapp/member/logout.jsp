<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/logout.jsp</title>
</head>
<body>
<%
session.invalidate();
response.sendRedirect("../home/main.jsp");
%>
<script type="text/javascript">
	alert("로그아웃 되었습니다.");
</script>
</body>
</html>