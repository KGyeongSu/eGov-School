package com.school.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;

import com.school.dao.LessonAttachDAO;
import com.school.dao.LessonDAO;
import com.school.dto.LessonAttachVO;
import com.school.dto.LessonVO;

public class LessonServiceImpl implements LessonService {
	
	private final LessonDAO lessonDAO;
	private final LessonAttachDAO lessonAttachDAO;
	
	public LessonServiceImpl (LessonDAO lessonDAO, LessonAttachDAO lessonAttachDAO) {
		
		this.lessonDAO = lessonDAO;
		this.lessonAttachDAO = lessonAttachDAO;
		
	}
	
	@Override
	@Transactional 
	public void insertLessonAndAttach(LessonVO lesson, List<LessonAttachVO> attachList) throws Exception {
		
	    try {
	    	
	        if (attachList == null || attachList.isEmpty()) {
	        	
	            throw new Exception("강의 등록 시 동영상 파일은 필수입니다.");
	            
	        }

	        // 3. 레슨 번호(PK) 및 정렬 순서(SEQ) 세팅
	        String lsnNum = lessonDAO.selectLessonSeqNext();
	        lesson.setLsnNum(lsnNum);

	        // 해당 강의실의 마지막 순번을 가져와 +1 해줌
	        int maxSeq = lessonDAO.selectMaxLsnSeq(lesson.getClaNum());
	        lesson.setLsnSeq(maxSeq + 1);

	        // 강의 저장
	        lessonDAO.insertLesson(lesson);

	        // 첨부파일 리스트 저장
	        for (LessonAttachVO attach : attachList) {

	        	String laNum = lessonAttachDAO.selectLessonAttachSeqNext();
	            attach.setLaNum(laNum);

	            attach.setLsnNum(lsnNum);

	            // 첨부파일 DB 저장
	            lessonAttachDAO.insertLessonAttach(attach);
	        }

	    } catch (Exception e) {

	    	System.err.println("CRITICAL ERROR in insertLessonAndAttach: " + e.getMessage());
	        e.printStackTrace();
	        throw e; 
	        
	    }
	}

	@Override
	public List<LessonVO> selectLessonList(String claNum) throws Exception {
		
		return lessonDAO.selectLessonList(claNum);
		
	}

	@Override
	public LessonVO selectLessonByLsnNum(String lsnNum) throws Exception {
		
		// 강의 기본 정보 가져오기
		LessonVO lesson = lessonDAO.selectLessonByLsnNum(lsnNum);
		
		// 첨부파일도 같이 가져오기
		if (lesson != null) {
			
			List <LessonAttachVO> attachList = lessonAttachDAO.selectLessonAttachList(lsnNum);
			lesson.setLessonAttachList(attachList);
			
		}

		return lesson;
		
	}

	@Value("${savedPath.lesson.file}")
	private String lessonFilePath;
	
	@Override
	@Transactional
	public void updateLesson(LessonVO lesson, List<LessonAttachVO> attachList, String deleteFiles) throws Exception {
		
		lessonDAO.updateLesson(lesson);
		
		// 사용자가 'X'를 눌러 삭제 요청한 파일들 처리 (물리적 삭제)
	    if (deleteFiles != null && !deleteFiles.trim().isEmpty()) {
	    	
	        String[] saveNames = deleteFiles.split(",");
	        
	        for (String saveName : saveNames) {
	        	
	            // 진짜로 파일 삭제
	            File file = new File(lessonFilePath, saveName);
	            
	            if (file.exists()) {
	            	
	                file.delete();
	                System.out.println("파일 삭제 성공: " + saveName);
	                
	            }
	            
	            lessonAttachDAO.deleteLessonAttachBySaveName(saveName); 
	            
	        }
	    }
		
		// 새로 첨부된 파일이 있는경우에만
		if (attachList != null && !attachList.isEmpty()) {
			
			for (LessonAttachVO attach : attachList) {
				
				// 새 첨부파일 번호 생성
				String laNum = lessonAttachDAO.selectLessonAttachSeqNext();
				attach.setLaNum(laNum);
				
				// 현재 수정중인 lessonNum 외래키 설정
				attach.setLsnNum(lesson.getLsnNum());
				
				//DB 저장
				lessonAttachDAO.insertLessonAttach(attach);
				
			}
			
		}
		
	}

}
