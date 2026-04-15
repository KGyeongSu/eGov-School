package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.school.cmd.PageMaker;
import com.school.dao.BonusCriteriaDAO;
import com.school.dao.ClassDAO;
import com.school.dao.ExamResultDAO;
import com.school.dto.BonusCriteriaVO;
import com.school.dto.BonusStudentVO;
import com.school.dto.BonusSubjectVO;
import com.school.dto.ClassVO;
import com.school.dto.LessonVO;
import com.school.dto.RegInlearningVO;

@Service
public class AdminServiceImpl implements AdminService {

    private ClassDAO classDAO;
    private BonusCriteriaDAO bonusCriteriaDAO;
    private ExamResultDAO examResultDAO;
    
	public AdminServiceImpl(ClassDAO classDAO, BonusCriteriaDAO bonusCriteriaDAO, ExamResultDAO examResultDAO) {
		this.classDAO = classDAO;
		this.bonusCriteriaDAO = bonusCriteriaDAO;
		this.examResultDAO = examResultDAO;
	}
	
    @Override
    public int regInlearning(RegInlearningVO regInlearningVO) throws SQLException {
    	return classDAO.updateClassStaEndDate(regInlearningVO);
    }

    @Override
    public List<BonusSubjectVO> getBSbList(PageMaker pageMaker) throws SQLException {
    	pageMaker.setPerPageNum(10);
		pageMaker.setTotalCount(bonusCriteriaDAO.selectCount());
		int offset = pageMaker.getStartRow();
		int limit = pageMaker.getPage() * pageMaker.getPerPageNum();
    	return bonusCriteriaDAO.getBSbList(offset, limit);
    };
    
    @Override
    public List<BonusStudentVO> getBStList(PageMaker pageMaker) throws SQLException {
    	pageMaker.setPerPageNum(10);
		pageMaker.setTotalCount(examResultDAO.selectCount());
		int offset = pageMaker.getStartRow();
		int limit = pageMaker.getPage() * pageMaker.getPerPageNum();
    	return examResultDAO.getBStList(offset, limit);
	}
}