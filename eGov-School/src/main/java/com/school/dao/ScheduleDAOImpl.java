package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.ScheduleVO;

public class ScheduleDAOImpl implements ScheduleDAO {
	
	private SqlSession session;
	
	public ScheduleDAOImpl(SqlSession session) {
		this.session = session ;
	}

	
	@Override
	public String selectScheduleSeqNext() throws SQLException {
		return session.selectOne("Schedule-Mapper.selectScheduleSeqNext");
	}

	@Override
	public void insertSchedule(ScheduleVO schedule) throws SQLException {
		session.insert("Schedule-Mapper.insertSchedule", schedule);
	}

	@Override
	public List<ScheduleVO> selectScheduleList(String userNum) throws SQLException {
		return session.selectList("Schedule-Mapper.selectScheduleList", userNum);
	}

	@Override
	public ScheduleVO selectScheduleByNum(String schNum) throws SQLException {
		return session.selectOne("Schedule-Mapper.selectScheduleByNum", schNum);
	}

	@Override
	public void updateSchedule(ScheduleVO schedule) throws SQLException {
		session.update("Schedule-Mapper.updateSchedule", schedule);
	}

	@Override
	public void deleteSchedule(String schNum) throws SQLException {
		session.delete("Schedule-Mapper.deleteSchedule", schNum);
	}
		
	
}
