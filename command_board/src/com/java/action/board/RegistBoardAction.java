package com.java.action.board;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dto.BoardVO;
import com.java.request.RegistBoardRequest;
import com.java.service.BoardService;
import com.java.service.BoardServiceImpl;

public class RegistBoardAction implements Action {

	private BoardService service=BoardServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="redirect:list.do";		
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String writer=request.getParameter("writer");
			
		BoardVO board=
		new RegistBoardRequest(title,content,writer).toBoardVO();
		
		try {
			service.write(board);
		} catch (SQLException e) {
			e.printStackTrace();		
		}
		
		return url;
	}

}
