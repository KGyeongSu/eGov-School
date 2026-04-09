package com.school.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;
import com.school.dto.LessonVO;
import com.school.dto.ReputationVO;

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
	public String selectClassApplySeqNext() throws SQLException {
		
		return session.selectOne("ClassApply-Mapper.selectClassApplySeqNext");
	}
	
	@Override
	public void updateClassProgress(ClassApplyVO apply) throws SQLException {
	    session.update("ClassApply-Mapper.updateClassProgress", apply);
	}



	@Override
	public Integer selectLastLsnSeq(LessonVO searchVO) {
		
		return session.selectOne("Lesson-Mapper.selectLastLsnSeq",searchVO);
	}

	@Override
	public List<ClassApplyVO> selectCompletedClassList(ClassApplyVO apply) throws SQLException {
	
		return session.selectList("ClassApply-Mapper.selectCompletedClassList", apply);
	}

	@Override
	public int checkDuplicate(String userNum, String claNum) throws SQLException {
		Map<String, String> param = new HashMap<>();
	    param.put("userNum", userNum);
	    param.put("claNum", claNum);
	    return session.selectOne("ClassApply-Mapper.checkDuplicate", param);
	}

	@Override
	public int checkFull(String claNum) throws SQLException {
		return session.selectOne("ClassApply-Mapper.checkFull", claNum);
	}
	@Override
	public void insertReputation(ReputationVO repo) throws SQLException {
		
		session.insert("ClassApply-Mapper.insertReputation", repo);
	}

}