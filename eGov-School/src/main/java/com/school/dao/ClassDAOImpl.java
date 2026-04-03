package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;
import com.school.dto.ClassVO;
import com.school.dto.UserVO;

public class ClassDAOImpl implements ClassDAO {
	
	private final SqlSession session;

	public ClassDAOImpl(SqlSession session) {
		
		this.session = session;
		
	}

	@Override
	public List<ClassVO> selectClassList(PageMaker pageMaker, String userNum, RowBounds rows) throws SQLException {
		
		Map<String, Object> classList = new HashMap<>();
		classList.put("pageMaker", pageMaker);
		classList.put("userNum", userNum);
		
		return session.selectList("Class-Mapper.selectClassList", classList, rows);
		
	}
	
	@Override
	public List<ClassVO> selectSearchClassList(PageMaker pageMaker, String userNum) throws SQLException {
		
		int offset = pageMaker.getStartRow() -1;
		int limit = pageMaker.getPerPageNum();
		RowBounds rows = new RowBounds (offset, limit);
		
		Map<String, Object> classSearchList = new HashMap<> ();
		classSearchList.put("pageMaker", pageMaker);
		classSearchList.put("userNum", userNum);
		
		return session.selectList("Class-Mapper.selectSearchClassList", classSearchList, rows);
		
	}

	@Override
	public ClassVO selectClassByCla_num(String claNum) throws SQLException {
		
		return session.selectOne("Class-Mapper.selectClassByCla_num", claNum);
		
	}
	
	@Override
	public int selectSearchClassListCount(PageMaker pageMaker, String userNum) throws SQLException {
		
		Map<String, Object> searchCount = new HashMap<> ();
		searchCount.put("pageMaker", pageMaker);
		searchCount.put("userNum", userNum);
		
		return session.selectOne("Class-Mapper.selectSearchClassListCount", searchCount);
		
	}

	@Override
	public void insertClass(ClassVO clas) throws SQLException {

		session.insert("Class-Mapper.insertClass", clas);
		
	}

	@Override
	public void increaseViewCnt(String claNum) throws SQLException {
		
		session.update("Class-Mapper.increaseViewCnt", claNum);
		
	}

	@Override
	public String selectClassSeqNext() throws SQLException {

		return session.selectOne("Class-Mapper.selectClassSeqNext");
		
	}
	@Override
	public void updateClassProgress(String userNum, String claNum, int progressPercent) throws SQLException {
	    ClassApplyVO apply = new ClassApplyVO();
	    apply.setUserNum(userNum);
	    apply.setClaNum(claNum);
	    apply.setProgress((double)progressPercent); // VO의 progress 타입에 맞춰 형변환

	    session.update("ClassApply-Mapper.updateClassProgress", apply);
	}

	@Override
	public List<ClassVO> selectApprovedClassList(PageMaker pageMaker) throws SQLException {
		int offset = pageMaker.getStartRow() -1;
		int limit = pageMaker.getPerpageNum();
		RowBounds rows = new RowBounds (offset, limit);
		
		Map<String, Object> param = new HashMap<> ();
		param.put("pageMaker", pageMaker);
		param.put("sortType", pageMaker.getSearchType());
		param.put("category", pageMaker.getKeyword2());
		
		return session.selectList("Class-Mapper.selectApprovedClassList", param, rows);
	}

	@Override
	public int selectApprovedClassListCount(PageMaker pageMaker) throws SQLException {
		Map<String, Object> param = new HashMap<> ();
		param.put("pageMaker", pageMaker);
		param.put("category", pageMaker.getKeyword2());
		
		return session.selectOne("Class-Mapper.selectApprovedClassListCount", param);
	}

	@Override
	public List<UserVO> selectStudentListByClaNum(PageMaker pageMaker, String claNum, RowBounds rows) throws SQLException {
		
		Map<String, Object> studentList = new HashMap<>();
		studentList.put("pageMaker", pageMaker);
		studentList.put("claNum", claNum);
		
		return session.selectList("Class-Mapper.selectStudentListByClaNum", studentList, rows);
		
	}

	@Override
	public int selectStudentListCount(PageMaker pageMaker, String claNum) throws SQLException {
		
		Map <String, Object> studentCount = new HashMap<> ();
		studentCount.put("pageMaker", pageMaker);
		studentCount.put("claNum", claNum);

		return session.selectOne("Class-Mapper.selectStudentListCount", studentCount);
		
	}

}
