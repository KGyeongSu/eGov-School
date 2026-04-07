package com.school.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.school.dao.MessageAttachDAO;
import com.school.dao.MessageDAO;
import com.school.dto.MessageAttachVO;
import com.school.dto.MessageVO;

public class MessageServiceImpl implements MessageService {
	
	private final MessageDAO messageDAO;
	private final MessageAttachDAO mattachDAO;

	public MessageServiceImpl(MessageDAO messageDAO, MessageAttachDAO mattachDAO) {

		this.messageDAO = messageDAO;
		this.mattachDAO = mattachDAO;
		
	}

	@Override
	public String selectMessageSeqNext() throws SQLException {

		return messageDAO.selectMessageSeqNext();
		
	}

	@Override
	public void insertMessage(MessageVO message) throws SQLException {
		
		// 메시지 sequence 확인
		String msNum = messageDAO.selectMessageSeqNext();
		
		// megNum 넣어주기
		message.setMsNum(msNum);
		
		// DB에 저장
		messageDAO.insertMessage(message);
		
	}

	@Override
	public MessageVO selectMessageByNum(String msNum) throws SQLException {

		return messageDAO.selectMessageByNum(msNum);
		
	}

	@Override
	public void updateMessageCheck(String msNum) throws SQLException {

		messageDAO.updateMessageCheck(msNum);
		
	}

	@Override
	public void deleteMessage(String msNum) throws SQLException {

		messageDAO.deleteMessage(msNum);
		
	}

	@Override
	public String selectPassStudentByUserNum(String userNum, String claNum) throws SQLException {

		return messageDAO.selectPassStudentByUserNum(userNum, claNum);
		
	}
	
	@Value("${savedPath.message.file}")
	private String messageFilePath;
	
	@Override
	@Transactional
	public void insertMessageFile(MessageVO message, MultipartFile uploadFile) throws Exception {

		// 메시지 넘버 찾기
		String msNum = messageDAO.selectMessageSeqNext();
		
		// megNum 넣어주기
		message.setMsNum(msNum);
		
		if (message.getMsContent() == null || message.getMsContent().trim().isEmpty()) {
			
	        message.setMsContent("평가 결과 파일 제출"); 
	        
	    }
		
		messageDAO.insertMessage(message);

		// 파일
		if (uploadFile != null && !uploadFile.isEmpty()) {
            
            // 파일 정보
            String name = uploadFile.getOriginalFilename(); 
            String saveName = UUID.randomUUID().toString() + "_" + name;
            String savePath = messageFilePath; 
            
            // 실제 파일 저장
            File targetDir = new File(savePath);
            
            if (!targetDir.exists()) {
            	
                targetDir.mkdirs(); // 폴더가 없으면 생성
                
            }
            
            // 서버 폴더로 파일 이동/저장
            File saveFile = new File(savePath, saveName);
            uploadFile.transferTo(saveFile);
            
            // msNum 가져오기
            String maNum = mattachDAO.selectMsgAttachSeqNext();

            // DB 파일 정보 저장
            MessageAttachVO attach = new MessageAttachVO();
            attach.setMaNum(maNum); 
            attach.setMsNum(msNum);                 
            attach.setMaName(name);     
            attach.setMaSaveName(saveName);         
            attach.setMaSavePath(savePath);         
            attach.setMaType(uploadFile.getContentType());
            attach.setMaSize(uploadFile.getSize());
            
            mattachDAO.insertMsgAttach(attach);
        }
		
	}
		
}