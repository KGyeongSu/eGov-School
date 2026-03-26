package com.school.dao;

import java.sql.SQLException;
import java.util.List;

import com.school.dto.ReputationVO;

public interface ReputationDAO {
	
	
	List<ReputationVO>selectReputationList(String claNum)throws SQLException;
	
	ReputationVO selectReputationCount(String claNum)throws SQLException;
	
	void insertReputation(ReputationVO reputation)throws SQLException;
	
	void updateReputation(ReputationVO reputation)throws SQLException;
	
	int selectReputaioneqNext()throws SQLException;

}
