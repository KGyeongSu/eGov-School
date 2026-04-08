package com.school.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;
import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;
import com.school.dto.UserVO;
import com.school.service.ClassService;
import com.school.service.LessonService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/lecterer")
public class ClassController {
	
	private final ClassService classService;
	private final LessonService lessonService;
	
	public ClassController(ClassService classService, LessonService lessonService) {

		this.classService = classService;
		this.lessonService = lessonService;
		
	}

	@GetMapping("/mainDashBoard")
	public String mainDashBoard (HttpSession session, Model model) throws Exception {
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null) return "redirect:/commons/login";
		
		String userNum = loginUser.getUserNum();
		
		// 대시보드에서 3개만 보여줌 (강의)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPage(1);
		pageMaker.setPerPageNum(3);
		
		// 출제 리스트
		PageMaker testList = new PageMaker();
	    testList.setPage(1);
	    testList.setPerPageNum(5);
		
		// 서비스 부르기
		List <ClassVO> classList = classService.selectClassList(pageMaker, userNum);
		List<ClassVO> testClassList = classService.selectTestClassList(testList, userNum);
		
		// 모델에 담아서 보여주기
		model.addAttribute("classList", classList);
		model.addAttribute("examList", testClassList);
		
		return "lecterer/mainDashBoard";
		
	}
	
	@GetMapping("/myRoom")
	public String myRoom (PageMaker pageMaker, HttpSession session, Model model) throws Exception {
		
		// 로그인 정보 확인
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		// 비로그인 시
		if (loginUser == null) return "redirect:/commons/login";
		
		String userNum = loginUser.getUserNum();
		
		List <ClassVO> classList = classService.selectClassList(pageMaker, userNum);
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("classList", classList);
		
		return "lecterer/myRoom";
		
	}
	
	@GetMapping("/roomDetail")
	public String roomDetail (@RequestParam("claNum") String claNum, Model model) throws Exception {
		
		// 해당 강의실 클릭 시
		ClassVO roomDetail = classService.selectClassByCla_num(claNum);
		
		// 해당 강의실 강좌
		List <LessonVO> lessonList = lessonService.selectLessonList(claNum);
		
		// model로 보여주기
		model.addAttribute("roomDetail", roomDetail);
		model.addAttribute("lessonList", lessonList);
		
		return "lecterer/roomDetail";
		
	}
	
	@Value("${savedPath.lesson.file}")
	private String lessonFilePath;
	
	@PostMapping ("/insertLesson")
	public String insertLesson (LessonVO lessonVO, @RequestParam(value="files") MultipartFile[] files, @RequestParam(value="deleteFiles", required=false) String deleteFiles,
								HttpSession session, RedirectAttributes rttr) {
		
		try {
			
			List <LessonAttachVO> attachList = new ArrayList<> ();
			
			// 실제 파일 저장 경로
			String uploadPath = lessonFilePath;
			File uploadDir = new File(uploadPath);
			
			if (!uploadDir.exists()) uploadDir.mkdirs();
			
			for (MultipartFile file : files) {
				
				if (file != null && !file.isEmpty()) {
					
					// 원본 파일명
					String name = file.getOriginalFilename();
					String saveName = UUID.randomUUID().toString() + "_" + name;
					
					// 파일 실제 저장
					File target = new File(uploadPath, saveName);
					file.transferTo(target);
					
					// lessonAttachVO 세팅
					LessonAttachVO attach = new LessonAttachVO ();
					attach.setLaName(name);
					attach.setLaSaveName(saveName);
					attach.setLaPath("/upload/lesson");
					attach.setLaType(file.getContentType());
					
					attachList.add(attach);
					
				}
				
			}
			
			// 서비스 호출
			if (lessonVO.getLsnNum() == null || lessonVO.getLsnNum().isEmpty()) {
				
				lessonService.insertLessonAndAttach(lessonVO, attachList);
				rttr.addFlashAttribute ("msg", "강의가 등록되었습니다.");
				
			} else {
				
				lessonService.updateLesson(lessonVO, attachList, deleteFiles); 
	            rttr.addFlashAttribute("msg", "강의가 수정되었습니다.");
				
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "서버 장애로 강의 등록이 실패했습니다." + e.getMessage());
			
		}
		
		return "redirect:/lecterer/roomDetail?claNum=" + lessonVO.getClaNum();
		
	}
	
	@GetMapping("/roomManage")
	public String roomManage (PageMaker pageMaker, @RequestParam("claNum") String claNum, Model model) throws Exception {
		
		// 강좌 정보 가져오기
	    ClassVO roomManage = classService.selectClassByCla_num(claNum);
	    
	    // 수강 중인 학생 목록 가져오기
	    List<UserVO> studentList = classService.selectStdentListByClaNum(pageMaker, claNum);
	    
	    model.addAttribute("roomDetail", roomManage);
	    model.addAttribute("studentList", studentList);
	    
	    return "lecterer/roomManage";
		
	}
	
	@GetMapping("/makeRoom")
	public String makeRoom (HttpSession session, Model model) throws Exception {
		
		// 로그인 정보 가져오기
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser == null) return "redirect:/commons/login";
		
		model.addAttribute("loginUser", loginUser);
		
		return "lecterer/makeRoom";
		 
	}
	
	@PostMapping("/makeRoom")
	public String insertClass (ClassVO classVO, HttpSession session, Model model) throws Exception {
		
		// 로그인한 강사 정보 가져오기
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		// 로그인 체크
		if (loginUser == null) return "redirect:/commons/login";
		
		// 강의실에 강사번호 넣기
		classVO.setUserNum(loginUser.getUserNum());
		
		// 강의실 & 레슨 타이틀 동시 저장
		try {
			
			classService.insertClass(classVO);
			model.addAttribute("msg", "강의실 생성이 완료되었습니다.");
	        model.addAttribute("status", "success");
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			model.addAttribute("msg", "서버 장애로 인해 강의실 생성에 실패했습니다. \\n 다시 시도해 주세요.");
			model.addAttribute("status", "fail");
			
		}
		
		return "lecterer/makeRoom";
		
	}

}
