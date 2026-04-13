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
import com.school.service.BonusCriteriaService;
import com.school.service.ClassService;
import com.school.service.LessonService;


@Controller
@RequestMapping("/admin")
public class AdminController {

    private final ClassService classService;
    private final LessonService lessonService;
    private final BonusCriteriaService bonusCriteriaService;

    public AdminController(ClassService classService, 
    					   LessonService lessonService, 
    					   BonusCriteriaService bonusCriteriaService) {
        this.classService = classService;
        this.lessonService = lessonService;
        this.bonusCriteriaService = bonusCriteriaService;
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