package com.school.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BonusCriteriaVO {
    private String bcNum;
    private String claNum;
    private String bcContent;
    private int bcScore;
    private String bcNote;
    private String userNum;
    private Date bcRegdate;
}
