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

	@Override
	public List<ReputationVO> selectReputationListForAdmin(ReputationVO searchVO) throws SQLException {
		
		return reputationDAO.selectReputationListForAdmin(searchVO);
	}
	
	@Override
	public List<ReputationVO> selectLClassRep(String userNum) throws SQLException {
		
		List<ReputationVO> reputationList = reputationDAO.selectLClassRep(userNum);

	    if (reputationList != null && !reputationList.isEmpty()) {
	        double totalSumScore = 0;
	        int totalStudentCount = 0;

	        // 강좌별 데이터를 돌며 전체 합계 계산
	        for (ReputationVO vo : reputationList) {
	            totalSumScore += vo.getAvgScore();
	            totalStudentCount += vo.getStudentCount();
	        }

	        // 전체 평균 계산 (소수점 첫째자리)
	        double totalAvg = Math.round((totalSumScore / reputationList.size()) * 10.0) / 10.0;

	        for (ReputationVO vo : reputationList) {
	        	
	        	vo.setTotalAvg(totalAvg);
	            vo.setSumScore(totalStudentCount);
	            
	        }
	        
	    }

	    return reputationList;
		
	}

	@Override
	public void insertReputation(ReputationVO reputation) throws SQLException {

		String repNum = reputationDAO.selectReputaionSeqNext();
		
		reputation.setRepNum(repNum);
		
		reputationDAO.insertReputation(reputation);
		
	}

}
