package com.school.dao;

import java.sql.SQLException;
import org.apache.ibatis.session.SqlSession;
import com.school.dto.CertifiCateVO;


public class CertifiCateDAOImpl implements CertifiCateDAO {
    
    private SqlSession session;
 
    public CertifiCateDAOImpl(SqlSession session) {
        this.session = session;
    }

    @Override
    public CertifiCateVO selectCertifiCate(String cerNum) throws SQLException {
        return session.selectOne("CertifiCate-Mapper.selectCertifiCate", cerNum);
    }

    @Override
    public int selectCertifiCateCount(String claNum) throws SQLException {
       
        return session.selectOne("CertifiCate-Mapper.selectCertifiCateCount", claNum);
    }

    @Override
    public void updateCertifiCate(CertifiCateVO certificate) throws SQLException {
        session.update("CertifiCate-Mapper.updateCertifiCate", certificate);
    }

	@Override
	public void insertCertifiCate(CertifiCateVO certificate) throws SQLException {
		session.insert("CertifiCate-Mapper.insertCertifiCate", certificate);
		
	}

	@Override
	public int selectCertifiCateSeqNext() throws SQLException {
		return session.selectOne("CertifiCate-Mapper.selectCertifiCateSeqNext");
	}
}