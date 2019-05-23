package com.java.action.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.action.Action;
import com.java.dto.MemberVO;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;

public class DisableMemberAction implements Action {

	private MemberService service = MemberServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String id = request.getParameter("id");
		MemberVO member=null;
		try {
			member = service.getMember(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//service 호출 (enable -> 0)
		try {
			service.disable(id);
			
		}catch(SQLException e	) {
			e.printStackTrace();
		}
		
		//loginUser와 동일할 경우 로그아웃
		String url="member/stopMember";
		
		HttpSession session = request.getSession();
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if(id.equals(loginUser.getId())) {
			session.invalidate();
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('현재 접속중인 아이디 이므로 로그아웃합니다.')");
			out.println("location.herf='"+request.getContextPath()+"/commons/loginForm.do';");
			url=null;
		}else {
			request.setAttribute("member", member);
		}
		return url;
	}

}
