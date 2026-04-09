package com.school.controller;

import java.util.List;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.school.dto.UserVO;
import com.school.dto.TestVO;
import com.school.dto.ExamResultVO;
import com.school.service.TestService;

@Controller
@RequestMapping("/user") // 1순위 경로: /user
public class ExamController {

    @Autowired
    private TestService testService;

    /**
     * 평가(시험) 목록 조회 (예정된 평가 / 응시 완료 평가)
     * URL: localhost/user/exam
     */
    @RequestMapping(value = "/exam", method = RequestMethod.GET) 
    public String examList(HttpSession session, Model model) throws Exception {
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            return "redirect:/commons/login";
        }

        String userNum = loginUser.getUserNum();

        // 1. 응시 예정 목록과 응시 완료 목록을 각각 가져옴
        List<TestVO> pendingList = testService.getPendingTestList(userNum);
        List<TestVO> completedList = testService.getCompletedTestList(userNum);

        model.addAttribute("pendingTestList", pendingList);
        model.addAttribute("completedTestList", completedList);

        return "user/exam"; 
    }

    /**
     * 응시 완료된 시험의 결과 상세 조회
     * URL: localhost/user/examResult?erNum=결과번호
     */
    @RequestMapping(value = "/examResult", method = RequestMethod.GET)
    public String examResultDetail(@RequestParam("erNum") String erNum, 
                                   HttpSession session, 
                                   Model model) throws Exception {
        
        // 1. 로그인 확인
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/commons/login";
        }

        // 2. 해당 응시 기록의 상세 데이터(내 점수, 문제별 정답 여부 등) 조회
        ExamResultVO result = testService.getResultDetail(erNum);
        
        // 3. 해당 시험의 정보(강사가 설정한 수료 조건 claComplete 포함) 조회
        // result 객체 내부에 저장된 tetNum(시험번호)을 사용합니다.
        TestVO testCondition = testService.getTestCondition(result.getTetNum());

        // 4. 화면(JSP)으로 데이터 전달
        model.addAttribute("result", result);       // 내 점수 데이터
        model.addAttribute("test", testCondition);   // 합격 기준 데이터 (claComplete 포함)

        // 결과 확인 전용 JSP 페이지로 이동
        return "user/examResultDetail"; 
    }
}