package com.school.service;

import java.sql.SQLException;

import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dto.ClassApplyVO;

public interface ClassApplyService {
    
    // 1. 수강 신청 (신청 내역 생성 + 진도 초기화)
    void registClassApply(ClassApplyVO apply) throws SQLException;
    
    // 2. 수강신청 목록 + 페이징 정보 + 진도율을 한 번에 담은 '박스' 리턴
    ClassApplyListCommand getClassApplyList(String userNum, PageMaker pageMaker) throws SQLException;

}