package com.java.action.pds;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dto.AttachVO;
import com.java.request.Criteria;
import com.java.request.PageMaker;
import com.java.service.PdsService;
import com.java.service.PdsServiceImpl;

public class RemovePdsAction implements Action {

	private PdsService service = PdsServiceImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url="pds/removeSuccess";
		
		int pno = Integer.parseInt(request.getParameter("pno"));
		
		int page=Integer.parseInt(request.getParameter("page"));
		int perPageNum=Integer.parseInt(request.getParameter("perPageNum"));
		
		//pno에 대한 attachList 확보
		List<AttachVO> attachList = null;
		
		try {
			attachList = service.getPds(pno).getAttachList();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		//각 attachlist 를 이용 파일 삭제.
		for(AttachVO attach:attachList) {
			String storedFilePath = 
					attach.getUploadPath()+File.separator + attach.getFileName();
			File file = new File(storedFilePath);
			if(file.exists()) {
				file.delete();
			}
		}
		
		Criteria cri=new Criteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(cri);
				
		try {
			service.remove(pno);
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		
		request.setAttribute("deleted_pno", pno);
		request.setAttribute("pageMaker", pageMaker);
		
		return url;
	}

}
