package com.school.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;
import com.school.dto.UserVO;
import com.school.mail.MimeAttachNotifier;
import com.school.service.ClassService;
import com.school.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private MimeAttachNotifier mailNotifier;
    @Autowired
    private ClassService classService;

    
    
    @GetMapping("/")
    public String home() {
        return "redirect:/main";
    }
    
    
    @GetMapping("/main")
    public String mainPage(PageMaker pageMaker, Model model) throws Exception {
    	
    	pageMaker.setPerPageNum(15); // 메인 페이지에서는 한 페이지에 5개씩 3줄 노출.
    	
        List<ClassVO> classList = classService.selectApprovedClassList(pageMaker);

        int totalCount = classService.selectApprovedClassListCount(pageMaker);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("classList", classList);
        model.addAttribute("pageMaker", pageMaker);

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
            return "redirect:/admin/main";
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
	        Boolean verified = (Boolean) session.getAttribute("emailVerified");
	        if (verified == null || !verified) {
	            return "commons/repwd";
	        }

	        String userEmail = (String) session.getAttribute("repwdEmail");
	        if (userEmail == null) {
	            return "commons/repwd";
	        }

	        userService.updateUserPwd(userEmail, userPwd);

	        session.removeAttribute("emailVerified");
	        session.removeAttribute("repwdEmail");

	        rttr.addFlashAttribute("message", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
	        return "redirect:/commons/login";

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "commons/repwd";
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

}
