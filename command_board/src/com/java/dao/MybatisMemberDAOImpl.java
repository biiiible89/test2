package com.java.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.java.dto.MemberVO;
import com.java.request.Criteria;
import com.mybatis.sqlSession.OracleMyBatisSqlSession;

public class MybatisMemberDAOImpl implements MemberDAO{
	//싱글톤 패턴 구현
	private static MybatisMemberDAOImpl instance = new MybatisMemberDAOImpl();
	private MybatisMemberDAOImpl() {}
	public static MybatisMemberDAOImpl getInstance() {
		return instance;
	}
	
	//SqlSessionFactory
	private SqlSessionFactory sessionFactory = 
			OracleMyBatisSqlSession.getSqlSessionFactory();
	
	
	@Override
	public List<MemberVO> selectMemberList() throws SQLException {
		
		SqlSession session=sessionFactory.openSession();
		
		List<MemberVO> memberList=
				session.selectList("Member-Mapper.selectMemberList",null);
		
		session.close();
		return memberList;
	}

	@Override
	public MemberVO selectMemberById(String id) throws SQLException {
		
		SqlSession session=sessionFactory.openSession();		
		MemberVO member=
				session.selectOne("Member-Mapper.selectMemberById",id);			
		session.close();		
		return member;
	}

	@Override
	public void insertMember(MemberVO member) throws SQLException {
		SqlSession session=sessionFactory.openSession(true);
		session.update("Member-Mapper.insertMember",member);
		session.close();
	}

	@Override
	public void updateMember(MemberVO member) throws SQLException {
		SqlSession session=sessionFactory.openSession(true);
		session.update("Member-Mapper.updateMember",member);
		session.close();
	}

	@Override
	public void deleteMember(String id) throws SQLException {
		SqlSession session=sessionFactory.openSession(true);
		session.update("Member-Mapper.deleteMember",id);
		session.close();
	}
	@Override
	public void disableMember(String id) throws SQLException {
		SqlSession session=sessionFactory.openSession(true);
		session.update("Member-Mapper.disableMember",id);
		session.close();
	}
	@Override
	public List<MemberVO> selectMemberList(Criteria cri) throws SQLException {
		int offset = cri.getPageStartRowNum(); // 시작번호
		int limit = cri.getPerPageNum(); // 페이지당 보여줄 번호
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<MemberVO> memberList = null;
		
		
		SqlSession session = sessionFactory.openSession(true);
		memberList = session.selectList("Member-Mapper.selectSearchMemberList", cri, rowBounds);
		session.close();
				
		return memberList;
	}
	@Override
	public int selectMemberListCount(Criteria cri) throws SQLException {
		List<MemberVO> memberList = null;
		
		SqlSession session = sessionFactory.openSession(true);
		memberList = session.selectList("Member-Mapper.selectSearchMemberList", cri);
		session.close();
		
		return memberList.size();
	}
	
}
