package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.MessageAttachVO;

public interface MessageAttachDAO {

	String selectMsgAttachSeqNext() throws SQLException;

	void insertMsgAttach(MessageAttachVO attach) throws SQLException;

	List<MessageAttachVO> selectMsgAttachList(String msNum) throws SQLException;

	void deleteMsgAttach(String maNum) throws SQLException;

	void deleteMsgAttachByParent(String msNum) throws SQLException;
}
