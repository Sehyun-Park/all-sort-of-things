<%@page import="galary.GalaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int galNum = Integer.parseInt(request.getParameter("galNum"));

GalaryDAO gdao = new GalaryDAO();
gdao.deleteGalary(galNum);
%>
<script type="text/javascript">
	alert("삭제가 완료되었습니다.");
	location.href = "galaryList.jsp";
</script>
</html>