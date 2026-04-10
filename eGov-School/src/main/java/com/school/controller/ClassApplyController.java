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
            @RequestParam(value="lsnNum", required = false) String lsnNum, 
            HttpSession session, Model model) throws Exception {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/commons/login";
        String userNum = String.valueOf(loginUser.getUserNum());

        // 1. 해당 강좌의 전체 강의 목록 가져오기
        List<LessonVO> lessonList = classApplyService.getLessonListByCoures(claNum);
        
        // 2. lsnNum이 없을 때(학습 시작/이어하기 클릭 시) 처리 로직
        if (lsnNum == null || lsnNum.isEmpty() || lsnNum.equals("0")) {
            LearningStatusVO status = new LearningStatusVO();
            status.setUserNum(userNum);
            status.setClaNum(claNum);
            
            // DB에서 가장 마지막에 학습한 순서(Seq) 가져오기
            int lastSeq = learningStatusService.getLastLearningSeq(status);
            
            if (lastSeq == 0) {
                // 신규 수강생인 경우 첫 번째 강의로 설정
                if (lessonList != null && !lessonList.isEmpty()) {
                    lsnNum = lessonList.get(0).getLsnNum();
                }
            } else {
                // 이어보기 사용자: 마지막 Seq와 일치하는 lsnNum 찾기
                for (LessonVO vo : lessonList) {
                    if (vo.getLsnSeq() == lastSeq) {
                        lsnNum = vo.getLsnNum();
                        break;
                    }
                }
            }
        }

        // 3. 강의 상세 정보 및 비디오 정보 조회
        LessonVO lesson = classApplyService.getLessonDetail(userNum, claNum, lsnNum);
        
        if (lesson != null) {
            List<LessonAttachVO> fileList = lessonService.getLessonFileList(lesson.getLsnNum());
            lesson.setLessonFiles(fileList); 
            
            if (fileList != null && !fileList.isEmpty()) {
                for (LessonAttachVO attach : fileList) {
                    if (attach.getLaSaveName().toLowerCase().contains(".mp4")) { 
                        lesson.setLsnVideo(attach.getLaSaveName());
                        break; 
                    }
                }
            }
        }

        // 4. 모델 데이터 주입
        model.addAttribute("totalLsnCount", lessonList != null ? lessonList.size() : 0);
        model.addAttribute("lesson", lesson);
        model.addAttribute("lessonList", lessonList);
        model.addAttribute("claNum", claNum);
        if (lesson != null) {
            model.addAttribute("prevLsnNum", lesson.getPrevLsnNum());
            model.addAttribute("nextLsnNum", lesson.getNextLsnNum());
        }

        return "user/videolect";
    }

    @RequestMapping("/updateProgress")
    @ResponseBody 
    public String updateProgress(
            @RequestParam("claNum") String claNum, 
            @RequestParam("lsnNum") String lsnNum, 
            HttpSession session) {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "fail";
        String userNum = String.valueOf(loginUser.getUserNum());

        try {
            classApplyService.updateLessonProgress(userNum, claNum, lsnNum);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @RequestMapping("/common/download")
    public void download(@RequestParam("laNum") String laNum, HttpServletResponse response) throws Exception {
        LessonAttachVO fileInfo = lessonService.getLessonAttachByLaNum(laNum);
        if (fileInfo == null) return;

        File file = new File(EXTERNAL_PATH, fileInfo.getLaSaveName());
        if (file.exists()) {
            String fileName = URLEncoder.encode(fileInfo.getLaName(), "UTF-8").replaceAll("\\+", "%20");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
            FileCopyUtils.copy(new FileInputStream(file), response.getOutputStream());
        }
    }

    @RequestMapping(value = "/registFeedback", method = RequestMethod.POST)
    @ResponseBody
    public String registFeedback(ReputationVO reputation, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "fail";
        try {
            reputation.setUserNum(String.valueOf(loginUser.getUserNum()));
            classApplyService.registReputation(reputation);
            return "success";
        } catch (Exception e) {
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