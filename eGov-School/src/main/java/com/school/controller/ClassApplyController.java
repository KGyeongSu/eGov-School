package com.school.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;
import com.school.dto.LearningStatusVO;
import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;
import com.school.dto.ReputationVO;
import com.school.dto.UserVO;
import com.school.service.ClassApplyService;
import com.school.service.LearningStatusService;
import com.school.service.LessonService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class ClassApplyController {

    @Autowired
    private ServletContext servletContext;
    
    @Autowired
    private ClassApplyService classApplyService;
    
    @Autowired
    private LearningStatusService learningStatusService;
    
    @Autowired
    private LessonService lessonService;

    private final String EXTERNAL_PATH = "C:/lesson/file/upload/";

    @RequestMapping("/dashBoard")
    public String dashBoard(PageMaker pageMaker, HttpSession session, Model model) throws SQLException {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/commons/login";
        
        String userNum = String.valueOf(loginUser.getUserNum());
        ClassApplyListCommand result = classApplyService.getClassApplyList(userNum, pageMaker);
        List<ClassApplyVO> endList = classApplyService.getCompletedClassList(userNum);
        
        result.setEndList(endList); 
        model.addAttribute("result", result);
        
        return "user/dashBoard";
    }

    @RequestMapping("/myKang")
    public String list(PageMaker pageMaker, HttpSession session, Model model) throws SQLException {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/commons/login";
        
        String userNum = String.valueOf(loginUser.getUserNum());
        pageMaker.setPerPageNum(6);
        
        ClassApplyListCommand result = classApplyService.getClassApplyList(userNum, pageMaker);
        List<ClassApplyVO> endList = classApplyService.getCompletedClassList(userNum);
        result.setEndList(endList); 
        
        model.addAttribute("result", result);
        model.addAttribute("pageMaker", result.getPageMaker());
        return "user/myKang";
    }

    @RequestMapping("/videolect")
    public String videolect(
            @RequestParam("claNum") String claNum, 
            @RequestParam(value="lsnSeq", required = false) String lsnSeq, 
            HttpSession session, Model model) throws Exception {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/commons/login";
        String userNum = String.valueOf(loginUser.getUserNum());

        if (lsnSeq == null || lsnSeq.isEmpty()) {
            LearningStatusVO status = new LearningStatusVO();
            status.setUserNum(userNum);
            status.setClaNum(claNum);
            int lastSeq = learningStatusService.getLastLearningSeq(status);
            lsnSeq = String.valueOf(lastSeq);
        }
        
        LessonVO lesson = classApplyService.getLessonDetail(userNum, claNum, lsnSeq);
        
        if (lesson != null) {
            List<LessonAttachVO> fileList = lessonService.getLessonFileList(lesson.getLsnNum());
            lesson.setLessonFiles(fileList); 
            
            if (fileList != null && !fileList.isEmpty()) {
                for (LessonAttachVO attach : fileList) {
                    String saveName = attach.getLaSaveName().toLowerCase();
                    if (saveName.contains(".mp4")) { 
                        lesson.setLsnVideo(attach.getLaSaveName());
                        break; 
                    }
                }
            }
        }

        List<LessonVO> lessonList = classApplyService.getLessonListByCoures(claNum);
        model.addAttribute("totalLsnCount", lessonList.size());
        model.addAttribute("lesson", lesson);
        model.addAttribute("lessonList", lessonList);
        model.addAttribute("claNum", claNum);

        return "user/videolect";
    }
    
    @RequestMapping("/common/download")
    public void download(@RequestParam("laNum") String laNum, HttpServletResponse response) throws Exception {
        LessonAttachVO fileInfo = lessonService.getLessonAttachByLaNum(laNum);
        
        if (fileInfo == null) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('파일 정보가 없습니다.'); history.back();</script>");
            return;
        }

        File file = new File(EXTERNAL_PATH, fileInfo.getLaSaveName());
        
        if (!file.exists()) {
            file = new File(fileInfo.getLaPath(), fileInfo.getLaSaveName());
        }
        if (!file.exists()) {
            String fallbackPath = servletContext.getRealPath("/resources/upload/lesson");
            file = new File(fallbackPath, fileInfo.getLaSaveName());
        }

        if (file.exists()) {
            String fileName = URLEncoder.encode(fileInfo.getLaName(), "UTF-8").replaceAll("\\+", "%20");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
            response.setContentLength((int) file.length());

            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = response.getOutputStream()) {
                FileCopyUtils.copy(fis, os);
                os.flush();
            }
        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('파일을 찾을 수 없습니다.'); history.back();</script>");
        }
    }

    /**
     * 피드백 등록 (JSP 모달에서 넘어온 별점 점수를 포함하여 저장)
     */
    @RequestMapping(value = "/registFeedback", method = RequestMethod.POST)
    @ResponseBody
    public String registFeedback(ReputationVO reputation, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "fail";

        try {
          
            reputation.setUserNum(String.valueOf(loginUser.getUserNum()));
            
            /* * 
           
             * 이제 JSP의 Ajax를 통해 전달된 repSat 값이 자동으로 커맨드 객체(reputation)에 매핑됩니다.
             */
            
            classApplyService.registReputation(reputation);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
    @RequestMapping("/certPrint")
    public String certPrint(@RequestParam("claNum") String claNum, Model model) {
        model.addAttribute("claNum", claNum);
        return "user/certPrint";
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
    @RequestMapping(value = "/classApply", method = RequestMethod.POST)
    @ResponseBody
    public String classApply(@RequestParam("claNum") String claNum, HttpSession session) {
        
        // 1. 로그인 체크
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "login";
        }
        
        // 2. 사용자 권한 체크 (사용자만 가능)
        if (!"사용자".equals(loginUser.getUserRole())) {
            return "denied";
        }
        
        String userNum = String.valueOf(loginUser.getUserNum());
        
        try {
            // 3. 중복 신청 체크
            int count = classApplyService.checkDuplicate(userNum, claNum);
            if (count > 0) {
                return "already";
            }
            
            // 4. 모집인원 마감 체크
            int full = classApplyService.checkFull(claNum);
            if (full <= 0) {
                return "full";
            }
            
            // 5. 수강신청 INSERT
            ClassApplyVO apply = new ClassApplyVO();
            apply.setUserNum(userNum);
            apply.setClaNum(claNum);
            classApplyService.registClassApply(apply);
            
            return "success";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    
}