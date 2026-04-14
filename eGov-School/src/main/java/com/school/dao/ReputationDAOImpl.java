package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.ReputationVO;

public class ReputationDAOImpl implements ReputationDAO{
	
	private SqlSession session;
	
	public ReputationDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<ReputationVO> selectReputationList(String claNum) throws SQLException {
		
		return session.selectList("Reputation-Mapper.selectReputationList", claNum);
	}

	@Override
	public ReputationVO selectReputationCount(String claNum) throws SQLException {
		
		return session.selectOne("Reputation-Mapper.selectReputationCount",claNum);
	}

	@Override
	public void insertReputation(ReputationVO reputation) throws SQLException {
		session.insert("Reputation-Mapper.insertReputation", reputation);
		
	}

	@Override
	public void updateReputation(ReputationVO reputation) throws SQLException {
		session.update("Reputation-Mapper.updateReputation", reputation);
		
	}

	@Override
	public String selectReputaionSeqNext() throws SQLException {
		
		return session.selectOne("Reputation-Mapper.selectReputationSeqNext");
	}
	
	// 강사
	@Override
	public List<ReputationVO> selectReputationListByLecturer(PageMaker pageMaker, String userNum, RowBounds rows) throws SQLException {
		
		Map<String, Object> reputationList = new HashMap<>();
		reputationList.put("pageMaker", pageMaker);
		reputationList.put("userNum", userNum);
		
		return session.selectList("Reputation-Mapper.selectReputationListByLecturer", reputationList, rows);
		
	}

	@Override
	public ReputationVO selectReputationDetailByRepNum(String repNum) throws SQLException {

		return session.selectOne("Reputation-Mapper.selectReputationDetailByRepNum", repNum);
		
	}
	
	@Override
	public int selectUnreadReputationCount(String userNum) throws SQLException {

		return session.selectOne("Reputation-Mapper.selectUnreadReputationCount", userNum);
		
	}

	@Override
	public void updateReputationCheck(String repNum) throws SQLException {

		session.update("Reputation-Mapper.updateReputationCheck", repNum);
		
	}

	@Override
	public int selectReputationCountByLecturer(PageMaker pageMaker, String userNum) throws SQLException {
		
		Map <String, Object> reputationCount = new HashMap<> ();
		reputationCount.put("pageMaker", pageMaker);
		reputationCount.put("userNum", userNum);
		
		return session.selectOne("Reputation-Mapper.selectReputationCountByLecturer", reputationCount);
		
	}

	@Override
	public List<ReputationVO> selectReputationListForAdmin(ReputationVO searchVO) throws SQLException {
		
		return session.selectList("Reputation-Mapper.selectReputationListForAdmin",searchVO);
	}
	
	@Override
	public List<ReputationVO> selectLClassRep(String userNum) throws SQLException {

		return session.selectList("Reputation-Mapper.selectLClassRep", userNum);
		
	}
	

}
