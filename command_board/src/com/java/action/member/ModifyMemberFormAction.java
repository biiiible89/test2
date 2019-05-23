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

public class ModifyMemberFormAction implements Action {

	private MemberService service=MemberServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="member/memberModify";
		
		String id=request.getParameter("id");
		
		MemberVO member=null;
		try {
			member=service.getMember(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("member", member);
		
		return url;
	}

}
