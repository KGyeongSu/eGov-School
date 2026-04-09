package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.ExamNoticeAttachVO;

public class ExamNoticeAttachDAOImpl implements ExamNoticeAttachDAO {

	private final SqlSession session;

	public ExamNoticeAttachDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectENAttachSeqNext() throws SQLException {
		return session.selectOne("ExamNoticeAttach-Mapper.selectENAttachSeqNext");
	}

	@Override
	public void insertENAttach(ExamNoticeAttachVO attach) throws SQLException {
		session.insert("ExamNoticeAttach-Mapper.insertENAttach", attach);
	}

	@Override
	public List<ExamNoticeAttachVO> selectENAttachList(String enNum) throws SQLException {
		return session.selectList("ExamNoticeAttach-Mapper.selectENAttachList", enNum);
	}

	@Override
	public void deleteENAttach(String enaNum) throws SQLException {
		session.delete("ExamNoticeAttach-Mapper.deleteENAttach", enaNum);
	}

	@Override
	public void deleteENAttachByParent(String enNum) throws SQLException {
		session.delete("ExamNoticeAttach-Mapper.deleteENAttachByParent", enNum);
	}
}
