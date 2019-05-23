package com.java.action.board;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dto.BoardVO;
import com.java.service.BoardService;
import com.java.service.BoardServiceImpl;

public class DetailBoardAction implements Action {

	private BoardService service=BoardServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="board/detailBoard";
		
		int bno=Integer.parseInt(request.getParameter("bno"));
		
		try {
			BoardVO board=service.getBoard(bno);
			request.setAttribute("board", board);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return url;
	}

}
