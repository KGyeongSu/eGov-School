package com.school.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import com.school.dao.CertifiCateDAO;
import com.school.dto.CertifiCateVO;

public class CertificateServiceImpl implements CertificateService {
	
	private final CertifiCateDAO certificateDAO;

	public CertificateServiceImpl(CertifiCateDAO certificateDAO) {
		
		this.certificateDAO = certificateDAO;
		
	}

	@Override
	public String selectCertifiCateSeqNext() throws SQLException {

		return certificateDAO.selectCertifiCateSeqNext();
		
	}
	
	@Value("${savedPath.certificate.file}")
	private String certificateFilePath;
	
	@Override
	public void insertCertifiCate(String cerNum, String claNum, MultipartFile uploadFile) throws SQLException {

		// 파일 이름
	    String name = uploadFile.getOriginalFilename();
	    String saveName = UUID.randomUUID().toString() + "_" + name; 
	    
	    File savePath = new File(certificateFilePath);
	    
	    if (!savePath.exists()) {
	    	
	        savePath.mkdirs(); 
	        
	    }
	    
	    // 실제 저장
	    File target = new File(certificateFilePath, saveName);
	    try {
	    	
			uploadFile.transferTo(target);
			
		} catch (IllegalStateException | IOException e) {
			
			e.printStackTrace();
			
			throw new RuntimeException("파일 저장 실패!", e);
		}

	    // DB
	    CertifiCateVO certi = new CertifiCateVO();
	    certi.setCerNum(cerNum);
	    certi.setClaNum(claNum);
	    certi.setCerName(name);        
	    certi.setCerSaveName(saveName);
	    certi.setCerSavePath(certificateFilePath); 

	    // 4. DAO 호출
	    certificateDAO.insertCertifiCate(certi);
		
	}

	@Override
	public CertifiCateVO selectCertifiCate(String claNum) throws SQLException {

		return certificateDAO.selectCertifiCate(claNum);
		
	}

	@Override
	public void updateCertifiCate(String cerNum, String claNum, MultipartFile uploadFile) throws SQLException {
		
		CertifiCateVO oldCerti = certificateDAO.selectCertifiCate(claNum);

	    if (uploadFile != null && !uploadFile.isEmpty()) {
	    	
	        if (oldCerti != null) {
	        	
	            File oldFile = new File(oldCerti.getCerSavePath(), oldCerti.getCerSaveName());
	            
	            if (oldFile.exists()) {
	                oldFile.delete();
	                
	            }
	        }

	        // 3. 새 파일 저장 로직 (insert와 동일)
	        String name = uploadFile.getOriginalFilename();
	        String saveName = UUID.randomUUID().toString() + "_" + name;
	        File target = new File(certificateFilePath, saveName);

	        try {
	            uploadFile.transferTo(target);
	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }

	        // 4. DB 정보 업데이트
	        CertifiCateVO certi = new CertifiCateVO();
	        certi.setCerNum(oldCerti.getCerNum());
	        certi.setCerName(name);
	        certi.setCerSaveName(saveName);
	        certi.setCerSavePath(certificateFilePath);

	        certificateDAO.updateCertifiCate(certi);
	    }
		
	}
	
	
	
	

}
