package com.java.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeSet;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieFilter implements Filter {

	private List<String> menuURL = new ArrayList<String>();
	private Map<String,String> menuNames = new HashMap<String,String>();

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpServletResponse httpResp = (HttpServletResponse) response;
		
		Cookie[] cookies = httpReq.getCookies();
		
		// 신규 쿠키 발송
		List<String> cookieNames = new ArrayList<String>();
		for(int i=0;i<cookies.length;i++){
			cookieNames.add(cookies[i].getName());
		}
		for(String menu:menuURL) {
			if(!cookieNames.contains(menu)) {
				Cookie cookie=new Cookie(menu,"0");
				cookie.setPath("/");
				httpResp.addCookie(cookie);				
				System.out.println(menu);
			}
		}
		
		//메뉴 선택에 따른 cookie 카운트 증가
		String uri=httpReq.getRequestURI();
		for(String menu:menuURL) {
			if(uri.contains(menu)) {
				for(Cookie cookie : cookies) {
					if(menu.equals(cookie.getName())){
						int count=Integer.parseInt(cookie.getValue());
						Cookie newCookie = new Cookie(menu,count+1+"");
						newCookie.setPath("/");
						httpResp.addCookie(newCookie);
					}
				}
			}
		}
		
		//메뉴 순위 결정.
		
		Set<Menu> menuRank = new TreeSet<Menu>();
		for(Cookie cookie:cookies) {
			if(menuURL.contains(cookie.getName())) {
				Menu menu=new Menu();
				menu.setUrl(cookie.getName());
				menu.setMenu(menuNames.get(cookie.getName()));
				menu.setCount(Integer.parseInt(cookie.getValue()));
				menuRank.add(menu);
			}
		}
		
		System.out.println("menuRank : "+menuRank);		
		request.setAttribute("menuRank", menuRank);
		
		chain.doFilter(request, response);

	}

	public void init(FilterConfig fConfig) throws ServletException {
		
		// 멤버변수 menuURL를 세팅
		String menuURLParam = fConfig.getInitParameter("menuURL");
		StringTokenizer token = new StringTokenizer(menuURLParam, ",");
		while (token.hasMoreTokens()) {
			menuURL.add(token.nextToken());
		}
		
		//멤버변수 menuNames 를 세팅
		String menuNamesParam = fConfig.getInitParameter("menuNames");
		token = new StringTokenizer(menuNamesParam, ",");
		for (int i=0;token.hasMoreTokens();i++) {
			menuNames.put(menuURL.get(i),token.nextToken());
		}
		System.out.println(menuNames);
	}

	public void destroy() {
	}

}
