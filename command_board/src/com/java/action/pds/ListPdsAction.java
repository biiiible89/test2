package com.java.action.pds;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.request.Criteria;
import com.java.service.PdsServiceImpl;

public class ListPdsAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String url="pds/list";
		
		String page=request.getParameter("page");
		String perPageNum=request.getParameter("perPageNum");	
		String searchType=request.getParameter("searchType");
		String keyword=request.getParameter("keyword");
		
		Criteria cri=new Criteria();
		
		try {
			cri.setPage(Integer.parseInt(page));
			cri.setPerPageNum(Integer.parseInt(perPageNum));
		}catch(NumberFormatException e) {
			System.out.println("페이지 번호를 1로 세팅 합니다.");
		}
		if(searchType!=null && keyword!=null) {
			cri.setSearchType(searchType);
			cri.setKeyword(keyword);
		}
		
		try {
			Map<String,Object> dataMap=
					PdsServiceImpl.getInstance().getList(cri);
			
			request.setAttribute("dataMap", dataMap);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}				
		
		return url;
	}

}
