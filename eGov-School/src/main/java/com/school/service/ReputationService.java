package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.ReputationVO;

public interface ReputationService {
	
	// 강사
	List <ReputationVO> selectReputationListByLecturer (PageMaker pageMaker, String userNum) throws SQLException;
	
	ReputationVO selectReputationDetailByRepNum (String repNum) throws SQLException;
	
	int selectReputationCountByLecturer (PageMaker pagemaker, String userNum) throws SQLException;
}
