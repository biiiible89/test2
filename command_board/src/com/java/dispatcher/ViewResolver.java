package com.java.dispatcher;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewResolver {
	public static void view(HttpServletRequest request, 
						    HttpServletResponse response, 
						    String view)
						    	throws ServletException, IOException {
		
		//실제 view path : /WEB-INF/views/member/list.jsp
		//action 리턴 view : member/list
		if(view==null) {
			return;
		}
		if (view.contains("redirect:")) {
			view = view.replace("redirect:", "");
			response.sendRedirect(view);
		} else {	
			String prefix="/WEB-INF/views/";
			String subfix=".jsp";
			String url=prefix+view+subfix;
		request.getRequestDispatcher(url).forward(request, response);
		}
	}
}
