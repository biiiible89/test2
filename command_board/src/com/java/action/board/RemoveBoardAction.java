package com.java.action.board;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.request.Criteria;
import com.java.request.PageMaker;
import com.java.service.BoardService;
import com.java.service.BoardServiceImpl;

public class RemoveBoardAction implements Action {

	private BoardService service = BoardServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="board/removeSuccess";
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		Criteria cri=new Criteria();
		
		try {
			int page=Integer.parseInt(request.getParameter("page"));
			int perPageNum=Integer.parseInt(request.getParameter("perPageNum"));
			
			cri.setPage(page);
			cri.setPerPageNum(perPageNum);
		}catch(NumberFormatException e) {
			System.out.println("페이지 번호를 1로 세팅합니다.");
		}
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(cri);
				
		try {
			service.remove(bno);
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		request.setAttribute("deleted_bno", bno);
		request.setAttribute("pageMaker", pageMaker);
		
		return url;
	}

}
