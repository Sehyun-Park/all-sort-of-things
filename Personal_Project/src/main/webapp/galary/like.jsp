<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="galary.HeartDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="galary.HeartBean"%>
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
int hNum = 0;
String id = (String)session.getAttribute("id");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
HeartBean hb = new HeartBean(hNum, galNum, mb.getId());
HeartDAO hdao = new HeartDAO();
int result = hdao.insertLike(hb);
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