package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.BonusCriteriaVO;

public interface BonusCriteriaService {

    List<BonusCriteriaVO> selectBonusCriteriaList() throws SQLException;

}