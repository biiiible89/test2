package com.java.action.board;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dto.BoardVO;
import com.java.request.ModifyBoardRequest;
import com.java.service.BoardService;
import com.java.service.BoardServiceImpl;

public class ModifyBoardAction implements Action {

	private BoardService service=BoardServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String url="redirect:detail.do?bno="+request.getParameter("bno");		
		
		int bno=Integer.parseInt(request.getParameter("bno"));
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String writer=request.getParameter("writer");
		
		String page=request.getParameter("page");
		String perPageNum=request.getParameter("perPageNum");
		String searchType=request.getParameter("searchType");
		String keyword=request.getParameter("keyword");
		
		// url 파라메터를 String 으로 만들경우 한글깨짐방지
		url+="&page="+page+"&perPageNum="+perPageNum
			 +"&searchType="+searchType+"&keyword="+URLEncoder.encode(keyword, "utf-8");	
		
		BoardVO board=
				new ModifyBoardRequest(bno,title,content,writer).toBoardVO();
		
		try {
			service.modify(board);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return url;
	}

}
