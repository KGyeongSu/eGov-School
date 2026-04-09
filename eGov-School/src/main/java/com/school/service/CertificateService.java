package com.school.service;

import java.sql.SQLException;

import org.springframework.web.multipart.MultipartFile;

import com.school.dto.CertifiCateVO;

public interface CertificateService {
	
	// 강사
	String selectCertifiCateSeqNext () throws SQLException;
	
	// 수료증 등록
	void insertCertifiCate (String cerNum, String claNum, MultipartFile uploadFile) throws SQLException;
	
	// 수정할 때 불러오기
	CertifiCateVO selectCertifiCate (String claNum) throws SQLException;
	
	// 수료증 수정
	void updateCertifiCate(String cerNum, String claNum, MultipartFile uploadFile) throws SQLException;
}
