<%@page import="board.CommentBean"%>
<%@page import="java.util.List"%>
<%@page import="board.CommentDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	<link href="../css/board.css" rel="stylesheet" type="text/css">
<%
int num = Integer.parseInt(request.getParameter("num"));
BoardDAO bdao = new BoardDAO();
bdao.updateHit(num);
BoardBean bb = bdao.getBoard(num);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

// 데이터베이스에 저장되어 있는 \r\n을 enter로 바꿔주는 작업
String content = bb.getContent();
if(content != null) {
	content = content.replace("\r\n", "<br>");
}

%>
<script type="text/javascript">
	function checkD() {
		var askDelete = confirm("정말 삭제하시겠습니까?");
		if(askDelete) {
			location.href="deletePro.jsp?num=<%=bb.getNum()%>"
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
			<li><a href="../board/list.jsp" id="menuOn">Blog</a></li>
			<li><a href="../galary/galaryList.jsp">Galary</a></li>
			<li><a href="../letter/mail.jsp">Letter</a></li>
		</ul>
	</nav>
	<div id="clear"></div>
<!-- list	 -->
	<section id="content">
		<h2>no.<%=bb.getNum() %></h2>
		<table id="content">
			<tr>
				<th id="cth1">writer</th>
				<td id="ctd1"><%=bb.getName()%></td>
				<th id="cth2">hit</th>
				<td id="ctd2"><%=bb.getHit()%></td>
			</tr>
			<tr>
				<th id="cth1">title</th>
				<td id="ctd1"><%=bb.getTitle()%></td>
				<th id="cth2">date</th>
				<td id="ctd2"><%=sdf.format(bb.getDate())%></td>
			</tr>
			<tr id="ctr">
				<th id="cth1">content</th>
				<td colspan="3"><%=content %></td>
			</tr>
		</table>
		<div>
		<%
		String id = (String)session.getAttribute("id");
		
		MemberDAO mdao = new MemberDAO();
		MemberBean mb = mdao.getMember(id);
		
		if(id != null) {
			if(mb.getName().equals(bb.getName())) {
			%>
			<input type="button" value="edit" onclick="location.href='update.jsp?num=<%=bb.getNum()%>'">
			<input type="button" value="remove" onclick="checkD()">
			<%
			}
		} 
		%>
			<input type="button" value="list" onclick="location.href='list.jsp'">
		</div>
	</section>
	<section id="comment">
		<h2>comment</h2>
		<table id="table1" id="ta">
		<%
		
		CommentDAO cdao = new CommentDAO();
		List<CommentBean> commentList = cdao.getCommentList(num);
		if(commentList.size() > 0) {
		%>
			<tr>
				<th>No</th>
				<th id="commName">name</th>
				<th>comment</th>
				<th>date</th>
			</tr>
		<%
			for(int i = 0; i < commentList.size(); i++) {
				CommentBean cb = commentList.get(i);
				int commNum = cb.getCommNum();
				%>
<!-- 				<tr id="record"  onclick="editComm()"> -->
				<tr <%if(cb.getCommName().equals(mb.getName())) { %>id="record" onclick="editComm('<%=cb.getCommNum()%>')"<% } %>>
					<td><%=i+1%><span hidden id="commNum"><%=cb.getCommNum() %></span> </td>
					<td><%=cb.getCommName()%></td>
					<td id="commContent"><%=cb.getCommContent()%></td>
					<td><%=sdf.format(cb.getCommDate())%></td>
				</tr>
				<%
			}
		}
		%>
		</table>
		<form action="commentPro.jsp" method="post">
			<input type="hidden" name="boardNum" value="<%= bb.getNum()%>">
			
			<table id="table2">
				<tr>
					<th>who are you?</th>
					<td><input type="text" name="commName" value="<%=mb.getName()%>"></td>
				</tr>
				<tr>
					<th>say a word : )</th>
					<td><textarea rows="5" cols="35" name="commContent"></textarea></td>
				</tr>
			</table>
			<div>
				<input type="submit" value="leave comment">
			</div>
		</form>
	</section>
<script type="text/javascript">
function editComm(commNum) {
	
// 	alert(commNum);

	var popupWidth = 450;
	var popupHeight = 300;

	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	window.open("updateComment.jsp?commNum=" + commNum, 'edit comment', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
}
</script>
	
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
</body>
</html>