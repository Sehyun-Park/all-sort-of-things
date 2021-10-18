<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
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
int commNum = Integer.parseInt(request.getParameter("commNum"));

CommentDAO cdao = new CommentDAO();
cdao.deleteComment(commNum);
%>
<script type="text/javascript">
	opener.document.location.reload();
	self.close();
</script>
</body>
</html>