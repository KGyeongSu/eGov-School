package com.school.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.school.dto.UserVO;
import com.school.mail.MimeAttachNotifier;
import com.school.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private MimeAttachNotifier mailNotifier;

    
    
    @GetMapping("/")
    public String home() {
        return "main";
    }
    
    @GetMapping("/main")
    public String mainPage() {
        return "main";
    }
    
    // ===== 회원가입 =====
    @GetMapping("/commons/join")
    public String joinForm() {
        return "commons/join";
    }

    // 이메일 인증번호 발송 (AJAX)
    @PostMapping("/commons/sendCode")
    @ResponseBody
    public String sendCode(@RequestParam("userEmail") String userEmail,
                           HttpSession session) {
        try {
            String code = mailNotifier.sendVerifyCode(userEmail);
            session.setAttribute("emailCode", code);
            session.setAttribute("emailCodeTime", System.currentTimeMillis());
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    // 인증번호 검증 (AJAX)
    @PostMapping("/commons/verifyCode")
    @ResponseBody
    public String verifyCode(@RequestParam("code") String code,
                             HttpSession session) {

        String savedCode = (String) session.getAttribute("emailCode");
        Long savedTime = (Long) session.getAttribute("emailCodeTime");

        if (savedCode == null || savedTime == null) {
            return "expired";
        }

        if (System.currentTimeMillis() - savedTime > 300000) {
            session.removeAttribute("emailCode");
            session.removeAttribute("emailCodeTime");
            return "expired";
        }

        if (savedCode.equals(code)) {
            session.setAttribute("emailVerified", true);
            session.removeAttribute("emailCode");
            session.removeAttribute("emailCodeTime");
            return "success";
        } else {
            return "fail";
        }
    }

    // 회원가입 처리
    @PostMapping("/commons/join")
    public String regist(UserVO user, HttpSession session) throws SQLException {

        Boolean verified = (Boolean) session.getAttribute("emailVerified");
        if (verified == null || !verified) {
            return "commons/join";
        }

        userService.regist(user);
        session.removeAttribute("emailVerified");

        return "commons/login";
    }


    // ===== 로그인 =====

    // 로그인 폼 보여주기만 담당
    // 실제 로그인 처리는 Security가 담당
    @GetMapping("/commons/login")
    public String loginForm() {
        return "commons/login";
    }
    
    // 인러닝 대시보드로 이동 (인러닝은 로그인한 사람만 접근 가능)
    @GetMapping("/inlearning")
    public String inlearning() {
        // Security가 인증 정보 갖고 있으니까 세션 체크 필요없음
        // SpringSecurityConfig에서 .authenticated() 로 막아줌
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().iterator().next().getAuthority();
        
        if ("ROLE_관리자".equals(role)) {
            return "redirect:/admin/admin_main";
        } else if ("ROLE_강사".equals(role)) {
            return "redirect:/lecterer/mainDashBoard";
        } else {
            return "redirect:/user/dashBoard";
        }
    }
    

    // 403 접근 거부 페이지
    @GetMapping("/commons/accessDenied")
    public String accessDenied() {
        return "commons/accessDenied";
    }
    
    
    // 비밀번호 찾기
    @GetMapping("/commons/repwd")
    public String repwdForm() {
		return "commons/repwd";
	}

	// 인증번호 발송 (AJAX)
	// 회원가입 sendCode와 다른 점 → DB에 이메일 존재 여부 먼저 확인!
	@PostMapping("/commons/repwd/sendCode")
	@ResponseBody
	public String repwdSendCode(@RequestParam("userEmail") String userEmail, HttpSession session) {
		try {
			// 1. DB에서 이메일 존재 여부 확인
			UserVO user = userService.getUserByEmail(userEmail);

			if (user == null) {
				return "notFound"; // 이메일 없으면 notFound 리턴
			}

			// 2. 이메일 있으면 인증번호 발송
			String code = mailNotifier.sendVerifyCode(userEmail);

			// 3. 세션에 인증번호, 발송시간 저장
			session.setAttribute("emailCode", code);
			session.setAttribute("emailCodeTime", System.currentTimeMillis());

			// 4. 나중에 비밀번호 변경할 때 어떤 이메일인지 알아야 해서 저장!
			session.setAttribute("repwdEmail", userEmail);

			return "success";

		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	// 비밀번호 변경 처리
	@PostMapping("/commons/repwd")
	public String repwd(@RequestParam("userPwd") String userPwd, HttpSession session, RedirectAttributes rttr)
			throws SQLException {
		try {
			// 1. 인증 여부 확인
			Boolean verified = (Boolean) session.getAttribute("emailVerified");
			if (verified == null || !verified) {
				return "commons/repwd"; // 인증 안됐으면 다시 폼으로
			}

			// 2. 세션에서 이메일 꺼내기
			String userEmail = (String) session.getAttribute("repwdEmail");
			if (userEmail == null) {
				return "commons/repwd";
			}

			// 3. 비밀번호 변경 (BCrypt 암호화는 ServiceImpl에서 처리)
			userService.updateUserPwd(userEmail, userPwd);

			// 4. 세션 정리
			session.removeAttribute("emailVerified");
			session.removeAttribute("repwdEmail");

			// 5. 로그인 페이지로 이동 + 완료 메시지
			rttr.addFlashAttribute("message", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
			return "redirect:/commons/login";

		} catch (Exception e) {
			e.printStackTrace();
			return "commons/repwd";
		}

	}
    
    

}
