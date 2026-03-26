package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.ExamNoticeAttachVO;

public interface ExamNoticeAttachDAO {

	String selectENAttachSeqNext() throws SQLException;

	void insertENAttach(ExamNoticeAttachVO attach) throws SQLException;

	List<ExamNoticeAttachVO> selectENAttachList(String enNum) throws SQLException;

	void deleteENAttach(String enaNum) throws SQLException;

	void deleteENAttachByParent(String enNum) throws SQLException;
}

