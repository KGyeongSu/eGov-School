package com.school.service;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.school.cmd.ClassApplyListCommand;
import com.school.cmd.PageMaker;
import com.school.dao.ClassApplyDAO;
import com.school.dao.ProgressDAO;
import com.school.dto.ClassApplyVO;
import com.school.dto.ProgressVO;

@Service("classApplyService") // 빈 이름을 명시적으로 지정
public class ClassApplyServiceImpl implements ClassApplyService {

 
    private ClassApplyDAO classApplyDAO;
    private ProgressDAO progressDAO;
    
    public ClassApplyServiceImpl(ClassApplyDAO classApplyDAO, ProgressDAO progressDAO) {
        this.classApplyDAO = classApplyDAO;
        this.progressDAO = progressDAO;
    }
    
    

    @Transactional
    @Override
    public void registClassApply(ClassApplyVO apply) throws SQLException {
        classApplyDAO.insertClassApply(apply);
        
        ProgressVO progress = new ProgressVO();
        progress.setUserNum(apply.getUserNum());
        progress.setClaNum(apply.getClaNum());
        
        progressDAO.insertProgress(progress);
    }

    @Override
    public ClassApplyListCommand getClassApplyList(String userNum, PageMaker pageMaker) throws SQLException {
        int totalCount = classApplyDAO.selectClassApplyListCount(userNum, pageMaker);
        pageMaker.setTotalCount(totalCount);

        List<ClassApplyVO> applyList = classApplyDAO.selectClassApply(userNum, pageMaker);

        return new ClassApplyListCommand(applyList, pageMaker);
    }
}