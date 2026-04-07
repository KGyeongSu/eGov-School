package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.school.dto.MessageAttachVO;
import com.school.dto.MessageVO;

public class MessageDAOImpl implements MessageDAO {

	private SqlSession session;

	public MessageDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public String selectMessageSeqNext() throws SQLException {
		return session.selectOne("Message-Mapper.selectMessageSeqNext");
	}

	@Override
	public void insertMessage(MessageVO message) throws SQLException {
		session.insert("Message-Mapper.insertMessage", message);
	}

	@Override
	public List<MessageVO> selectReceivedList(String userNum) throws SQLException {
		return session.selectList("Message-Mapper.selectReceivedList", userNum);
	}

	@Override
	public List<MessageVO> selectSentList(String userNum) throws SQLException {
		return session.selectList("Message-Mapper.selectSentList", userNum);
	}

	@Override
	public MessageVO selectMessageByNum(String msNum) throws SQLException {
		return session.selectOne("Message-Mapper.selectMessageByNum", msNum);
	}

	@Override
	public void updateMessageCheck(String msNum) throws SQLException {
		session.update("Message-Mapper.updateMessageCheck", msNum);
	}

	@Override
	public void deleteMessage(String msNum) throws SQLException {
		session.delete("Message-Mapper.deleteMessage", msNum);
	}

	@Override
	public String selectPassStudentByUserNum(String userNum, String claNum) throws SQLException {
		
		Map<String, Object> param = new HashMap<> ();
		param.put("userNum", userNum);
		param.put("claNum", claNum);
		
		return session.selectOne("Message-Mapper.selectPassStudentByUserNum", param);
		
	}

}