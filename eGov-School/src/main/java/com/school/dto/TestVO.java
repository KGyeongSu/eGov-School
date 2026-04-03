package com.school.dto;


import java.util.Date;

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
   
    
    private Double topPercent;
    private Integer totalCount;
    private String erNum;
}
    
   
