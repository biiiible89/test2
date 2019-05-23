package com.java.action.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.java.action.Action;
import com.java.dto.ReplyVO;
import com.java.service.ReplyService;
import com.java.service.ReplyServiceImpl;

public class ModifyReplyAction implements Action {

	private ReplyService service=ReplyServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ObjectMapper mapper=new ObjectMapper();		
		ReplyVO reply = mapper.readValue(request.getReader(), ReplyVO.class);
		PrintWriter out = response.getWriter();		
		
		try {
			service.modifyReply(reply);			
			out.print("SUCCESS");
		} catch (SQLException e) {
			e.printStackTrace();
			out.print("FAIL");
		}
		out.close();
		
		return null;
	}

}
