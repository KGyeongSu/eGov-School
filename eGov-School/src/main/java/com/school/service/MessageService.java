package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.school.dto.MessageVO;

public interface MessageService {
    // 받은 쪽지함 목록 보기
    List<MessageVO> getReceivedList(String userNum) throws SQLException;
    
    // 쪽지 상세 보기 (조회 + 읽음 처리 한꺼번에)
    MessageVO getMessageUserDetail(String msNum) throws SQLException;
    
    // 안 읽은 쪽지 개수 (알림 표시용)
    int getUnreadCount(String userNum) throws SQLException;
    
    // 쪽지 삭제
    void removeMessage(String msNum) throws SQLException;
    
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
