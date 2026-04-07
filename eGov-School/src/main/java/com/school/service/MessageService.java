package com.school.service;

import java.sql.SQLException;

import org.springframework.web.multipart.MultipartFile;

import com.school.dto.MessageVO;

public interface MessageService {
	
	// 메시지 insert 시 megNum 가져오기
	String selectMessageSeqNext() throws SQLException;
	
	// 메시지 insert
	void insertMessage(MessageVO message) throws SQLException;
	
	MessageVO selectMessageByNum(String msNum) throws SQLException;
	
	void  updateMessageCheck(String msNum) throws SQLException;
	
	void deleteMessage(String msNum) throws SQLException;
	
	String selectPassStudentByUserNum(String userNum, String claNum) throws SQLException;

	void insertMessageFile(MessageVO message, MultipartFile uploadFile) throws Exception;
	
}
