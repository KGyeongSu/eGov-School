package com.school.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.school.cmd.PageMaker;
import com.school.dao.ClassDAO;
import com.school.dto.ClassVO;

@Service
public class ClassServiceImpl implements ClassService {

	private ClassDAO classDAO;

	public ClassServiceImpl(ClassDAO classDAO) {

		this.classDAO = classDAO;

	}

	@Override
	public List<ClassVO> selectClassList(PageMaker pageMaker, String userNum) throws SQLException {

		return classDAO.selectClassList(pageMaker, userNum);

	}

	@Override
	public List<ClassVO> selectSearchClassList(PageMaker pageMaker, String userNum) throws SQLException {

		return classDAO.selectSearchClassList(pageMaker, userNum);

	}

	@Override
	public void insertClass(ClassVO clas) throws SQLException {

		classDAO.insertClass(clas);

	}

	@Override
	public int selectSearchClassListCount(PageMaker pageMaker, String userNum) throws SQLException {

		return classDAO.selectSearchClassListCount(pageMaker, userNum);

	}

	@Override
	public int selectClassSeqNext() throws SQLException {

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
	public List<ClassVO> selectApprovedClassList(PageMaker pageMaker) throws SQLException {
		return classDAO.selectApprovedClassList(pageMaker);
	}

	@Override
	public int selectApprovedClassListCount(PageMaker pageMaker) throws SQLException {
		return classDAO.selectApprovedClassListCount(pageMaker);
	}

}
