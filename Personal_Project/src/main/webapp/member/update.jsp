<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/home.css" rel="stylesheet" type="text/css">
<link href="../css/member.css" rel="stylesheet" type="text/css">
<%
request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");

if(id == null) {
	response.sendRedirect("../member/login.jsp");
}
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);

%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- jsp -->
<script type="text/javascript">
	function goPopup() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("detailAddress").focus();
            }
        }).open();
	}
	
	function checkD() {
		var checkD = confirm("정말 계정을 삭제하시겠습니까?");
		
		if(checkD) {
			var passck = prompt("비밀번호를 입력하세요");
			if(passck == <%=mb.getPassword()%>) {
				location.href="deletePro.jsp?id=<%=mb.getId()%>&password=<%=mb.getPassword()%>";
			} else {
				alert("입력하신 정보가 일치하지 않습니다.");
			}
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
			<li><a href="../galary/galaryList.jsp">Galary</a></li>
			<li><a href="../letter/mail.jsp">Letter</a></li>
		</ul>
	</nav>
	<div id="clear"></div>
	<section id="update">
		<h2>personal info</h2>
		<form action="updatePro.jsp" method="post" name="fr">
			<table>
				<tr>
					<th>user name</th>
					<td><input type="text" name="name" value="<%=mb.getName()%>"></td>
				</tr>
				<tr>
					<th>id</th>
					<td><input type="text" name="id" value="<%=mb.getId()%>" readonly></td>
				</tr>
				<tr>
					<th>password</th>
					<td><input type="password" name="password"></td>
				</tr>
				<tr>
					<th>email</th>
					<td><input type="email" name="email" value="<%=mb.getEmail()%>"></td>
				</tr>
				<tr>
					<th>address</th>
					<td><input type="text" name="postcode" id="postcode" placeholder="우편번호" value="<%=mb.getPostcode() %>"><input type="text" id="address" name="address"  placeholder="주소" value="<%=mb.getAddress() %>"><input type="button" value="find address" onclick="goPopup()" id="button"></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="<%=mb.getDetailAddress() %>"></td>
				
				</tr>
				<tr>
					<th></th>
					<td><input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목" value="<%=mb.getExtraAddress()%>"></td>
				<tr>
					<th>phone number</th>
					<td><input type="text" name="phoneNum" value="<%=mb.getPhoneNum()%>"></td>
				</tr>
				<tr>
					<th></th>
					<th>
						<input type="button" value="delete" onclick="checkD()" id="button" >
						<input type="submit" value="update" id="button">
					</th>
				</tr>
			</table>
		</form>
	</section>
</div>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</body>
</html>