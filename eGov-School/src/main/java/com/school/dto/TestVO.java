package com.school.dto;


import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class TestVO {
    // Test 관련
	  private String tetNum;
    private String claNum;
    private String userNum;
    private String tetTitle;
    private Integer tetTimelimit;
    private Date tetRegdate;
    
    //평가예정,종료강좌에 필요한 컬럼
    private String claTitle;
    private Date claStartDate;
    private Date claEndDate;
    private Integer erScore;
    private String erPass;
    private Date erDate;
    
    private String claComplete; //수료조건
   
    
    // 강사 전용
    //강사가 제출한 시험문제들
    private List <QuestionVO> testQuestionList;
    //리스트에 담겨온 상위에서 quePoint 심어줘야 함
    private Integer quePoint;
    
    // 사용자 전용
    private Double topPercent;
    private Integer totalCount;
    private String erNum;
}
    
   
