
package com.school.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.school.cmd.PageMaker;
import com.school.dto.CertifiCateVO;
import com.school.dto.ClassVO;
import com.school.dto.MessageVO;
import com.school.dto.TestVO;
import com.school.dto.UserVO;
import com.school.service.CertificateService;
import com.school.service.ClassService;
import com.school.service.MessageService;
import com.school.service.TestService;
import com.school.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/lecterer")
public class TestLectererController {
	
	private final ClassService classService;
	private final TestService testService;
	private final MessageService messageService;
	private final UserService userService;
	private final CertificateService certificateService;
	
	public TestLectererController(ClassService classService, TestService testService, MessageService messageService, UserService userService, CertificateService certificateService) {
		
		this.classService = classService;
		this.testService = testService;
		this.messageService = messageService;
		this.userService = userService;
		this.certificateService = certificateService;
		
	}



	@GetMapping("/resultManage")
	public String resultManage (PageMaker pageMaker, HttpSession session, Model model) throws Exception {
		
		// 로그인 정보 꺼내기
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null) return "redirect:/commons/login";
		
		String userNum = loginUser.getUserNum();
		
		// 평가 출제 대상 강의 보여주기
		List <ClassVO> testClassList = classService.selectTestClassList(pageMaker, userNum);
		
		// 모델에 담아서 보여주기
		model.addAttribute("testList", testClassList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "lecterer/resultManage";
	}
	
	@GetMapping("/testMake")
	public String testMake(@RequestParam("claNum") String claNum, Model model) throws Exception {
		
		//해당 테스트 출제하기 버튼 클릭 시
		ClassVO testMake = classService.selectClassByCla_num(claNum);
		
		//model로 보여주기
		model.addAttribute("testMake", testMake);
		
		return "lecterer/testMake";
		
	}
	
	@PostMapping("/testMake")
	@ResponseBody
	public String insertTestMake( HttpSession session, @RequestBody TestVO test, @RequestParam("claNum") String claNum) throws Exception {
		
		// userNum 세팅해주기 (보안)
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		test.setUserNum(loginUser.getUserNum());
		
		// calNum 입력해주기
		test.setClaNum(claNum);
		
		// 서비스에 테스트 리스트 주기
		testService.insertTest(test);
		
		return "success";
		
	}
	
	@GetMapping("/testEdit")
	public String testEdit (HttpSession session, @RequestParam("claNum") String claNum, Model model) throws SQLException {
		
		// 로그인 정보 가져오기
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) return "redirect:/commons/login";
		
		// 시험 수정 대상 강의 정보 가져와서 보여주기
		ClassVO testEditInfo = classService.selectClassByCla_num(claNum);
		
		// 시험문제 가져오기
		TestVO testEdit = testService.selectTestWithQuestions(claNum);
		
		// 모델에 담기
		model.addAttribute("testEditInfo", testEditInfo);
		model.addAttribute("testEdit", testEdit);
		
