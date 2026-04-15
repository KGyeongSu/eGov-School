package com.school.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.PageMaker;
import com.school.dto.BonusCriteriaVO;
import com.school.dto.BonusStudentVO;
import com.school.dto.BonusSubjectVO;
import com.school.dto.ClassVO;
import com.school.dto.LessonVO;
import com.school.dto.RegInlearningVO;
import com.school.dto.ReputationVO;
import com.school.dto.UserVO;
import com.school.service.AdminService;
import com.school.service.BonusCriteriaService;
import com.school.service.ClassService;
import com.school.service.LessonService;
import com.school.service.ReputationService;
import com.school.service.UserService;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/admin")
public class AdminController {

	
	private final ReputationService reputationService;
    private final ClassService classService;
    private final LessonService lessonService;
    private final BonusCriteriaService bonusCriteriaService;
    private final UserService userService;
    private final AdminService adminService;
    
    public AdminController(ClassService classService, 
    					   LessonService lessonService, 
    					   BonusCriteriaService bonusCriteriaService,
    					   ReputationService reputationService,
    					   UserService userService,
    					   AdminService adminService) {
        this.classService = classService;
        this.lessonService = lessonService;
        this.bonusCriteriaService = bonusCriteriaService;
        this.reputationService = reputationService;
        this.userService = userService;
        this.adminService = adminService;
    }
    
    @PostMapping("/regInlearning")
	@ResponseBody
    public ResponseEntity<Integer> regInlearing(@RequestBody RegInlearningVO regInlearningVO) throws SQLException {
        //log.info(regInlearningVO);
		int result = adminService.regInlearning(regInlearningVO);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

	@GetMapping("/main")
	public void showMain(@RequestParam("num") int num, PageMaker pageMaker, HttpSession session, Model model) throws SQLException {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		model.addAttribute("adminName", loginUser.getUserName());
		model.addAttribute("adminNum", loginUser.getUserNum());
		if (num == 0) {
			List<BonusSubjectVO> bonusSubjectVOList = adminService.getBSbList(pageMaker);
			model.addAttribute("bsbVOs", bonusSubjectVOList);
		}
		else if (num == 1) {
			List<BonusStudentVO> bonusStudentVOList = adminService.getBStList(pageMaker);
			model.addAttribute("bstVOs", bonusStudentVOList);	
		} 
		else {
			List<BonusSubjectVO> bonusSubjectVOList = adminService.getBSbList(pageMaker);
			model.addAttribute("bsbVOs", bonusSubjectVOList);
			List<BonusStudentVO> bonusStudentVOList = adminService.getBStList(pageMaker);
			model.addAttribute("bstVOs", bonusStudentVOList);		
		}
		model.addAttribute("pageMaker", pageMaker);
	}

	
    
    // 육상우
    @GetMapping("/feedback")
    public String feedback(HttpSession session, Model model, ReputationVO searchVO) throws Exception {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/commons/login";

        // 팀원1: 수강생 피드백 목록
        List<ReputationVO> reputationList = reputationService.selectReputationListForAdmin(searchVO);
        model.addAttribute("reputationList", reputationList);
        model.addAttribute("searchVO", searchVO);

        // 팀원2: 강사 피드백 - 강사 목록
        List<UserVO> lectererList = userService.getlectererList();
        model.addAttribute("lectererList", lectererList);

        model.addAttribute("loginUser", loginUser);
        return "admin/feedback";
    }

    // 강좌 커리큘럼 리스트
    @GetMapping("/curriculum")
    public String curriculum(PageMaker pageMaker, Model model) throws Exception {
        List<ClassVO> classList = classService.selectPendingClassList(pageMaker);
        model.addAttribute("classList", classList);
        model.addAttribute("pageMaker", pageMaker);
        return "admin/curriculum";
    }

    // 강좌 커리큘럼 상세
    @GetMapping("/curriculum_detail")
    public String curriculumDetail(@RequestParam("claNum") String claNum, Model model) throws Exception {
        ClassVO classVO = classService.selectClassByCla_num(claNum);
        List<LessonVO> lessonList = lessonService.selectLessonList(claNum);
        List<BonusCriteriaVO> bonusList = bonusCriteriaService.selectBonusCriteriaList();
        model.addAttribute("classVO", classVO);
        model.addAttribute("lessonList", lessonList);
        model.addAttribute("bonusList", bonusList);
        
        return "admin/curriculum_detail";
    }
    
    @GetMapping("/getLRep")
	@ResponseBody 
	public List<ReputationVO> getLRep(@RequestParam("userNum") String userNum) throws Exception {

		return reputationService.selectLClassRep(userNum);
	    
	}
	
	@PostMapping("/insertFeedback")
	@ResponseBody
	public String goRep (@RequestBody ReputationVO reputation) throws Exception {
		
		try {
	        
			reputationService.insertReputation(reputation);
	        return "success";
	        
	    } catch (Exception e) {
	       
	    	e.printStackTrace();
	        return "fail";
	        
	    }
		
	}
    
    // 김경수
    // 강좌 승인 처리
    @PostMapping("/approveClass")
    @ResponseBody
    public String approveClass(ClassVO classVO) {
        try {
            classService.approveClass(classVO);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    
    @GetMapping("/cv")
    public String cv(Model model) throws Exception {
        return "admin/cv";
    }
    
    @PostMapping("/regBonus")
	@ResponseBody
	public Map<String, Object> regBonus(@RequestBody BonusCriteriaVO bc) {
		Map<String, Object> result = new HashMap<>();
	    try {
	        // 서비스 로직 실행
	        adminService.regBonus(bc);
	        result.put("success", true);
	    } catch (Exception e) {
	        result.put("success", false);
	        result.put("message", "저장 중 오류가 발생했습니다.");
	    }
	    return result;
	}
}
