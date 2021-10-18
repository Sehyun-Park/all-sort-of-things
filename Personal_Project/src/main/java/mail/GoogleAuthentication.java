package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	// 사용자 정보를 저장할 변수 선언
	PasswordAuthentication passAuth;
	
	// 생성자를 호출하면 변수에 아이디와 비밀번호 저장
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("seahyunpark522", "gsbmiajhgyfxjtkw");
	}
	
	// 아이디 비밀번호 인증 정보를 담은 변수 리턴하는 getPasswordAuthentication() 메서드 정의
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
