package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.school.cmd.PageMaker;
import com.school.dto.ReputationVO;

public interface ReputationDAO {
	
	
	List<ReputationVO>selectReputationList(String claNum)throws SQLException;
	
	ReputationVO selectReputationCount(String claNum)throws SQLException;
	
	void insertReputation(ReputationVO reputation)throws SQLException;
	
	void updateReputation(ReputationVO reputation)throws SQLException;
	
	int selectReputaioneqNext()throws SQLException;
	
	// 강사
	List <ReputationVO> selectReputationListByLecturer (PageMaker pageMaker, String userNum, RowBounds rows) throws SQLException;
	
	ReputationVO selectReputationDetailByRepNum (String repNum) throws SQLException;
	
	// 강사 메시지 알림 전용
	int selectUnreadReputationCount (String userNum) throws SQLException;
	
	void updateReputationCheck (String repNum) throws SQLException;
	
	//페이지네이션 시
	int selectReputationCountByLecturer (PageMaker pageMaker, String userNum) throws SQLException;

}
