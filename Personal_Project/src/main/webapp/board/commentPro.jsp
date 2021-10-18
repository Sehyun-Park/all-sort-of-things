<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
<%@page import="board.BoardDAO"%>
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

int commNum = 0;
String commName = request.getParameter("commName");
String commContent = request.getParameter("commContent");
Timestamp commDate = new Timestamp(System.currentTimeMillis());

int boardNum = Integer.parseInt(request.getParameter("boardNum"));

CommentBean cb = new CommentBean(commNum, commName, commContent, commDate, boardNum);

CommentDAO cdao = new CommentDAO();
cdao.insertComment(cb);
%>
<script type="text/javascript">
	location.href="content.jsp?num=<%=cb.getBoardNum()%>"
</script>
</body>
</html>