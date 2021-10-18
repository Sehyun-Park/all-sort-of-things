<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
			<li><a href="../board/list.jsp">Blog</a></li>
			<li><a href="../galary/galaryList.jsp" id="menuOn">Galary</a></li>
			<li><a href="../letter/mail.jsp">Letter</a></li>
		</ul>
	</nav>
	<div id="clear"></div>
<!-- write	 -->
<%-- 	<% --%>
<!-- 	String id = (String)session.getAttribute("id"); -->
<!-- 	if(id == null) { -->
<!-- 		response.sendRedirect("../member/login.jsp"); -->
<!-- 	} -->
<!-- 	MemberDAO mdao = new MemberDAO(); -->
<!-- 	MemberBean mb = mdao.getMember(id); -->
<!-- %> -->

	<section id="galaryWrite">
		<form action="galaryUpdatePro.jsp" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th>writer</th>
					<td><input type="text" name="name" value="" readonly id="name"></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>file</th>
					<td><input type="file" name="title" accept=".jpg,.png,.gif"></td>
				</tr>
				<tr>
					<th></th>
					<td><img src="../images/2.jpg"></td>
				</tr>
			</table>
			<div id="button">
				<input type="submit" value="update" class="btn">
			</div>
		</form>
	</section>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
</body>
</html>