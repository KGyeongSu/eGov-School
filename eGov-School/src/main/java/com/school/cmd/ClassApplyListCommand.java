package com.school.cmd;

import java.util.List;
import com.school.dto.ClassApplyVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClassApplyListCommand {
    private List<ClassApplyVO> applyList; // 수강 중인 강의 목록
    private List<ClassApplyVO> endList;   // 수강 종료된 강의 목록 (추가)
    private PageMaker pageMaker;          // 페이징 계산 데이터

    // 기본 생성자 (필요할 경우를 대비)
    public ClassApplyListCommand() {}

    
    public ClassApplyListCommand(List<ClassApplyVO> applyList, PageMaker pageMaker) {
        this.applyList = applyList;
        this.pageMaker = pageMaker;
    }

    // 종료 목록까지 한 번에 담는 생성자 (선택 사항)
    public ClassApplyListCommand(List<ClassApplyVO> applyList, List<ClassApplyVO> endList, PageMaker pageMaker) {
        this.applyList = applyList;
        this.endList = endList;
        this.pageMaker = pageMaker;
    }
}