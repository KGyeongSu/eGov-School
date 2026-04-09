package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.ProgressVO;

public class ProgressDAOImpl implements ProgressDAO{
	
	private SqlSession session;
	public ProgressDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<ProgressVO> selectProgressList(String userNum, String claNum) throws SQLException {
		
		//파라메타가 2개이상일땐 맵으로 만들어줘서 넣어줘야함.
		Map<String,Object> dataMap = new HashMap<>();
		dataMap.put("userNum", userNum);
		dataMap.put("claNum", claNum);
		
		
		return session.selectList("Progress-Mapper.selectProgressList",dataMap);
	}

	@Override
	public ProgressVO selectProgressCount(String userNum, String claNum) throws SQLException {
		
		Map<String,Object>dataMap = new HashMap<>();
		dataMap.put("userNum", userNum);
		dataMap.put("claNum", claNum);
		
		return session.selectOne("Progress-Mapper.selectProgressCount",dataMap);
		
	}

	@Override
	public void insertProgress(ProgressVO progress) throws SQLException {
		
		session.insert("Progress-Mapper.insertProgress", progress);
		
	}

	@Override
	public void updateProgress(ProgressVO progress) throws SQLException {
		session.update("Progress-Mapper.updateProgress", progress);
		
	}

	@Override
	public int selectProgresseqNext() throws SQLException {
	
		return session.selectOne("Progress-Mapper.selectProgresseqNext");
	}
	
	

}
