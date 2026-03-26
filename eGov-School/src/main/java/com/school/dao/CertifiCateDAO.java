package com.school.dao;

import java.sql.SQLException;

import com.school.dto.CertifiCateVO;

public interface CertifiCateDAO {
	
	CertifiCateVO selectCertifiCate(String cerNum)throws SQLException;
	int selectCertifiCateCount(String claNum)throws SQLException;
	
	void insertCertifiCate(CertifiCateVO certificate)throws SQLException;
	void updateCertifiCate(CertifiCateVO certificate)throws SQLException;
	
	int selectCertifiCateSeqNext()throws SQLException;
}
