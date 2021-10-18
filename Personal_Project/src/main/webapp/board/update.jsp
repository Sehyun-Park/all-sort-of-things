<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
	<link href="../css/home.css" rel="stylesheet" type="text/css">
	<link href="../css/writeTable.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../home/top.jsp"></jsp:include>
<!-- menu -->
	<nav id="menu">
		<ul>
			<li><a href="../home/main.jsp">Home</a></li>
			<li><a href="../board/list.jsp" id="menuOn">Blog</a></li>
			<li><a href="../galary/galaryList.jsp">Galary</a></li>
			<li><a href="../letter/mail.jsp">Letter</a></li>
		</ul>
	</nav>
	<div id="clear"></div>
<%
String id = (String)session.getAttribute("id");
if(id == null) {
	response.sendRedirect("../member/login.jsp");
}

int num = Integer.parseInt(request.getParameter("num"));
BoardDAO bdao = new BoardDAO();
BoardBean bb = bdao.getBoard(num);
%>
<!-- write	 -->
	<section id="write">
		<form action="updatePro.jsp" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<table>
				<tr>
					<th>writer</th>
					<td><input type="text" name="name" value="<%=bb.getName()%>" readonly id="name"></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" name="title" value="<%=bb.getTitle()%>"></td>
				</tr>
				<tr>
					<th>content</th>
					<td><textarea rows="10" cols="20" name="content" ><%=bb.getContent()%></textarea></td>
				</tr>
			</table>
			<div id="button">
				<input type="submit" value="register" class="btn">
			</div>
		</form>
	</section>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
</body>
</html>