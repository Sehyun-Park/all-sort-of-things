<%@page import="java.awt.print.Printable"%>
<%@page import="galary.GalaryDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="galary.GalaryBean"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
</head>
<body>
<% 
String uploadPath = request.getRealPath("/upload");
int maxSize = 10 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

int galNum = 0;
String galName = multi.getParameter("galName");
String galTitle = multi.getParameter("galTitle");
String galFile = multi.getFilesystemName("galFile");
Timestamp galDate = new Timestamp(System.currentTimeMillis());
int heartCount = 0;

GalaryBean gb = new GalaryBean(galNum, galName, galTitle, galFile, galDate, heartCount);

GalaryDAO gdao = new GalaryDAO();
gdao.insertGalary(gb);
%>
<script type="text/javascript">
	alert("글이 등록되었습니다 : )");
	location.href = "galaryList.jsp";
</script>
</body>
</html>