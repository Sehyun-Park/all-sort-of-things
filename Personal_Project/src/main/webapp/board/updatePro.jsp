<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/updatePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8"); // post 방식일 때 필수
int num = Integer.parseInt(request.getParameter("num"));
String title = request.getParameter("title");
String content = request.getParameter("content");

BoardBean bb = new BoardBean();
bb.setNum(num);
bb.setTitle(title);
bb.setContent(content);

BoardDAO bdao = new BoardDAO();
bdao.updateBoard(bb);

response.sendRedirect("content.jsp?num=" + num);
%>
</body>
</html>