package com.school.cmd;

import java.util.List;

import com.school.dto.ClassApplyVO;

import lombok.Getter;
import lombok.Setter;


//서비스는 담고 set , jsp는 꺼내야함 get
@Getter
@Setter
public class ClassApplyListCommand {
    private List<ClassApplyVO> applyList; // 강의 목록 데이터
    private PageMaker pageMaker;          // 페이징 계산 데이터

    public ClassApplyListCommand(List<ClassApplyVO> applyList, PageMaker pageMaker) {
        this.applyList = applyList;
        this.pageMaker = pageMaker;
    }
}