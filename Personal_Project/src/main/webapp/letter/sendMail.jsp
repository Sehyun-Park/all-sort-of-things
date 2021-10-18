<%@page import="mail.GoogleAuthentication"%>
<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mail/mailSend.jsp</title>
</head>
<body>
<%
// 한글처리 & 파라미터 값 들고오기
request.setCharacterEncoding("utf-8");
String from = request.getParameter("from");
String to = request.getParameter("to");
String title = request.getParameter("title");
String content = request.getParameter("content");

// try - catch문으로 메일 보내는 과정 나열
try {
	// 1. 메일 보내는 서버 주소 설정
	// 1-1. Properties 객체에 서버 정보 저장
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
	
	// 3. 받는 사람 정보 저장
	message.setHeader("content-type", "text/html;charset=UTF-8");
	message.setFrom(new InternetAddress(from));
	message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	
	// 4. 제목, 내용, 보내는 시간 정보 저장
	// 4-1. 제목 설정
	message.setSubject(from);
	// 4-2. 내용 설정
	message.setContent("<b>" + title + "</b><br>" + content, "text/html;charset=UTF-8");
	// 4-1. 시간 설정
	message.setSentDate(new Date());
	
	// 5. 전송
	Transport.send(message);
	

	%>
	<script type="text/javascript">
		alert("메일이 정상적으로 발송되었습니다.");
		location.href="mail.jsp";
	</script>
	<%
} catch (Exception e) {
	out.println("메일이 정상적으로 발송되지 않았습니다.");
	e.printStackTrace();
}
%>
</body>
</html>