package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.JobNoticeAttachVO;

public class JobNoticeAttachDAOImpl implements JobNoticeAttachDAO {

	private SqlSession session;

	public JobNoticeAttachDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectJNAttachSeqNext() throws SQLException {
		return session.selectOne("JobNoticeAttach-Mapper.selectJNAttachSeqNext");
	}

	@Override
	public void insertJNAttach(JobNoticeAttachVO attach) throws SQLException {
		session.insert("JobNoticeAttach-Mapper.insertJNAttach", attach);
	}

	@Override
	public List<JobNoticeAttachVO> selectJNAttachList(String jnNum) throws SQLException {
		return session.selectList("JobNoticeAttach-Mapper.selectJNAttachList", jnNum);
	}

	@Override
	public void deleteJNAttach(String jnaNum) throws SQLException {
		session.delete("JobNoticeAttach-Mapper.deleteJNAttach", jnaNum);
	}

	@Override
	public void deleteJNAttachByParent(String jnNum) throws SQLException {
		session.delete("JobNoticeAttach-Mapper.deleteJNAttachByParent", jnNum);
	}
}
