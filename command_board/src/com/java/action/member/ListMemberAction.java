package com.java.action.member;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.request.Criteria;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;

public class ListMemberAction implements Action {

	private MemberService service=MemberServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

			String url="member/memberList";
		
			String searchType = request.getParameter("searchType");
			String keyword = request.getParameter("keyword");
			Criteria cri = new Criteria();
			
			try {
				int page = Integer.parseInt(request.getParameter("page"));
				int perPageNum = Integer.parseInt(request.getParameter("perPageNum"));
				
				
				cri.setPage(page);
				cri.setPerPageNum(perPageNum);
			}catch(NumberFormatException e){
				System.out.println("페이지 번호 누락으로 기본 1페이지로 세팅됩니다.");
				
			}
			cri.setSearchType(searchType);
			cri.setKeyword(keyword);
			
			try {
				/*List<MemberVO> memberList=service.getMemberList();
				request.setAttribute("memberList", memberList);*/
				Map<String, Object> dataMap = service.getMemberList(cri);
				request.setAttribute("dataMap", dataMap);
				System.out.println(dataMap.get("memberList"));
			} catch (SQLException e) {			
				e.printStackTrace();
			}
				
		return url;
	}

}