		return "lecterer/testMake";
			
	
	}
	
	@PostMapping("/testEdit")
	@ResponseBody
	public String updateTestEdit( HttpSession session, @RequestBody TestVO test, @RequestParam("claNum") String claNum) throws Exception {
		
		// userNum 세팅해주기 (보안)
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		test.setUserNum(loginUser.getUserNum());
		
		// calNum 입력해주기
		test.setClaNum(claNum);
		
		// 서비스에 테스트 리스트 주기
		testService.updateTest(test);
		
		return "success";
		
	}
	
	@GetMapping("/resultSend")
	public String rusultSendList (PageMaker pageMaker, HttpSession session,  Model model) throws Exception {
		
		// 강사 정보 확인
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null) return "redirect:/commons/login";
		
		String userNum = loginUser.getUserNum();
		
		// 강의 리스트 뿌려주기
		List <ClassVO> resultSendList = classService.selectTestClassList(pageMaker, userNum);
		
		// 수료증 등록, 수정 버튼 활성화 목적
		if (resultSendList != null) {
	        for (ClassVO classVO : resultSendList) {
	        	
	            // 해당 강의번호(claNum)로 수료증이 있는지 DB 조회
	            CertifiCateVO certi = certificateService.selectCertifiCate(classVO.getClaNum());
	            
	            if (certi != null) {
	                // 수료증이 있다면 그 번호를 ClassVO에 임시로 저장!
	                classVO.setCerNum(certi.getCerNum());
	            }
	        }
	    }
		
		// 모델에 담아서 모여주기
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("resultSendList", resultSendList);
		
		return "lecterer/resultSend";
		
	}
	
	@GetMapping ("/messageForm")
	public String messageForm (@RequestParam("claNum") String claNum, @RequestParam("tetNum") String tetNum, Model model) throws Exception{
		
		// 평가 발송 대상 강의 정보 가져오기
		ClassVO messageClassInfo = classService.selectClassByCla_num(claNum);
		messageClassInfo.setTetNum(tetNum);
		
		// 모델에 담아서 전달
		model.addAttribute("mClassInfo", messageClassInfo);
		
		return "lecterer/messageForm";
		
	}
	
	// messageForm 내 수강한 학생 리스트 보여주는 용
	@ResponseBody
	@GetMapping ("/searchStudent")
	public List <UserVO> searchStudent (@RequestParam("claNum") String claNum, @RequestParam("tetNum") String tetNum) throws Exception {
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setPerPageNum(999);
		
		List<UserVO> searchStudent = classService.selectUnsentStudentList(claNum, tetNum);
		
		return searchStudent;
		
	}
	
	// messageForm에 사용자 패논패 뿌려줄 목적
	@ResponseBody
	@GetMapping("/passStudent")
	public String passStudent (String userNum, String claNum) throws Exception {
		
		// 서비스 부르기
		String pnp = messageService.selectPassStudentByUserNum(userNum, claNum);
		
		return (pnp != null )? pnp : "N";
		
	}
	
	@ResponseBody
	@PostMapping("/messageGo")
	public String messageGo (HttpSession session, MessageVO message) throws Exception {
		
		// 발신자 세팅
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) return "fail";
				
		message.setMsSenderNum(loginUser.getUserNum());
		
		// 메시지 테이블에 저장
		messageService.insertMessage(message);
		
		return "success";
		
	}
		
	@GetMapping ("/giveForm")
	public String giveForm (@RequestParam("claNum") String claNum, Model model) throws Exception{
		
		// 평가 발송 대상 강의 정보 가져오기
		ClassVO giveClassInfo = classService.selectClassByCla_num(claNum);
		
		// 관리자 리스트
		List<UserVO> adminList = userService.getAdminList();
		
		// 모델에 담아서 전달
		model.addAttribute("gClassInfo", giveClassInfo);
		model.addAttribute("adminList", adminList);
		
		return "lecterer/giveForm";
		
	}
	
	@PostMapping("/giveFormGo")
	@ResponseBody
	public String giveFormGo (HttpSession session, MessageVO message, @RequestParam(value="uploadFile", required=false) MultipartFile uploadFile) throws Exception {
		
		// 발신인 넣기
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null) return "fail";
		message.setMsSenderNum(loginUser.getUserNum());
		
		messageService.insertMessageFile(message, uploadFile);
		
		return "success";
		
	}
	
	@GetMapping("/certiGo")
	public String certiGO (@RequestParam("claNum") String claNum, Model model) throws Exception{
			
			// 평가 발송 대상 강의 정보 가져오기
			ClassVO certiClassInfo = classService.selectClassByCla_num(claNum);
			
			// 수정 시 활용
			CertifiCateVO certiInfo = certificateService.selectCertifiCate(claNum);
			
			// 모델에 담아서 전달
			model.addAttribute("cClassInfo", certiClassInfo);
			model.addAttribute("certiInfo", certiInfo);
			
			return "lecterer/certiGo";
			
	}
	
	@PostMapping("/certiGo")
	@ResponseBody
	public String certiGo (@RequestParam("claNum") String claNum, 
                           @RequestParam("uploadFile") MultipartFile uploadFile) throws Exception {
		
		try {
			// 시퀀스 번호
			String cerNum = certificateService.selectCertifiCateSeqNext();
			
			// 서비스에 보내기
			certificateService.insertCertifiCate(cerNum, claNum, uploadFile);
			
			return "success";
			
		} catch (Exception e) {
			
			e.printStackTrace();
			return "fail";
			
		}
	}

	// 수정 처리
	@PostMapping("/certiEdit")
	@ResponseBody
	public String certiEdit (@RequestParam("cerNum") String cerNum, @RequestParam("claNum") String claNum, 
                             @RequestParam("uploadFile") MultipartFile uploadFile) throws Exception {
		
		try {
			// 서비스에 보내기
			certificateService.updateCertifiCate(cerNum, claNum, uploadFile);
			
			return "success";
			
		} catch (Exception e) {
			
			e.printStackTrace();
			return "fail";
			
		}
	}
	
}
