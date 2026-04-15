package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.BonusCriteriaVO;
import com.school.dto.BonusSubjectVO;

public class BonusCriteriaDAOImpl implements BonusCriteriaDAO{

	private SqlSession session;
	
	public BonusCriteriaDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectBonusCriteriaSeqNext() throws SQLException {
		return session.selectOne("BonusCriteria-Mapper.selectBonusCriteriaSeqNext");
	}

	@Override
	public void insertBonusCriteria(BonusCriteriaVO bonus) throws SQLException {
		session.insert("BonusCriteria-Mapper.insertBonusCriteria", bonus);
	}

	@Override
	public List<BonusCriteriaVO> selectBonusCriteriaList() throws SQLException {
		return session.selectList("BonusCriteria-Mapper.selectBonusCriteriaList");
	}

	@Override
	public BonusCriteriaVO selectBonusCriteriaByNum(String bcNum) throws SQLException {
		return session.selectOne("BonusCriteria-Mapper.selectBonusCriteriaByNum", bcNum);
	}

	@Override
	public void updateBonusCriteria(BonusCriteriaVO bonus) throws SQLException {
		session.update("BonusCriteria-Mapper.updateBonusCriteria", bonus);
	}

	@Override
	public void deleteBonusCriteria(String bcNum) throws SQLException {
		session.delete("BonusCriteria-Mapper.deleteBonusCriteria", bcNum);
	}

	@Override
	public int selectBonusScoreByUser(String userNum) throws SQLException {
		return session.selectOne("BonusCriteria-Mapper.selectBonusScoreByUser", userNum);
	}
	
	@Override
	public List<BonusSubjectVO> getBSbList(int offset, int limit) throws SQLException {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);
        return session.selectList("BonusCriteria-Mapper.getBSbList", paramMap);
	}

	@Override
	public int selectCount() throws SQLException {
		return session.selectOne("BonusCriteria-Mapper.selectCount");
	}
	
}
