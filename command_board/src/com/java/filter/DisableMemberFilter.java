package com.java.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.dto.MemberVO;


@WebFilter("/")
public class DisableMemberFilter implements Filter {

    
	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpReq = (HttpServletRequest)request;
		HttpServletResponse httpResp = (HttpServletResponse)response;
		String uri = httpReq.getRequestURI();
		
		Set<String> preventURL = new HashSet<String>();
		
		preventURL.add("regist");
		preventURL.add("modify");
		preventURL.add("remove");
		
		MemberVO loginUser = (MemberVO) httpReq.getSession().getAttribute("loginUser");
		
		if(loginUser != null && loginUser.getEnabled() == 0) {
			for(String url:preventURL) {
				if(uri.contains(url)) {
					httpResp.setContentType("text/html;charset=utf-8");
					PrintWriter out = httpResp.getWriter();
					out.println("<script>");
					out.println("alert('제한된 사용자 입니다.');");
					out.println("history.go(-1);");
					out.println("</script>");
					return;
				}
			}
		}
		
		chain.doFilter(request, response);
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
