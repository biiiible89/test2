package com.java.action.pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.action.Action;
import com.java.dao.AttachDAO;
import com.java.dao.AttachDAOImpl;
import com.java.dto.AttachVO;
import com.java.utils.MakeFileName;

public class GetAttachAction implements Action {

	private AttachDAO attachDAO = AttachDAOImpl.getInstance();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int ano = Integer.parseInt(request.getParameter("ano"));
		String fileName = null;
		String filePath = null;
		try {
			AttachVO attach = attachDAO.selectAttachByAno(ano);
			fileName = attach.getFileName();
			filePath = attach.getUploadPath();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		filePath = filePath + File.separator + fileName;
		
		//보낼 파일 설정 
		File downloadFile = new File(filePath);
		FileInputStream inStream = new FileInputStream(downloadFile);
		
		ServletContext context = request.getServletContext();
		
		// 파일 포맷으로 MIME를 결정한다.
		String mimeType = context.getMimeType(filePath);
		if(mimeType == null) {
			mimeType = "application/octet-stream";
		}
		System.out.println("MIME type : " + mimeType);
		
		// response 수정
		response.setContentType(mimeType);
		response.setContentLength((int) downloadFile.length());
		
		String downloadFileName = 
				new String(downloadFile.getName().getBytes("utf-8"),"ISO-8859-1");
		downloadFileName = 
				MakeFileName.parseFileNameFromUUID(downloadFileName, "\\$\\$");
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"",
				downloadFileName);
		response.setHeader(headerKey, headerValue);
		
		//파일 내보내기
		OutputStream outStream = response.getOutputStream();
		byte[]buffer = new byte[4096];
		int bytesRead = -1;
		
		while ((bytesRead = inStream.read(buffer)) != -1) {
			outStream.write(buffer, 0, bytesRead);
		}
		
		inStream.close();
		outStream.close();
	
	
		return null;
	}

}
