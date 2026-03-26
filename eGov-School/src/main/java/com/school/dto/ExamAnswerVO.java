package com.school.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ExamAnswerVO {
    // 1. EXAM_ANSWER 테이블 기본 필드
    private String eaNum;
    private String erNum;
    private String queNum;
    private Integer eaSelected;
    private String eaCorrect;

    private String queText;    // 문제 내용
    private Integer queAnswer; // 실제 정답 번호
    private String queDesc;    // 문제 해설
    private Integer quePoint;  // 문제 배점
}