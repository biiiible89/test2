package com.java.action.member;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dto.MemberVO;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;
import com.java.utils.GetUploadPath;

public class RemoveMemberAction implements Action {

	private MemberService service=MemberServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="member/removeSuccess";
		
		String id=request.getParameter("id");
		
		try {
			// 이미지 파일을 삭제
			MemberVO member = service.getMember(id);
			String fileName = member.getPicture();
			String savedPath = GetUploadPath.getUploadPath("member.picture.upload");
			File file = new File(savedPath+fileName);
			if(file.exists()) {
				file.delete();
			}
			// 삭제되는 회원이 로그인 회원인 경우 로그앗울 해야함.
			MemberVO loginUser = 
					(MemberVO)request.getSession().getAttribute("loginUser");
			if(loginUser.getId().equals(member.getId())){
				request.getSession().invalidate();
			}
			
			request.setAttribute("member", service.getMember(id));	
			service.remove(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return url;
	}

}
