package com.school.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;
import com.school.dto.LessonVO;
import com.school.dto.UserVO;
import com.school.service.ClassApplyService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class ClassApplyController {
    
    @Autowired
    private ClassApplyService classApplyService;

    @RequestMapping("/dashBoard")
    public String dashBoard(PageMaker pageMaker, HttpSession session, Model model) throws SQLException {
        
       
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) return "redirect:/commons/login";
        
  
        String userNum = String.valueOf(loginUser.getUserNum());
        
        ClassApplyListCommand result = classApplyService.getClassApplyList(userNum, pageMaker);
     // 2. 대시보드에는 종료 강좌를 안 보여줄 거니까 빈 리스트를 넣어줌 (에러 방지용)
        result.setEndList(new ArrayList<ClassApplyVO>());
        model.addAttribute("result", result);
        
        return "user/dashBoard";
    }

    @RequestMapping("/myKang")
    public String list(PageMaker pageMaker, HttpSession session, Model model) throws SQLException {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/commons/login";
        
        String userNum = String.valueOf(loginUser.getUserNum());
        
        ClassApplyListCommand result = classApplyService.getClassApplyList(userNum, pageMaker); //수강중인거 가져오기
        List<ClassApplyVO> endList = classApplyService.getCompletedClassList(userNum); //종료된 목록 가져오기
        result.setEndList(endList); 
        
        model.addAttribute("result", result);
        model.addAttribute("pageMaker", result.getPageMaker());
        return "user/myKang";
    }

    @RequestMapping("/videolect")
    public String videolect(
            @RequestParam("claNum") String claNum, 
            @RequestParam(value="lsnSeq", required = false) String lsnSeq, 
            HttpSession session, Model model) throws SQLException {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/commons/login";
        String userNum = String.valueOf(loginUser.getUserNum());
        
        // 서비스에도 lsnSeq를 그대로 넘깁니다.
        LessonVO lesson = classApplyService.getLessonDetail(userNum, claNum, lsnSeq);
        List<LessonVO> lessonList = classApplyService.getLessonListByCoures(claNum);
        
        model.addAttribute("lesson", lesson);
        model.addAttribute("lessonList",lessonList);
        model.addAttribute("claNum", claNum);
        
        return "user/videolect";
    }
    
    
    @RequestMapping(value = "/getLessonList", method = RequestMethod.GET)
    @ResponseBody
    public List<LessonVO> getLessonList(@RequestParam("claNum") String claNum) throws SQLException {
        return classApplyService.getLessonListByCoures(claNum);
    }
    
    
    
    @RequestMapping("/updateProgress")
    @ResponseBody 
    public String updateProgress(
            @RequestParam("claNum") String claNum, 
            @RequestParam("lsnSeq") int lsnSeq,
            HttpSession session) {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "fail";
        String userNum = String.valueOf(loginUser.getUserNum());

        try {
            classApplyService.updateLessonProgress(userNum, claNum, lsnSeq);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
}