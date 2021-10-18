<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all sort of things</title>
<!-- css -->
<link href="../css/home.css" rel="stylesheet" type="text/css">
<link href="../css/member.css" rel="stylesheet" type="text/css">

<!-- 주소 검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- jsp -->
<script type="text/javascript">
	function winopen() {
		if(document.fr.id.value == "") {
			alert("아이디를 입력하세요.");
			document.fr.id.focuse();
			return;
		} else {
			var id = document.fr.id.value;
			
			var popupWidth = 400;
			var popupHeight = 150;

			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
			window.open("winopen.jsp?id=" +id, "", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}
	}
	
	function goPopup() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
	}
	
	function check() {
		if(document.getElementById("name").value == 0) { 
			alert("이름을 입력하세요");
			document.fr.name.focus();
			return false;
		}
		if(document.getElementById("id").value == 0) { 
			alert("아이디를 입력하세요");
			document.fr.id.focus();
			return false;
		}
		if(document.getElementById("password").value == 0) { // getElementById("id값") : document내 설정한 id 중 ()안 값을 찾아서 적용 
			alert("비밀번호를 입력하세요");
			document.fr.password.focus();
			return false;
		}
		if(document.fr.pwcheck.value.length > 0 && !(document.fr.pw.value == document.fr.pwcheck.value)) {
			alert("비밀번호가 일치하지 않습니다");
			document.fr.pwcheck.focus();
			return false;
		}
		if(document.getElementById("email").value == 0) { // getElementById("id값") : document내 설정한 id 중 ()안 값을 찾아서 적용 
			alert("이메일 주소를 입력하세요");
			document.fr.email.focus();
			return false;
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
	<section id="join">
	<h2>create account</h2>
		<form action="joinPro.jsp" method="post" name="fr" onsubmit="return check()">
			<table>
				<tr>
					<th>user name</th>
					<td><input type="text" name="name" id="name"></td>
				</tr>
				<tr>
					<th>id</th>
					<td><input type="text" name="id" id="id"><input type="button" value="dup. check" onclick="winopen()" id="button"></td>
				</tr>
				<tr>
					<th>password</th>
					<td><input type="password" name="password" id="password"></td>
				</tr>
				<tr>
					<th>confirm pasword</th>
					<td><input type="password" name="password2" id="pwcheck"></td>
				</tr>
				<tr>
					<th>email</th>
					<td><input type="email" name="email" id="email"></td>
				</tr>
				<tr>
					<th>address</th>
					<td><input type="text" name="postcode" id="postcode" placeholder="우편번호"><input type="text" name="address" id="address" placeholder="주소"><input type="button" value="find address" onclick="goPopup()" id="button"></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"></td>
				
				</tr>
				<tr>
					<th></th>
					<td><input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목"></td>
				<tr>
					<th>phone number</th>
					<td><input type="text" name="phoneNum" placeholder="010-1234-5678"></td>
				</tr>
				<tr>
					<th></th>
					<th>
						<input type="reset" value="reset" id="button">
						<input type="submit" value="sign up" id="button">
					</th>
				</tr>
			</table>
		</form>
	</section>
	<section id="welcome">
		
		<p>Welcome<br>to<br>my<br>blog</p>
	</section>
<jsp:include page="../home/bottom.jsp"></jsp:include>
</div>
</body>
</html>