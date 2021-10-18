<%@page import="board.BoardDAO"%>
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
int num = Integer.parseInt(request.getParameter("num"));

BoardDAO bdao = new BoardDAO();
bdao.deleteBoard(num);
bdao.updateBoardNum();

%>
<script type="text/javascript">
	alert("삭제가 완료되었습니다.");
	location.href = "list.jsp";
</script>
</body>
</html>