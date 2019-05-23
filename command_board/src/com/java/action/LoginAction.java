package com.java.action;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.dto.MemberVO;
import com.java.exception.IdNotFoundException;
import com.java.exception.InvalidPasswordException;
import com.java.service.MemberServiceImpl;

public class LoginAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="redirect: "+request.getContextPath()+"/main.do";
		
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		
		String message=null;
		HttpSession session = request.getSession();		
		session.removeAttribute("msg");
		session.removeAttribute("id");		
		
		try {
			MemberServiceImpl.getInstance().login(id, pwd);
			MemberVO loginUser = MemberServiceImpl.getInstance().getMember(id);
			session.setAttribute("loginUser", MemberServiceImpl.getInstance().getMember(id));
			session.setMaxInactiveInterval(60*6);
			
			if(loginUser.getEnabled()==0) {
				message="사용중지된 아이디로 이용이 제한됩니다.";
				
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (IdNotFoundException e) {
			message="아이디가 존재하지 않습니다.";			
			url="redirect:loginForm.do";
			e.printStackTrace();
		} catch (InvalidPasswordException e) {
			message="패스워드가 일치하지 않습니다.";
			url="redirect:loginForm.do";
			e.printStackTrace();
		}
		
		session.setAttribute("msg",message);
		session.setAttribute("id",id);
		
		return url;
	}

}
