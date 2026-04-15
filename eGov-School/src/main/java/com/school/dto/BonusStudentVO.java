package com.school.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BonusStudentVO {
    private String userName;
    private String subjectName;
    private int bcScore;
    private String passed;
}
