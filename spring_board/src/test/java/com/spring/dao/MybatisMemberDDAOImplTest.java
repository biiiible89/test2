package com.spring.dao;

import java.sql.SQLException;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dto.MemberVO;
import com.spring.request.Criteria;

import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:context/root-context.xml")
@TransactionConfiguration(transactionManager="transactionManager")
@Transactional
// 테스트가 끝나는 즉시 롤백이 된다. DB에 남지 않는다.
public class MybatisMemberDDAOImplTest {

	@Autowired
	private MemberDAO memberDAO;
	

	@Test
	public void testSelectMemberById() throws SQLException{
		String id="mimi";
		MemberVO member = memberDAO.selectMemberById(id);
		
		Assert.assertEquals("mimi", member.getId());
	}

	@Test
	public void testInsertMember() throws SQLException{
		MemberVO member = new MemberVO();
		member.setId("abcd1234");
		member.setPwd("abcd1234");
		member.setEmail("email");
		member.setPhone("phone");
		member.setPicture("");
		
		memberDAO.insertMember(member);
		
		MemberVO receviemember = memberDAO.selectMemberById(member.getId());
		
		Assert.assertEquals(member.getId(), receviemember.getId());
	}

	@Test
	public void testUpdateMember() throws SQLException{
		MemberVO member = memberDAO.selectMemberById("mimi");
		
		String pwd = "abcd1234";
		member.setPwd(pwd);
		
		memberDAO.updateMember(member);
		
		MemberVO receive = memberDAO.selectMemberById("mimi");
		
		Assert.assertEquals(pwd, receive.getPwd());
	}

	@Test
	public void testDeleteMember() throws SQLException{
		String id = "mimi";
		MemberVO reciveMember = memberDAO.selectMemberById(id);
		if(reciveMember != null) {
			memberDAO.deleteMember(id);
			MemberVO deleteMember = memberDAO.selectMemberById(id);
			Assert.assertNull(deleteMember);
		}else {
			System.out.println("mimi 회원은 존재하지 않음");
		}
	}

	@Test
	public void testDisableMember() throws SQLException{
		String id = "mimi";
		memberDAO.disableMember(id);
		
		MemberVO disableMember = memberDAO.selectMemberById(id);
		Assert.assertEquals(0, disableMember.getEnabled());
	}

	@Test
	public void testSelectMemberListCriteria() throws SQLException{
		Criteria cri = new Criteria();
		
		List<MemberVO> memberList = memberDAO.selectMemberList(cri);
		
		Assert.assertEquals(cri.getPerPageNum(), memberList.size());
	}

	@Test
	public void testSelectMemberListCount() throws SQLException{
		Criteria cri = new Criteria();
		cri.setSearchType("i");
		cri.setKeyword("mimi");
		
		int count = memberDAO.selectMemberListCount(cri);
		
		Assert.assertEquals(1, count);
	}

}
