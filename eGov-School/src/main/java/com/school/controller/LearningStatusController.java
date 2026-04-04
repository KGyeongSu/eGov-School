package com.school.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.school.dto.LearningStatusVO;
import com.school.dto.UserVO;
import com.school.service.LearningStatusService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/learning")
public class LearningStatusController {

    @Autowired
    private LearningStatusService learningStatusService;

    @PostMapping("/updateProgress")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateProgress(@RequestBody LearningStatusVO status, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        
        try {
            status.setUserNum(loginUser.getUserNum());
            
            learningStatusService.updateLearningStatus(status);
            
            response.put("result", "success");
            
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/getPastStatus")
    @ResponseBody
    public ResponseEntity<LearningStatusVO> getPastStatus(@RequestBody LearningStatusVO status, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

        try {
            status.setUserNum(loginUser.getUserNum());
            LearningStatusVO pastStatus = learningStatusService.getLearningStatus(status);
            
            return new ResponseEntity<>(pastStatus, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}