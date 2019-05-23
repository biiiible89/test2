package com.java.action.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dto.MemberVO;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;

public class RegistMemberAction implements Action {

	private MemberService memberService = MemberServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String url="redirect:list.do";
		
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		String email=request.getParameter("email");
		String picture=request.getParameter("picture");
		String phone="";
		for(String data:request.getParameterValues("phone")) {
			phone+=data;
		}
		
		MemberVO member=new MemberVO();
		member.setId(id);
		member.setPwd(pwd);
		member.setPhone(phone);
		member.setEmail(email);
		member.setPicture(picture);
		
		try {
			memberService.regist(member);
		} catch (SQLException e) {			
			e.printStackTrace();			
		}
		return url;
	}

}
