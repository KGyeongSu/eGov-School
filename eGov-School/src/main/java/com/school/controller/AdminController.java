package com.school.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.school.dto.BonusStudentVO;
import com.school.dto.BonusSubjectVO;
import com.school.dto.ClassVO;
import com.school.dto.RegInlearningVO;
import com.school.dto.UserVO;
import com.school.service.AdminService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/admin")
@Log4j2
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
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
		List<ClassVO> classList = adminService.getClassList();
		model.addAttribute("classList", classList);
	}

	@GetMapping("/curriculum")
	public void getCurriculum() {
		
	}
} 
