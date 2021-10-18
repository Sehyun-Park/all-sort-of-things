<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="galary.HeartDAO"%>
<%@page import="galary.GalaryBean"%>
<%@page import="galary.GalaryDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
	<link href="../css/home.css" rel="stylesheet" type="text/css">
	<link href="../css/galary.css" rel="stylesheet" type="text/css">
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
<!-- galary list -->
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
String pageNum = request.getParameter("pageNum");
if(pageNum == null) {
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);

// 페이징
int pageSize = 12;

int startRow = ((currentPage-1)*pageSize)+1;

GalaryDAO gdao = new GalaryDAO();
List<GalaryBean> galaryList = gdao.getGalaryList(startRow, pageSize);
%>
	<section id="galary">
		<input type="button" value="upload" onclick="location.href='upload.jsp'">
		<table>
			<tr>
			<%
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			for(int i = 0; i < galaryList.size(); i++) {
				GalaryBean gb = galaryList.get(i);
				HeartDAO hdao = new HeartDAO();
				boolean like = hdao.checkLike(gb.getGalNum(), mb.getId());
				%>
				<td><a href="galaryContent.jsp?galNum=<%=gb.getGalNum()%>"><img src="../upload/<%=gb.getGalFile()%>"></a><br><p><%if(like) {%><img src="../images/heardFull.png" onclick="unLike('<%=gb.getGalNum()%>')"><% } else {%><img src="../images/heartLine.png" onclick="like('<%=gb.getGalNum()%>')"><% }%><%=gb.getHeartCount()%></p></td>
			<% 
			if((i+1) % 4 == 0) {
			%>
			</tr>
			<tr>
			<%}
			}%>	
		</table>
		<div class="clear"></div>
		<div id="page_control">
		<%
		int pageBlock = 5;
		int startPage = ((currentPage - 1) / pageBlock) + 1;
		int endPage = startPage + pageBlock -1;
		int count = gdao.getGalaryCount();
		int pageCount = (count / pageSize) + (count % pageSize != 0 ? 1 : 0);
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if (startPage > pageBlock) {
			%>
			<a href="galaryList.jsp?pageNum = <%=startPage - pageBlock%>">Pre</a>
			<%
		}
		for(int i = 1; i <= endPage; i++){
			%>
			<a href="galaryList.jsp?pageNum=<%=i%>"><%= i %></a>
			<%
		}
		
		if (endPage < pageCount) {
		%>
			<a href="galaryList.jsp?pageNum=<%=startPage + pageBlock%>">Next</a>
		<%
		}
		%>
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