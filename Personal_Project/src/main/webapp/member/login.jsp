<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/home.css" rel="stylesheet" type="text/css">
<link href="../css/member.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../home/top.jsp"></jsp:include>
<!-- menu -->
	<nav id="menu">
		<ul>
			<li><a href="../home/main.jsp">Home</a></li>
			<li><a href="../board/list.jsp">Blog</a></li>
			<li><a href="../galary/galaryList.jsp">Galary</a></li>
			<li><a href="../letter/mail.jsp">Letter</a></li>
		</ul>
	</nav>
	<div id="clear"></div>
	<section id="login">
		<form action="loginPro.jsp" method="post" id="join">
			<table >
				<tr>
					<th>id</th>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<th>password</th>
					<td><input type="password" name="password"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="reset" value="reset" id="button"><input type="submit" value="login" id="button"></td>
				</tr>
			</table>
		</form>
	</section>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
</body>
</html>