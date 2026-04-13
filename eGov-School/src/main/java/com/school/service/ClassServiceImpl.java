package com.school.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.school.cmd.PageMaker;
import com.school.dao.ClassDAO;
import com.school.dao.LessonDAO;
import com.school.dto.ClassVO;
import com.school.dto.LessonVO;
import com.school.dto.UserVO;

@Service
public class ClassServiceImpl implements ClassService {

	private final ClassDAO classDAO;
	private final LessonDAO lessonDAO;

	

	public ClassServiceImpl(ClassDAO classDAO, LessonDAO lessonDAO) {
		
		this.classDAO = classDAO;
		this.lessonDAO = lessonDAO;
		
	}
   
	@Override
	public List<ClassVO> selectClassList(PageMaker pageMaker, String userNum) throws SQLException {
		
		// 먼저 6로 변경 (얘가 먼저 와야지 시작 행을 정할 수 있음)
		pageMaker.setPerPageNum(6); 
		int limit = pageMaker.getPerPageNum();
		
		// 전체 개수 가져오기(페이지 선택 숫자 칸 마련해야 함)
		int totalCount = classDAO.selectSearchClassListCount(pageMaker, userNum);
		pageMaker.setTotalCount(totalCount);
		
		
		int offset = pageMaker.getStartRow() -1;
		
		RowBounds rows = new RowBounds(offset, limit);
		
		return classDAO.selectClassList(pageMaker, userNum, rows);

	}
	
	@Value("${savedPath.class.photo}")
	private String classPhotoPath;
	
	
	@Override
	@Transactional
	public void insertClass(ClassVO classVO) throws SQLException {
		
		// 썸네일 등록
		MultipartFile file = classVO.getThumb();
		
		if (file != null && !file.isEmpty()) {
			
	        try {
	        	
	            // 저장 경로
	            String uploadPath = classPhotoPath;
	            
	            File dir = new File(uploadPath);
	            if (!dir.exists()) dir.mkdirs();
	            
	            // 2. 파일명 중복 방지 (UUID)
	            String name = file.getOriginalFilename();
	            String saveName = UUID.randomUUID().toString() + "_" + name;
	            
	            // 3. 물리적 저장
	            file.transferTo(new File(uploadPath, saveName));
	            
	            // 4. DB 저장
	            classVO.setClaThumb(name);
	            classVO.setClaSaveName(saveName);
	            classVO.setClaSavePath("/classDisplay");
	            
	        } catch (IOException e) {
	        	
	            e.printStackTrace();
	            throw new SQLException("파일 저장 중 오류가 발생했습니다.");
	            
	        }
	    }
		
		// 클래스 DB에 넣기
		classDAO.insertClass(classVO);
		
		// 클래스에서 가져온 num 넣어주기
		String claNum = classVO.getClaNum();
		
		// 레슨 타이틀 받아온거 리스트 처리
		List <LessonVO> lessonList = classVO.getLessonList();
		
		// 레슨 저장하기
		if (lessonList != null && !lessonList.isEmpty()) {
			
			// 강의 안 레슨 번호
			int lsnSeq = 1;
			
			for (LessonVO lesson : lessonList) {
				
				// lsnNum 확인하기
				String lsnNum = lessonDAO.selectLessonSeqNext();
				
				lesson.setClaNum(claNum);
				lesson.setLsnNum(lsnNum);
				lesson.setLsnSeq(lsnSeq++);
				
				// 레슨 개별 저장
				lessonDAO.insertLesson(lesson);
				
			}
			
		}

	}

	@Override
	public int selectSearchClassListCount(PageMaker pageMaker, String userNum) throws SQLException {

		return classDAO.selectSearchClassListCount(pageMaker, userNum);

	}

	@Override
	public String selectClassSeqNext() throws SQLException {

		return classDAO.selectClassSeqNext();

	}

	@Override
	public ClassVO selectClassByCla_num(String claNum) throws SQLException {

		return classDAO.selectClassByCla_num(claNum);

	}

	@Override
	public void increaseViewCnt(String claNum) throws SQLException {

		classDAO.increaseViewCnt(claNum);

	}

	@Override
	public List<UserVO> selectStdentListByClaNum(PageMaker pageMaker, String claNum) throws SQLException {
		
		// roomManage에서는 학생 7명씩, 평가 발송때는 모두
		if(pageMaker.getPerPageNum() == 999) {
			
	        int totalCount = classDAO.selectStudentListCount(pageMaker, claNum);
	        
	        pageMaker.setTotalCount(totalCount);
	        pageMaker.setPerPageNum(totalCount); 
	        
	    } else {
	    	
	        pageMaker.setPerPageNum(7); 
	        
	    }
		
		int limit = pageMaker.getPerPageNum();
		
		// 전체 개수 가져오기(페이지 선택 숫자 칸 마련해야 함)
		int totalCount = classDAO.selectStudentListCount(pageMaker, claNum);
		pageMaker.setTotalCount(totalCount);
		
		
		int offset = pageMaker.getStartRow() -1;
		
		RowBounds rows = new RowBounds(offset, limit);
				
		return classDAO.selectStudentListByClaNum(pageMaker, claNum, rows);
		
	}

	@Override
	public int selectStudentListCount(PageMaker pageMaker, String claNum) throws SQLException {
		
		return classDAO.selectStudentListCount(pageMaker, claNum);
	}

	@Override
	public List<ClassVO> selectTestClassList(PageMaker pageMaker, String userNum) throws SQLException {

		// 먼저 9로 변경 (얘가 먼저 와야지 시작 행을 정할 수 있음)
		pageMaker.setPerPageNum(9); 
		int limit = pageMaker.getPerPageNum();
		
		// 전체 개수 가져오기(페이지 선택 숫자 칸 마련해야 함)
		int totalCount = classDAO.selectSearchClassListCount(pageMaker, userNum);
		pageMaker.setTotalCount(totalCount);
		
		
		int offset = pageMaker.getStartRow() -1;
		
		RowBounds rows = new RowBounds(offset, limit);
		
		return classDAO.selectClassList(pageMaker, userNum, rows);
	}
		
	public List<ClassVO> selectApprovedClassList(PageMaker pageMaker) throws SQLException {
		return classDAO.selectApprovedClassList(pageMaker);
	}
  // 
	@Override
	public int selectApprovedClassListCount(PageMaker pageMaker) throws SQLException {
		return classDAO.selectApprovedClassListCount(pageMaker);
	}
	@Override
	public List<UserVO> selectUnsentStudentList(String claNum, String tetNum) throws SQLException {

		return classDAO.selectUnsentStudentList(claNum, tetNum);
		
	}

	
 //관리자
	@Override
	public List<ClassVO> selectPendingClassList(PageMaker pageMaker) throws SQLException {
		pageMaker.setPerPageNum(10);
	    int totalCount = classDAO.selectPendingClassListCount(pageMaker);
	    pageMaker.setTotalCount(totalCount);
	    return classDAO.selectPendingClassList(pageMaker);
	}
	
	@Override
	public int selectPendingClassListCount(PageMaker pageMaker) throws SQLException {
		return classDAO.selectPendingClassListCount(pageMaker);
	}
	
	@Override
	public void approveClass(ClassVO classVO) throws SQLException {
		classDAO.approveClass(classVO);
	}

}
