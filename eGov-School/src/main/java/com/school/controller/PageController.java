package com.school.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.PageMaker;
import com.school.dto.ClassVO;
import com.school.dto.ExamNoticeVO;
import com.school.dto.JobNoticeVO;
import com.school.service.ClassService;
import com.school.service.ExamNoticeService;
import com.school.service.JobNoticeService;

@Controller
@RequestMapping("/page")
public class PageController {

    private final ClassService classService;
    private final JobNoticeService jobNoticeService;
    private final ExamNoticeService examNoticeService;

    public PageController(ClassService classService, 
                          JobNoticeService jobNoticeService,
                          ExamNoticeService examNoticeService) {
        this.classService = classService;
        this.jobNoticeService = jobNoticeService;
        this.examNoticeService = examNoticeService;
    }

    // 기존 수강신청 페이지
    @GetMapping("/cregist")
    public String cregist(PageMaker pageMaker, Model model) throws Exception {
    	
    	pageMaker.setPerpageNum(10); // 페이지당 10개씩 보여주도록 설정
        List<ClassVO> classList = classService.selectApprovedClassList(pageMaker);

        int totalCount = classService.selectApprovedClassListCount(pageMaker);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("classList", classList);
        model.addAttribute("pageMaker", pageMaker);

        return "page/cregist";
    }

    // 공무원채용 페이지 (채용공고 + 시험공고 탭)
    @GetMapping("/notice")
    public String notice(@RequestParam(value = "tab", defaultValue = "job") String tab,
                         PageMaker pageMaker, Model model) throws Exception {

        if ("exam".equals(tab)) {
            List<ExamNoticeVO> examList;
            int totalCount;

            if (pageMaker.getKeyword() != null && !pageMaker.getKeyword().trim().isEmpty()) {
                examList = examNoticeService.selectSearchExamNoticeList(pageMaker);
                totalCount = examNoticeService.selectSearchExamNoticeListCount(pageMaker);
            } else {
                examList = examNoticeService.selectExamNoticeList(pageMaker);
                totalCount = examNoticeService.selectSearchExamNoticeListCount(pageMaker);
            }

            pageMaker.setTotalCount(totalCount);
            model.addAttribute("examList", examList);

        } else {
            List<JobNoticeVO> jobList;
            int totalCount;

            if (pageMaker.getKeyword() != null && !pageMaker.getKeyword().trim().isEmpty()) {
                jobList = jobNoticeService.selectSearchJobNoticeList(pageMaker);
                totalCount = jobNoticeService.selectSearchJobNoticeListCount(pageMaker);
            } else {
                jobList = jobNoticeService.selectJobNoticeList(pageMaker);
                totalCount = jobNoticeService.selectSearchJobNoticeListCount(pageMaker);
            }

            pageMaker.setTotalCount(totalCount);
            model.addAttribute("jobList", jobList);
        }

        model.addAttribute("tab", tab);
        model.addAttribute("pageMaker", pageMaker);

        return "page/notice";
    }
    
    @GetMapping("/jobDetail")
    @ResponseBody
    public JobNoticeVO jobDetail(@RequestParam("jnNum") String jnNum) throws Exception {
        return jobNoticeService.selectJobListByJn_num(jnNum);
    }

    @GetMapping("/examDetail")
    @ResponseBody
    public ExamNoticeVO examDetail(@RequestParam("enNum") String enNum) throws Exception {
        return examNoticeService.selectExamNoticeByEn_num(enNum);
    }
    

}