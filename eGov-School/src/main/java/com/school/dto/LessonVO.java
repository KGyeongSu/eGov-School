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
public class LessonVO {
    private String lsnNum;
    private String claNum;
    private String userNum;
    private Integer lsnSeq;
    private String lsnTitle;
    private String lsnTime;
    private Date lsnRegdate;
    
    private String claName;    
    private String lsnContent; 
    private String lsnVideo;   
    private String fileNum;    
    

    private String prevLsnNum;  
    private String nextLsnNum;  

    private List<LessonAttachVO> lessonFiles;

    
    public void setLessonFiles(List<LessonAttachVO> lessonFiles) {
        this.lessonFiles = lessonFiles;
    }
    
    
    // 첨부파일 
    private List <LessonAttachVO> lessonAttachList;
    
}