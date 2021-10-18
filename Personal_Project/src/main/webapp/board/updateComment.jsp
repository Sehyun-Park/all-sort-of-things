<%@page import="board.CommentBean"%>
<%@page import="board.CommentDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
<%
request.setCharacterEncoding("utf-8");
int commNum = Integer.parseInt(request.getParameter("commNum"));

BoardDAO bdao = new BoardDAO();
CommentDAO cdao = new CommentDAO();
CommentBean cb = cdao.getComment(commNum);
%>
function checkD() {
	var askDelete = confirm("정말 삭제하시겠습니까?");
	if(askDelete) {
		location.href="deleteCommentPro.jsp?commNum=<%=commNum%>";
	}
}
</script>
<style type="text/css">
@font-face {
    font-family: 'GmarketSansBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
* {
	margin: 0 auto;
}
#comment input[type=submit]:hover{
	background-color: white;
	color: black;
	border: 3px solid black;
}
input[type=submit], input[type=button] {
	float: right;
    width: 140px;
    height: 33px;
    background-color: #121212;
    color: white;
    border-radius: 0;
    border: none;
    margin-top: 7px;
    font-family: 'GmarketSansBold';
}
input[type=submit] {
    margin-right: 10px;
}
input[type=button]:hover {
	background-color: white;
	color: black;
	border: 3px solid black;
}
</style>
</head>
<body>
<section id="comment">
<form action="updateCommentPro.jsp" method="post">
 <input type="hidden" name="commNum" value="<%=commNum%>">
	<table id="table2">
		<tr>
			<th>who are you?</th>
			<td><input type="text" name="commName" value="<%=cb.getCommName()%>" readonly></td>
		</tr>
		<tr>
			<th>say a word : )</th>
			<td><textarea rows="5" cols="35" name="commContent"><%=cb.getCommContent() %></textarea></td>
		</tr>
	</table>
	<div>
		<input type="button" value="remove" onclick="checkD()">&nbsp;&nbsp;&nbsp;<input type="submit" value="edit" id="edit">
	</div>
</form>

</section>
</body>
</html>