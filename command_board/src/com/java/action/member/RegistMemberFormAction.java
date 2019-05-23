package com.java.action.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;

public class RegistMemberFormAction implements Action {

	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="member/regist";
		
		return url;
	}

}
