package com.school.service;

import java.sql.SQLException;
import java.util.List;
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
}