<%@page import="galary.HeartDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="galary.GalaryBean"%>
<%@page import="galary.GalaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
	<link href="../css/home.css" rel="stylesheet" type="text/css">
	<link href="../css/galary.css" rel="stylesheet" type="text/css">
<%
int galNum = Integer.parseInt(request.getParameter("galNum"));
GalaryDAO gbdao = new GalaryDAO();
GalaryBean gb = gbdao.getGalary(galNum);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<script type="text/javascript">
function checkD() {
	var askDelete = confirm("정말 삭제하시겠습니까?");
	if(askDelete) {
		location.href="galaryDelete.jsp?galNum=<%=gb.getGalNum()%>"
	}
}
</script>
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
	<section id="galaryContent">
	<h2>no.<%=gb.getGalNum() %></h2>
		<input type="button" value="list" onclick="location.href='galaryList.jsp'">
		<%
		String id = (String)session.getAttribute("id");
		
		MemberDAO mdao = new MemberDAO();
		MemberBean mb = mdao.getMember(id);
		
		HeartDAO hdao = new HeartDAO();
		boolean like = hdao.checkLike(gb.getGalNum(), mb.getId());
		
		if(id != null) {
			if(mb.getName().equals(gb.getGalName())) {%>
		<input type="button" value="remove" onclick="checkD">
		<input type="button" value="edit" onclick="location.href='galaryUpdate.jsp?galNum=<%=gb.getGalNum()%>'">
			<%}
		}%>
		<a href="../upload/<%=gb.getGalFile()%>" download><input type="button" value="download"></a>
		<div id="photo">
		<img src="../upload/<%=gb.getGalFile()%>">
		<table>
			<tr>
				<td><span>photographer</span><%=gb.getGalName()%></td>
				<td rowspan="3"><p><%if(like) {%><img src="../images/heardFull.png" onclick="unLike('<%=gb.getGalNum()%>')" id="heart"><% } else {%><img src="../images/heartLine.png" onclick="like('<%=gb.getGalNum()%>')" id="heart"><% }%><%=gb.getHeartCount()%></p></td>
			</tr>
			<tr>
				<td><span>title</span><%=gb.getGalTitle()%></td>
			</tr>
			<tr>
				<td><span>date</span><%=sdf.format(gb.getGalDate())%></td>
			</tr>
		</table>
		</div>
	</section>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
<script type="text/javascript">
	function like(galNum) {
		location.href="like.jsp?galNum=" + galNum;
	}
	function unLike(galNum) {
		location.href="unLike.jsp?galNum=" + galNum;
	}
</script>
</body>
</html>