
package com.school.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;
import com.school.dto.TestVO;
import com.school.dto.UserVO;
import com.school.service.ClassService;
import com.school.service.TestService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/lecterer")
public class TestLectererController {
	
	private final ClassService classService;
	private final TestService testService;
	
	public TestLectererController(ClassService classService, TestService testService) {
		
		this.classService = classService;
		this.testService = testService;
		
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
	
//	@GetMapping("/testEdit")
//	public String testEdit (HttpSession session, @RequestParam("calNum") String calNum) {
//		
//		
//		
//	}

}
