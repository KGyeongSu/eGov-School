package com.school.cmd;

import java.util.List;

import com.school.dto.QuestionVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TestAnswerCommand {
    private String tetNum;
    private List<QuestionVO> userAnswers; 
}
