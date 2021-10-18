<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
	<link href="../css/home.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="top.jsp"></jsp:include>
<!-- menu -->
	<nav id="menu">
		<ul>
			<li><a href="../home/main.jsp" id="menuOn">Home</a></li>
			<li><a href="../board/list.jsp">Blog</a></li>
			<li><a href="../galary/galaryList.jsp">Galary</a></li>
			<li><a href="../letter/mail.jsp">Letter</a></li>
		</ul>
	</nav>
	<div id="clear"></div>
	<main>
		<div id="main">
		<p>Scroll down<br>
		   and<br>
		   you'll find<br>
		   my contact</p>
		   <img src="../images/dessert.png" class="rotate-center">
		</div>
	</main>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
</body>
</html>