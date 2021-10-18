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
request.setCharacterEncoding("utf-8");

int num = 0;
String name = request.getParameter("name");
String title = request.getParameter("title");
String content = request.getParameter("content");
int hit = 0;
Timestamp date = new Timestamp(System.currentTimeMillis());

BoardBean bb = new BoardBean(num, name, title, content, hit, date);

BoardDAO bdao = new BoardDAO();
bdao.insertBoard(bb);
%>
<script type="text/javascript">
	alert("글이 등록되었습니다 : )");
	location.href = "list.jsp";
</script>
</body>
</html>