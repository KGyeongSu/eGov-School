package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.school.dao.MessageDAO;
import com.school.dto.MessageVO;

@Service
public class MessageServiceImpl implements MessageService {

    private final MessageDAO messageDAO;

    // 생성자 주입
    public MessageServiceImpl(MessageDAO messageDAO) {
        this.messageDAO = messageDAO;
    }

    @Override
    public List<MessageVO> getReceivedList(String userNum) throws SQLException {
        // 받은 쪽지 목록 불러오기
        return messageDAO.selectReceivedList(userNum);
    }

    @Override
    @Transactional // 중요: 읽음 표시와 상세 조회를 하나의 트랜잭션으로 처리
    public MessageVO getMessageUserDetail(String msNum) throws SQLException {
        // 1. 읽음 상태 업데이트 (MS_CHECK = 'N' -> 'Y')
        messageDAO.updateMessageCheck(msNum);
        
        // 2. 업데이트된 쪽지 상세 내용 조회 및 반환
        return messageDAO.selectMessageByNum(msNum);
    }

    @Override
    public int getUnreadCount(String userNum) throws SQLException {
        // 안 읽은 쪽지 개수 반환
        return messageDAO.selectUnreadCount(userNum);
    }

    @Override
    public void removeMessage(String msNum) throws SQLException {
        // 쪽지 삭제
        messageDAO.deleteMessage(msNum);
    }
}