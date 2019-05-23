package com.java.action.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.action.Action;
import com.java.dto.MemberVO;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;

public class ModifyMemberAction implements Action {

	private MemberService service=MemberServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		String url="redirect:detail.do?id="+request.getParameter("id");
	
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		String email=request.getParameter("email");
		String picture = request.getParameter("picture");
		String oldPicture = request.getParameter("oldPicture");
		String authority = request.getParameter("authority");
		
		String phone="";
		for(String data:request.getParameterValues("phone")) {
			phone += data;
		}
		
		if(picture.isEmpty()) {
			picture = oldPicture;
		}
		
		MemberVO member=new MemberVO();
		member.setEmail(email);
		member.setId(id);
		member.setPhone(phone);
		member.setPwd(pwd);
		member.setPicture(picture);
		member.setAuthority(authority);
		
		try {
			service.modify(member);
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
			if(member.getId().equals(loginUser.getId())) {
				member = service.getMember(id);
				session.setAttribute("loginUser", member);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return url;
	}

}
