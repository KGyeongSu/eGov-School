package com.school.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Getter
@Setter
@ToString
@NoArgsConstructor 
@AllArgsConstructor
public class LearningStatusVO {

    private int prgNum;         
    private String userNum;      
    private String claNum;       
    private String lsnNum;       
    private int lsnSeq;          // 차시 번호 필드 추가 (필수)
    private String prgComplete;  
    private Date prgLastdate;    
    
    private double watchTime;    
    private double progress;     
}