<%@page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/winopen.jsp</title>
<link href="../css/home.css" rel="stylesheet" type="text/css">
<link href="../css/member.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function result() {
			opener.document.fr.id.value = document.wfr.id.value;
			window.close();
		}
	</script>
</head>
<body>
<%
String id = request.getParameter("id");
MemberDAO mdao = new MemberDAO();

MemberBean mb = mdao.getMember(id);
%>
<form action="winopen.jsp" method="post" name="wfr" id="idcheck">
	User Id <input type="text" name="id" value="<%=id%>">
<%
if(mb != null) {
	out.println("아이디 중복\n");
} else {
	out.println("아이디 사용 가능\n");
	%>
	<input type="button" value="아이디 사용" onclick="result()">
	<%
}
%>
	<input type="submit" value="아이디 찾기"> 

</form>
</body>
</html>