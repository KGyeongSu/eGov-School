package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.school.cmd.PageMaker;
import com.school.dao.ReputationDAO;
import com.school.dto.ReputationVO;

public class ReputationServiceImpl implements ReputationService {
	
	private final ReputationDAO reputationDAO;

	public ReputationServiceImpl(ReputationDAO reputationDAO) {

		this.reputationDAO = reputationDAO;
		
	}

	@Override
	public List<ReputationVO> selectReputationListByLecturer(PageMaker pageMaker, String userNum) throws SQLException {
		
		//8개씩 보여주기
		pageMaker.setPerPageNum(8);
		int limit = pageMaker.getPerPageNum();
		
		// 전체 개수 가져오기
		int totalCount = reputationDAO.selectReputationCountByLecturer(pageMaker, userNum);
		pageMaker.setTotalCount(totalCount);
		
		int offset = pageMaker.getStartRow() -1;
		
		RowBounds rows = new RowBounds(offset, limit);
		
		return reputationDAO.selectReputationListByLecturer(pageMaker, userNum, rows);
		
	}

	@Override
	public ReputationVO selectReputationDetailByRepNum(String repNum) throws SQLException {

		return reputationDAO.selectReputationDetailByRepNum(repNum);
		
	}
	
	@Override
	public void updateReputationCheck(String repNum) throws SQLException {
		
		reputationDAO.updateReputationCheck(repNum);
		
	}

	@Override
	public int selectUnreadReputationCount(String userNum) throws SQLException {

		return reputationDAO.selectUnreadReputationCount(userNum);
		
	}
	

	@Override
	public int selectReputationCountByLecturer(PageMaker pageMaker, String userNum) throws SQLException {

		return reputationDAO.selectReputationCountByLecturer(pageMaker, userNum);
		
	}

}
