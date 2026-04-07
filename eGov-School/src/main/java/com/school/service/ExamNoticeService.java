package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dto.ExamNoticeVO;

public interface ExamNoticeService {

	List<ExamNoticeVO> selectExamNoticeList(PageMaker pageMaker) throws SQLException;

    List<ExamNoticeVO> selectSearchExamNoticeList(PageMaker pageMaker) throws SQLException;

    int selectSearchExamNoticeListCount(PageMaker pageMaker) throws SQLException;

    ExamNoticeVO selectExamNoticeByEn_num(String enNum) throws SQLException;
    
    void insertExamNotice(ExamNoticeVO vo) throws SQLException;
}
