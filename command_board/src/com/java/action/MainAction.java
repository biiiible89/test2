package com.java.action;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.request.Criteria;
import com.java.service.BoardService;
import com.java.service.BoardServiceImpl;
import com.java.service.MemberService;
import com.java.service.MemberServiceImpl;
import com.java.service.PdsService;
import com.java.service.PdsServiceImpl;

public class MainAction implements Action {
	
	private MemberService memberService = MemberServiceImpl.getInstance();
	private PdsService pdsService = PdsServiceImpl.getInstance();
	private BoardService boardService = BoardServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = "main";
		
		Criteria cri = new Criteria();
		cri.setPage(1);
		cri.setPerPageNum(5);
		
		try {
		Map<String,Object> memberMap = memberService.getMemberList(cri);
		Map<String,Object> boardMap = boardService.getBoardList(cri);
		Map<String,Object> pdsMap = pdsService.getList(cri);
		
		request.setAttribute("memberList", memberMap.get("memberList"));
		request.setAttribute("boardList", boardMap.get("boardList"));
		request.setAttribute("pdsList", pdsMap.get("pdsList"));
		
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return url;
	}

}
