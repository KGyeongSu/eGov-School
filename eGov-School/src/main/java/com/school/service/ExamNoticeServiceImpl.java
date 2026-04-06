package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.cmd.PageMaker;
import com.school.dao.ExamNoticeDAO;
import com.school.dto.ExamNoticeVO;

public class ExamNoticeServiceImpl implements ExamNoticeService {

    private ExamNoticeDAO examNoticeDAO;

    public ExamNoticeServiceImpl(ExamNoticeDAO examNoticeDAO) {
        this.examNoticeDAO = examNoticeDAO;
    }

    @Override
    public List<ExamNoticeVO> selectExamNoticeList(PageMaker pageMaker) throws SQLException {
        return examNoticeDAO.selectExamNoticeList(pageMaker);
    }

    @Override
    public List<ExamNoticeVO> selectSearchExamNoticeList(PageMaker pageMaker) throws SQLException {
        return examNoticeDAO.selectSearchExamNoticeList(pageMaker);
    }

    @Override
    public int selectSearchExamNoticeListCount(PageMaker pageMaker) throws SQLException {
        return examNoticeDAO.selectSearchExamNoticeListCount(pageMaker);
    }

    @Override
    public ExamNoticeVO selectExamNoticeByEn_num(String enNum) throws SQLException {
        return examNoticeDAO.selectExamNoticeByEn_num(enNum);
    }

	
}
