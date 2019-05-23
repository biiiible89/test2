package com.java.action.pds;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dao.AttachDAO;
import com.java.dao.AttachDAOImpl;
import com.java.dto.AttachVO;
import com.java.dto.PdsVO;
import com.java.service.PdsService;
import com.java.service.PdsServiceImpl;
import com.java.utils.MakeFileName;

public class ModifyPdsFormAction implements Action {

	private PdsService service=PdsServiceImpl.getInstance();
	private AttachDAO attachDAO = AttachDAOImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url="pds/modify";
		
		int pno=Integer.parseInt(request.getParameter("pno"));
		
		try {
			PdsVO pds=service.getPds(pno);
			List<AttachVO> renamedAttachList =
					MakeFileName.parseFileNameFromAttaches(pds.getAttachList(), "\\$\\$");
			pds.setAttachList(renamedAttachList);
			request.setAttribute("pds", pds);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return url;
	}

}
