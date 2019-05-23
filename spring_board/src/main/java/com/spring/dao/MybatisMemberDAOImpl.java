package com.spring.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.dto.MemberVO;
import com.spring.request.Criteria;
// 빈에 따로 등록을 안할때
// 에노테이션을 사용하여 등록
//@Repository("memberDAO")	//<bean id = "memberDAO" class = "com.spring.dao.MybatisMemberDAOImpl" />
public class MybatisMemberDAOImpl implements MemberDAO{
/*	
	//싱글톤 패턴 구현
	private static MybatisMemberDAOImpl instance = new MybatisMemberDAOImpl();
	private MybatisMemberDAOImpl() {}
	public static MybatisMemberDAOImpl getInstance() {
		return instance;
	}

	//SqlSessionFactory
	private SqlSessionFactory sessionFactory = 
			OracleMyBatisSqlSession.getSqlSessionFactory();
	이제는 SqlSessionFactory를 사용할 필요가 없다.
*/
	private SqlSession session;
	
//	@Autowired
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	//SqlSession session=sessionFactory.openSession();
	//spring에 있는 session은 자동으로 open, close를 한다.
	
	@Override
	public List<MemberVO> selectMemberList() throws SQLException {
		
		
		List<MemberVO> memberList=
				session.selectList("Member-Mapper.selectMemberList",null);
		
		return memberList;
	}

	@Override
	public MemberVO selectMemberById(String id) throws SQLException {
		
		MemberVO member=
				session.selectOne("Member-Mapper.selectMemberById",id);			
		return member;
	}

	@Override
	public void insertMember(MemberVO member) throws SQLException {
		session.update("Member-Mapper.insertMember",member);
	}

	@Override
	public void updateMember(MemberVO member) throws SQLException {
		session.update("Member-Mapper.updateMember",member);
	}

	@Override
	public void deleteMember(String id) throws SQLException {
		session.update("Member-Mapper.deleteMember",id);
	}
	@Override
	public void disableMember(String id) throws SQLException {
		session.update("Member-Mapper.disableMember",id);
	}
	@Override
	public List<MemberVO> selectMemberList(Criteria cri) throws SQLException {
		int offset = cri.getPageStartRowNum(); // 시작번호
		int limit = cri.getPerPageNum(); // 페이지당 보여줄 번호
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<MemberVO> memberList = null;
		
		
		memberList = session.selectList("Member-Mapper.selectSearchMemberList", cri, rowBounds);
				
		return memberList;
	}
	
	@Override
	public int selectMemberListCount(Criteria cri) throws SQLException {
		List<MemberVO> memberList = null;
		
		memberList = session.selectList("Member-Mapper.selectSearchMemberList", cri);
		
		return memberList.size();
	}
	
}
