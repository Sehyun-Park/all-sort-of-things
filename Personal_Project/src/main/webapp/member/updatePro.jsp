<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/updatePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String password = request.getParameter("password");
String name = request.getParameter("name");
String email = request.getParameter("email");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");
String extraAddress = request.getParameter("extraAddress");
String phoneNum = request.getParameter("phoneNum");

MemberDAO mdao = new MemberDAO();

MemberBean mb = mdao.userCheck(id, password);

if(password.isEmpty()) {
	%>
	<script type="text/javascript">
		alert("비밀번호를 입력해주세요.");
		history.back();
	</script>
	<%
} else if(mb != null) {
	MemberBean mb2 = new MemberBean();
	
	mb2.setId(id);
	mb2.setPassword(password);
	mb2.setName(name);
	mb2.setEmail(email);
	mb2.setPostcode(postcode);
	mb2.setAddress(address);
	mb2.setDetailAddress(detailAddress);
	mb2.setExtraAddress(extraAddress);
	mb2.setPhoneNum(phoneNum);
	
	mdao.updateMember(mb2);
	%>
	<script type="text/javascript">
		alert("회원정보가 수정되었습니다.");
		location.href = "update.jsp";
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
		alert("입력하신 정보가 일치하지 않습니다.");
		history.back();
	</script>
	<%
}
%>
</body>
</html>