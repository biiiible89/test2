package com.spring.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.spring.dto.AttachVO;

public class AttachDAOImpl implements AttachDAO{
	// 빈을 등록하여 사용하면 에노테이션을 줄수 없다.
	// application-context 에서 조립해서 사용한다.
	
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public void insertAttach(AttachVO attach) throws SQLException {
		session.update("Attach-Mapper.insertAttach",attach);
	}

	@Override
	public void deleteAttach(int ano) throws SQLException {
		session.update("Attach-Mapper.deleteAttach",ano);		
		
	}
	
	@Override
	public AttachVO selectAttachByAno(int ano) throws SQLException {
		
		AttachVO attach = 
				session.selectOne("Attach-Mapper.selectAttachByAno", ano);
		
		return attach;
	}

	@Override
	public List<AttachVO> selectAttachesByPno(int pno) throws SQLException {
		List<AttachVO> attachList=
				session.selectList("Attach-Mapper.selectAttachByPno",pno);
		return attachList;
	}

	@Override
	public void deleteAllAttach(int pno) throws SQLException {
		session.update("Attach-Mapper.deleteAllAttach",pno);		
	}

}
