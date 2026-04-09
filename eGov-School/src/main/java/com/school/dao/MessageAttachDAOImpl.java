package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.MessageAttachVO;

public class MessageAttachDAOImpl implements MessageAttachDAO {

	private SqlSession session;

	public MessageAttachDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectMsgAttachSeqNext() throws SQLException {
		return session.selectOne("MessageAttach-Mapper.selectMsgAttachSeqNext");
	}

	@Override
	public void insertMsgAttach(MessageAttachVO attach) throws SQLException {
		session.insert("MessageAttach-Mapper.insertMsgAttach", attach);
	}

	@Override
	public List<MessageAttachVO> selectMsgAttachList(String msNum) throws SQLException {
		return session.selectList("MessageAttach-Mapper.selectMsgAttachList", msNum);
	}

	@Override
	public void deleteMsgAttach(String maNum) throws SQLException {
		session.delete("MessageAttach-Mapper.deleteMsgAttach", maNum);
	}

	@Override
	public void deleteMsgAttachByParent(String msNum) throws SQLException {
		session.delete("MessageAttach-Mapper.deleteMsgAttachByParent", msNum);
	}
}
