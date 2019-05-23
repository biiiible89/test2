package com.java.dispatcher;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;


//@WebServlet("*.do")
public class FrontServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request, response);
	}
		
	private Map<String,Action> commandMap;
	
	@Override
	public void init() throws ServletException {		
		commandMap=HandlerMapper.getInstance().getMap();		
	}
	
	
	private void requestPro(HttpServletRequest request, 
						    HttpServletResponse response) 
						      throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String command = request.getRequestURI();
		
		if(command.indexOf(request.getContextPath())==0){
			command=command.substring(request.getContextPath().length());
		}
		
		String view=null;
		Action act=null;
		
		act = commandMap.get(command);
		
		if(act==null){
			System.out.println("not found : "+command);
			return;
		}
		
		view = act.execute(request, response);
		
		System.out.println("view : "+view);
		
		if(view==null){
			return;
		}
		
		ViewResolver.view(request, response, view);
		
	}

}
