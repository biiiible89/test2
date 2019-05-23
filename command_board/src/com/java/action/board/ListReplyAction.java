package com.java.action.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.java.action.Action;
import com.java.request.Criteria;
import com.java.service.ReplyService;
import com.java.service.ReplyServiceImpl;

public class ListReplyAction implements Action {

	private ReplyService service=ReplyServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int bno	= Integer.parseInt(request.getParameter("bno"));
		int page= Integer.parseInt(request.getParameter("page"));
		
		Criteria cri = new Criteria();
		cri.setPage(page);
		cri.setPerPageNum(5);
		
		try {
			Map<String,Object> dataMap = service.getReplyList(bno, cri);
			
			ObjectMapper mapper=new ObjectMapper();
			
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out=response.getWriter();
			
			out.println(mapper.writeValueAsString(dataMap));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

}
