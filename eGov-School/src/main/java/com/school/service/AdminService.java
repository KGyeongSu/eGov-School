package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.BonusCriteriaVO;
import com.school.dto.BonusStudentVO;
import com.school.dto.BonusSubjectVO;
import com.school.dto.ClassVO;
import com.school.dto.LessonVO;
import com.school.dto.RegInlearningVO;

public interface AdminService {
	public int regInlearning(RegInlearningVO regInlearningVO) throws SQLException;
	
	public List<BonusSubjectVO> getBSbList(PageMaker pageMaker) throws SQLException;
	public List<BonusStudentVO> getBStList(PageMaker pageMaker) throws SQLException;
}
