<%@page import="galary.HeartDAO"%>
<%@page import="galary.HeartBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int galNum = Integer.parseInt(request.getParameter("galNum"));
String id = (String)session.getAttribute("id");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
HeartDAO hdao = new HeartDAO();
int result = hdao.unLike(galNum, id);
if(result == 1) {
%>
<script type="text/javascript">
	window.location = document.referrer;
</script>
<%
}
%>
</body>
</html>