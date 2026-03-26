package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.JobNoticeAttachVO;


public interface JobNoticeAttachDAO {

	String selectJNAttachSeqNext() throws SQLException;

	void insertJNAttach(JobNoticeAttachVO attach) throws SQLException;

	List<JobNoticeAttachVO> selectJNAttachList(String jnNum) throws SQLException;

	void deleteJNAttach(String jnaNum) throws SQLException;

	void deleteJNAttachByParent(String jnNum) throws SQLException;
}
