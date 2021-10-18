<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
<%@page import="java.sql.Timestamp"%>
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
String commContent = request.getParameter("commContent");
Timestamp commDate = new Timestamp(System.currentTimeMillis());

CommentBean cb = new CommentBean();
cb.setCommNum(commNum);
cb.setCommContent(commContent);
cb.setCommDate(commDate);

CommentDAO cdao = new CommentDAO();
cdao.updateComment(cb);
%>
<script type="text/javascript">
	opener.document.location.reload();
	self.close();
</script>
</body>
</html>