package com.java.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="commons/logout";
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		request.setAttribute("msg","로그아웃 되었습니다.");
		
		return url;
	}

}
