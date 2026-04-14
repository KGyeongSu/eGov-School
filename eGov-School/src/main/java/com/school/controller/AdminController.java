package com.school.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.PageMaker;
import com.school.dto.BonusCriteriaVO;
import com.school.dto.ClassVO;
import com.school.dto.LessonVO;
import com.school.dto.ReputationVO;
import com.school.dto.UserVO;
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
    
    public AdminController(ClassService classService, 
    					   LessonService lessonService, 
    					   BonusCriteriaService bonusCriteriaService,
    					   ReputationService reputationService) {
        this.classService = classService;
        this.lessonService = lessonService;
        this.bonusCriteriaService = bonusCriteriaService;
        this.reputationService = reputationService;
    }
    
    // 육상우
    @RequestMapping("/feedback")
    public String feedback(HttpSession session, Model model, ReputationVO searchVO) throws Exception {
        // 1. 로그인 체크 (관리자 권한 확인 로직을 여기에 추가할 수 있습니다)
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            return "redirect:/commons/login"; // 로그인 안 되어 있으면 로그인 페이지로
        }

        // 2. 서비스 호출 (searchVO를 통해 검색어, 강사명, 별점 필터가 자동으로 전달됨)
        List<ReputationVO> reputationList = reputationService.selectReputationListForAdmin(searchVO);

        // 3. 결과 데이터를 Model에 담아 JSP로 전달
        model.addAttribute("reputationList", reputationList);
        model.addAttribute("searchVO", searchVO); // 검색 조건을 유지하기 위해 다시 보냄

        return "admin/feedback"; // 피드백 목록을 보여줄 JSP 경로
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

}