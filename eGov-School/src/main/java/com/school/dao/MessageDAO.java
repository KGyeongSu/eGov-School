package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.MessageVO;

public interface MessageDAO {

	String selectMessageSeqNext() throws SQLException;

	void insertMessage(MessageVO message) throws SQLException;

	List<MessageVO> selectReceivedList(String userNum) throws SQLException;

	List<MessageVO> selectSentList(String userNum) throws SQLException;

	MessageVO selectMessageByNum(String msNum) throws SQLException;

	void updateMessageCheck(String msNum) throws SQLException;

	void deleteMessage(String msNum) throws SQLException;
}