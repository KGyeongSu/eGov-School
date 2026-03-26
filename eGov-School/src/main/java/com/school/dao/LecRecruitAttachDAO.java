package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.LecRecruitAttachVO;


public interface LecRecruitAttachDAO {

	String selectLRAttachSeqNext() throws SQLException;

	void insertLRAttach(LecRecruitAttachVO attach) throws SQLException;

	List<LecRecruitAttachVO> selectLRAttachList(String ltNum) throws SQLException;

	void deleteLRAttach(String lraNum) throws SQLException;

	void deleteLRAttachByParent(String ltNum) throws SQLException;
}
