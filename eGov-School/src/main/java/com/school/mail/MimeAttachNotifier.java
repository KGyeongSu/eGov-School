package com.school.mail;

import java.util.Random;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MimeAttachNotifier {

	private JavaMailSender mailSender;

	public MimeAttachNotifier(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	// 인증번호 메일 발송
	public String sendVerifyCode(String receiver) throws Exception {
		
		// 6자리 랜덤 인증번호 생성
		String code = String.format("%06d", new Random().nextInt(1000000));
		
		// 메시지 생성
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

		// 받는사람
		helper.setTo(new InternetAddress(receiver));
		// 보내는사람
		helper.setFrom("rudtn778@naver.com", "eGov-School");
		// 제목
		helper.setSubject("[eGov-School] 회원가입 이메일 인증번호");
		// 내용 (HTML)
		String content = 
			"<div style='padding:20px; font-family:맑은 고딕;'>"
			+ "<h2 style='color:#2c3e50;'>eGov-School 이메일 인증</h2>"
			+ "<p>아래 인증번호를 입력해주세요.</p>"
			+ "<div style='background:#f0f0f0; padding:15px 20px; font-size:24px; "
			+ "font-weight:bold; letter-spacing:5px; display:inline-block;'>"
			+ code
			+ "</div>"
			+ "<p style='color:#999; margin-top:15px;'>인증번호는 5분간 유효합니다.</p>"
			+ "</div>";
		helper.setText(content, true);

		// 메일 보내기
		mailSender.send(message);
		
		return code;
	}
}