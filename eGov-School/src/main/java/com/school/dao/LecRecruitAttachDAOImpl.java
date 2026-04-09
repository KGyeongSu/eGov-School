package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.LecRecruitAttachVO;

public class LecRecruitAttachDAOImpl implements LecRecruitAttachDAO {

	private SqlSession session;

	public LecRecruitAttachDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectLRAttachSeqNext() throws SQLException {
		return session.selectOne("LecRecruitAttach-Mapper.selectLRAttachSeqNext");
	}

	@Override
	public void insertLRAttach(LecRecruitAttachVO attach) throws SQLException {
		session.insert("LecRecruitAttach-Mapper.insertLRAttach", attach);
	}

	@Override
	public List<LecRecruitAttachVO> selectLRAttachList(String ltNum) throws SQLException {
		return session.selectList("LecRecruitAttach-Mapper.selectLRAttachList", ltNum);
	}

	@Override
	public void deleteLRAttach(String lraNum) throws SQLException {
		session.delete("LecRecruitAttach-Mapper.deleteLRAttach", lraNum);
	}

	@Override
	public void deleteLRAttachByParent(String ltNum) throws SQLException {
		session.delete("LecRecruitAttach-Mapper.deleteLRAttachByParent", ltNum);
	}
}
