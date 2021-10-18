<%@page import="galary.GalaryBean"%>
<%@page import="galary.GalaryDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp6/updatePro.jsp</title>
</head>
<body>
<%
String uploadPath = request.getRealPath("/upload");
int maxSize = 10 * 1024 * 1024;
MultipartRequest multi = new MultipartRequest(request,uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

int galNum = Integer.parseInt(multi.getParameter("galNum"));
String galName = multi.getParameter("galName");
String galTitle = multi.getParameter("galTitle");
String galFile = multi.getFilesystemName("galFile");

if(galFile == null) {
	galFile = multi.getParameter("oldfile");
}
GalaryBean gb = new GalaryBean();

gb.setGalNum(galNum);
gb.setGalName(galName);
gb.setGalTitle(galTitle);
gb.setGalFile(galFile);

GalaryDAO gdao = new GalaryDAO();
gdao.updateGalary(gb);
%>
<script type="text/javascript">
	location.href="galaryContent.jsp?galNum=<%=gb.getGalNum()%>"
</script>
</body>
</html>