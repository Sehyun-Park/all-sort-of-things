<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.GoogleAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/joinPro.jsp</title>
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

MemberBean mb = new MemberBean();

mb.setId(id);
mb.setPassword(password);
mb.setName(name);
mb.setEmail(email);
mb.setPostcode(postcode);
mb.setAddress(address);
mb.setDetailAddress(detailAddress);
mb.setExtraAddress(extraAddress);
mb.setPhoneNum(phoneNum);

MemberDAO mdao = new MemberDAO();
mdao.insertMember(mb);

String sender = "seahyunpark522@gmail.com";
String receiver = email;
String subject = "all sort of things";
String content = "회원가입을 축하드립니다.";

Properties properties = System.getProperties();
// 1-2. Starttls Command 사용 설정
properties.put("mail.smtp.starttls.enable", "true");
// 1-3. SMTP 서버 지정
properties.put("mail.smtp.host", "smtp.gmail.com");
// 1-4. 사용자 메일 인증
properties.put("mail.smtp.auth", "true");
// 1-5. gamil 포트 설정
properties.put("mail.smpt.port", "587");
// 1-6. 인증 정보 생성
Authenticator auth = new GoogleAuthentication();
// 1-7. 메일 전송 역할을 하는 단위 Session 객체 생성
Session s = Session.getDefaultInstance(properties, auth);
// 1-8. Session 객체를 사용해 전송할 Message 객체 생성
Message message = new MimeMessage(s);

// 2. 보내는 사람 정보 저장
Address sender_address = new InternetAddress(sender);

// 3. 받는 사람 정보 저장
Address receiver_address = new InternetAddress(receiver);
message.setHeader("content-type", "text/html;charset=UTF-8");
message.setFrom(sender_address);
message.addRecipient(Message.RecipientType.TO, receiver_address);

// 4. 제목, 내용, 보내는 시간 정보 저장
// 4-1. 제목 설정
message.setSubject(subject);
// 4-2. 내용 설정
message.setContent(content, "text/html;charset=UTF-8");
// 4-1. 시간 설정
message.setSentDate(new Date());

// 5. 전송
Transport.send(message);

%>
<script type="text/javascript">
	alert("회원가입 완료 :)");
	location.href = "login.jsp";
</script>
</body>
</html>