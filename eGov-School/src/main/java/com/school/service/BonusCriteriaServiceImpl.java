package com.school.service;

import java.sql.SQLException;
import java.util.List;

import com.school.dao.BonusCriteriaDAO;
import com.school.dto.BonusCriteriaVO;

public class BonusCriteriaServiceImpl implements BonusCriteriaService {

    private final BonusCriteriaDAO bonusCriteriaDAO;

    public BonusCriteriaServiceImpl(BonusCriteriaDAO bonusCriteriaDAO) {
        this.bonusCriteriaDAO = bonusCriteriaDAO;
    }

    @Override
    public List<BonusCriteriaVO> selectBonusCriteriaList() throws SQLException {
        return bonusCriteriaDAO.selectBonusCriteriaList();
    }

}