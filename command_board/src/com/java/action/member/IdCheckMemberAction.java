package com.java.action.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dto.MemberVO;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;

public class IdCheckMemberAction implements Action {

	private MemberService service = MemberServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id = request.getParameter("id");
		System.out.println("id="+id);
		MemberVO member = null;
		try {
			member = service.getMember(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(member!=null) {
			PrintWriter out = response.getWriter();
			out.print("duplicated");
		}
		
		return null;
	}

}
