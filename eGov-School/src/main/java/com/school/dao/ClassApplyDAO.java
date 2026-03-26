package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;

public interface ClassApplyDAO {
    

    List<ClassApplyVO> selectClassApply(String userNum, PageMaker pageMaker) throws SQLException;
    
    int selectClassApplyListCount(String userNum, PageMaker pageMaker) throws SQLException;
    
    ClassApplyVO selectClassByCaNum(String caNum) throws SQLException;

    void insertClassApply(ClassApplyVO apply) throws SQLException;
    void updateClassApply(ClassApplyVO apply) throws SQLException;
    void deleteClassApply(String caNum) throws SQLException;
    
    int selectClassApplySeqNext()throws SQLException;
}