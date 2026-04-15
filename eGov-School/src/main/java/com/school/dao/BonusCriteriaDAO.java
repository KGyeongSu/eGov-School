package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.school.dto.BonusCriteriaVO;
import com.school.dto.BonusStudentVO;
import com.school.dto.BonusSubjectVO;

public interface BonusCriteriaDAO {

	String selectBonusCriteriaSeqNext() throws SQLException;
	
	int insertBonusCriteria(BonusCriteriaVO bonus) throws SQLException;
	
	List<BonusCriteriaVO> selectBonusCriteriaList() throws SQLException;
	
	BonusCriteriaVO selectBonusCriteriaByNum(String bcNum) throws SQLException;
	
	void updateBonusCriteria(BonusCriteriaVO bonus) throws SQLException;
	
	void deleteBonusCriteria(String bcNum) throws SQLException;
	
	int selectBonusScoreByUser(String userNum) throws SQLException;

	List<BonusSubjectVO> getBSbList(@Param("offset") int offset, @Param("limit") int limit) throws SQLException;
	
	int selectCount() throws SQLException;
}