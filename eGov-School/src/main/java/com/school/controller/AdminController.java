package com.school.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.school.dto.ReputationVO;
import com.school.dto.UserVO;
import com.school.service.ReputationService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ReputationService reputationService;

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
}