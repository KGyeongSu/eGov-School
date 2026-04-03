package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;

public class ClassApplyDAOImpl implements ClassApplyDAO {
    
    private SqlSession session;
    
    public ClassApplyDAOImpl(SqlSession session) {
        this.session = session;
    }

    @Override
    public List<ClassApplyVO> selectClassApply(String userNum, PageMaker pageMaker) throws SQLException {
       
        int offset = pageMaker.getStartRow() - 1;
        int limit = pageMaker.getPerPageNum();
        RowBounds rows = new RowBounds(offset, limit);
        
       
        return session.selectList("ClassApply-Mapper.selectClassApply", userNum, rows);
    }

    @Override
    public int selectClassApplyListCount(String userNum, PageMaker pageMaker) throws SQLException {
      
        return session.selectOne("ClassApply-Mapper.selectClassApplyListCount", userNum);
    }

    @Override
    public ClassApplyVO selectClassByCaNum(String caNum) throws SQLException {
       
        return session.selectOne("ClassApply-Mapper.selectClassByCaNum", caNum);
    }

    @Override
    public void insertClassApply(ClassApplyVO apply) throws SQLException {
        session.insert("ClassApply-Mapper.insertClassApply", apply);
    }

    @Override
    public void updateClassApply(ClassApplyVO apply) throws SQLException {
        session.update("ClassApply-Mapper.updateClassApply", apply);
    }

    @Override
    public void deleteClassApply(String caNum) throws SQLException {
        session.delete("ClassApply-Mapper.deleteClassApply", caNum);
    }

	@Override
	public int selectClassApplySeqNext() throws SQLException {
		
		return session.selectOne("ClassApply-Mapper.selectClassApplySeqNext");
	}
}