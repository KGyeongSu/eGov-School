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
public class LessonVO {
    private String lsnNum;
    private String claNum;
    private Integer lsnSeq;
    private String lsnTitle;
    private String lsnTime;
    private Date lsnRegdate;
}