package com.school.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.school.dto.UserVO;
import com.school.mail.MimeAttachNotifier;
import com.school.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	// ★ 추가: 메일 발송 클래스 주입
	@Autowired
	private MimeAttachNotifier mailNotifier;
	
	
	@GetMapping("/commons/join")
	public String joinForm() {
		return "commons/join";
	}
	
	// ★ 추가: 이메일 인증번호 발송 (AJAX)
	@PostMapping("/commons/sendCode")
	@ResponseBody
	public String sendCode(@RequestParam("userEmail") String userEmail, 
						   HttpSession session) {
		try {
			// MimeAttachNotifier로 메일 발송 → 인증번호 리턴
			String code = mailNotifier.sendVerifyCode(userEmail);
			
			// 세션에 인증번호, 만료시간 저장
			session.setAttribute("emailCode", code);
			session.setAttribute("emailCodeTime", System.currentTimeMillis());
			
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	// ★ 추가: 인증번호 검증 (AJAX)
	@PostMapping("/commons/verifyCode")
	@ResponseBody
	public String verifyCode(@RequestParam("code") String code, 
							 HttpSession session) {
		
		String savedCode = (String) session.getAttribute("emailCode");
		Long savedTime = (Long) session.getAttribute("emailCodeTime");
		
		// 인증번호가 없는 경우
		if (savedCode == null || savedTime == null) {
			return "expired";
		}
		
		// 5분(300000ms) 초과 시 만료
		if (System.currentTimeMillis() - savedTime > 300000) {
			session.removeAttribute("emailCode");
			session.removeAttribute("emailCodeTime");
			return "expired";
		}
		
		// 인증번호 일치 확인
		if (savedCode.equals(code)) {
			session.setAttribute("emailVerified", true);
			session.removeAttribute("emailCode");
			session.removeAttribute("emailCodeTime");
			return "success";
		} else {
			return "fail";
		}
	}
	
	// ★ 수정: 회원가입 (이메일 인증 확인 추가)
	@PostMapping("/commons/join")
	public String regist(UserVO user, HttpSession session) throws SQLException {
		
		// 이메일 인증 여부 확인
		Boolean verified = (Boolean) session.getAttribute("emailVerified");
		if (verified == null || !verified) {
			return "commons/join";
		}
		
		userService.regist(user);
		
		// 인증 세션 정리
		session.removeAttribute("emailVerified");
		
		return "commons/login";
	}
	
	
	// ===== 로그인 =====
	
		@GetMapping("/commons/login")
		public String loginForm() {
		    return "commons/login";
		}
	
		@PostMapping("/commons/login")
		public String login(@RequestParam("userEmail") String userEmail,
							@RequestParam("userPwd") String userPwd,
							HttpSession session,
							RedirectAttributes rttr) {
			try {
				UserVO loginUser = userService.login(userEmail, userPwd);
				
				if (loginUser == null) {
					rttr.addFlashAttribute("message", "이메일 또는 비밀번호가 일치하지 않습니다.");
					return "redirect:/commons/login";
				}
				
				// 세션에 로그인 유저 정보 저장
				session.setAttribute("loginUser", loginUser);
				session.setMaxInactiveInterval(1800); // 30분
				
				// 로그인 성공 → 메인페이지로 이동
				return "redirect:/main";
				
			} catch (SQLException e) {
				e.printStackTrace();
				rttr.addFlashAttribute("message", "서버 오류가 발생했습니다.");
				return "redirect:/commons/login";
			}
		}
		
		// ===== 인러닝 (역할별 분기) =====

		@GetMapping("/inlearning")
		public String dashboard(HttpSession session) {
		    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		    
		    if (loginUser == null) {
		        return "redirect:/commons/login";
		    }
		    
		    String role = loginUser.getUserRole();
		    if ("관리자".equals(role)) {
		        return "redirect:/admin/admin_main";
		    } else if ("강사".equals(role)) {
		        return "redirect:/lecterer/mainDashBoard";
		    } else {
		        return "redirect:/user/dashBoard";
		    }
		}
		
		@GetMapping("/lecterer/profile")
		public String profileForm(HttpSession session, Model model) {
			
			//로그인 정보 가져오기
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			
			if (loginUser == null) return "redirect:/commons/login";
			
			model.addAttribute("loginUser", loginUser);
			
			return "lecterer/profile";
			
		}
		
		@Value("${savedPath.lecterer.photo}")
		private String picturePath;
		
		@PostMapping("/lecterer/profile")
		public String updateLectererProfile(@ModelAttribute UserVO user,
											@RequestParam ("uploadProfile") MultipartFile file,
											@RequestParam("type") String type,
											HttpSession session,
											RedirectAttributes rttr) throws Exception {
			
			// 로그인 정보 가져오기
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			if (loginUser == null) {
				
				rttr.addFlashAttribute("msg", "로그인 세션이 만료되었습니다.");
				
				return "redirect:/commons/login";
				
			}
			
			user.setUserNum(loginUser.getUserNum());
			
			// 폴더 존재 여부 확인
			File uploadDir = new File(picturePath);
			
			if (!uploadDir.exists()) uploadDir.mkdirs();
			
			// 파일 저장 과정
			if (file != null && !file.isEmpty()) {
				
				// 기존 파일 삭제
				String oldFileName = loginUser.getUserPhoto();
				
				if (oldFileName != null) {
					
					File oldFile = new File(picturePath, oldFileName);
					
					if (oldFile.exists()) oldFile.delete();
					
				}
				
				// 새 파일 저장
				String saveName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename();
				File newFile = new File(picturePath, saveName);
				file.transferTo(newFile);
				
				//VO에 새 파일명 넣기
				user.setUserPhoto(saveName);
				
			} else {
				
				// 새로운거 없으면 기존거 유지
				user.setUserPhoto(loginUser.getUserPhoto());
				
			}
			
			// DB에 저장
			boolean success = userService.updateLectererProfile(user);
			
			// 사용자에게 보여줌
			if (success) {
				
			    loginUser.setUserPhoto(user.getUserPhoto());
			    
			    // 2. 새로 저장된 사진 파일명만 기존 정보에 덮어씌웁니다.
			    if (loginUser != null) {
			    	
			        loginUser.setUserPhoto(user.getUserPhoto());
			        
			        session.setAttribute("loginUser", loginUser);
			        
			    }

			    rttr.addFlashAttribute("msg", "프로필이 성공적으로 " + type + "되었습니다.");
			    

			} else {
				
			    rttr.addFlashAttribute("msg", "프로필 " + type + "이 서버 장애로 인해 불가능합니다.");
			    
			}

			return "redirect:/lecterer/profile";
			
		}

		// ===== 로그아웃 =====
		
		@GetMapping("/commons/logout")
		public String logout(HttpSession session) {
			session.invalidate();
			return "redirect:/commons/login";
		}
	
}