package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.ScheduleVO;

public interface ScheduleDAO {

	String selectScheduleSeqNext() throws SQLException;

	void insertSchedule(ScheduleVO schedule) throws SQLException;

	List<ScheduleVO> selectScheduleList(String userNum) throws SQLException;

	ScheduleVO selectScheduleByNum(String schNum) throws SQLException;

	void updateSchedule(ScheduleVO schedule) throws SQLException;

	void deleteSchedule(String schNum) throws SQLException;
}
