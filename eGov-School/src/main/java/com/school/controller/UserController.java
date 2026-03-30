package com.school.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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


    // ===== 403 접근 거부 페이지 =====

    @GetMapping("/commons/accessDenied")
    public String accessDenied() {
        return "commons/accessDenied";
    }

}
