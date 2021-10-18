<%@page import="galary.HeartBean"%>
<%@page import="galary.HeartDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
	<link href="../css/home.css" rel="stylesheet" type="text/css">
	<link href="../css/board.css" rel="stylesheet" type="text/css">
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
request.setCharacterEncoding("utf-8");
// 페이지 넘버 가져오기(없으면 1로 설정, 정수화)
String pageNum = request.getParameter("pageNum");
if(pageNum == null) {
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);
// 페이징
int pageSize = 6;
int startRow = ((currentPage-1)*pageSize)+1;

BoardDAO bdao = new BoardDAO();
List<BoardBean> boardList = bdao.getBoardList(startRow, pageSize);


%>
<!-- brownie	 -->
	<section id="brownie">
		<img src="../images/brownie.png">
	</section>
	
<!-- list	 -->
	<section id="list">
		<table id="list">
			<tr>
				<th class="tno">No</th>
				<th class="ttitle">title</th>
				<th class="twriter">writer</th>
				<th class="tdate">date</th>
				<th class="thit">hit</th>
			</tr>
			<%
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			for(int i = 0; i < boardList.size(); i++) {
				BoardBean bb = boardList.get(i);
			%>	
			<tr onclick="location.href='content.jsp?num=<%=bb.getNum()%>'" id="record">
				<td><%=bb.getNum()%></td>
				<td><%=bb.getTitle()%></td>
				<td><%=bb.getName()%></td>
				<td><%=sdf.format(bb.getDate())%></td>
				<td><%=bb.getHit()%></td>
			</tr>
			<%
			}
			%>
		</table>
		<div id="table_search">
		<%
		String id = (String)session.getAttribute("id");
		if(id != null) {
		%>
			<div id="writeB">
				<input type="button" value="post" class="btn" onclick="location.href = 'write.jsp'">
			</div>
		<%
		}
		%>	
			<form action="search.jsp" method="post">
				<input type="text" name="search" class="input_box">
				<input type="submit" value="search" class="btn">
			</form>
		</div>
		<div class="clear"></div>
		<div id="page_control">
		<%
		int pageBlock = 5;
		int startPage = ((currentPage - 1) / pageBlock) + 1;
		int endPage = startPage + pageBlock -1;
		int count = bdao.getBoartCount();
		int pageCount = (count / pageSize) + (count % pageSize != 0 ? 1 : 0);
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if (startPage > pageBlock) {
			%>
			<a href="list.jsp?pageNum = <%=startPage - pageBlock%>">Pre</a>
			<%
		}
		for(int i = 1; i <= endPage; i++){
			%>
			<a href="list.jsp?pageNum=<%=i%>"><%= i %></a>
			<%
		}
		
		if (endPage < pageCount) {
		%>
			<a href="list.jsp?pageNum=<%=startPage + pageBlock%>">Next</a>
		<%
		}
		%>
		</div>
	</section>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
</body>
</html>