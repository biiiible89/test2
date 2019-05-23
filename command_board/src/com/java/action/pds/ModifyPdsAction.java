package com.java.action.pds;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.java.action.Action;
import com.java.dao.AttachDAO;
import com.java.dao.AttachDAOImpl;
import com.java.dto.AttachVO;
import com.java.dto.PdsVO;
import com.java.service.PdsService;
import com.java.service.PdsServiceImpl;
import com.java.utils.GetUploadPath;
import com.java.utils.MakeFileName;

public class ModifyPdsAction implements Action {

	private PdsService service=PdsServiceImpl.getInstance();
	private AttachDAO attachDAO = AttachDAOImpl.getInstance();
	private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; // 3MB
	private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
	private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		if (!ServletFileUpload.isMultipartContent(request)) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('multipart/form-data 형식이 아닙니다.')");
			out.println("</script>");
			out.flush();
			out.close();
			
			return null;
		}
		
		// 업로드를 위한 upload 환경설정 적용.
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 저장을 위한 threshold memory 적용.
		factory.setSizeThreshold(MEMORY_THRESHOLD);
		// 임시 저장 위치 결정.
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		ServletFileUpload upload = new ServletFileUpload(factory);

		// 업로드 파일의 크기 적용.
		upload.setFileSizeMax(MAX_FILE_SIZE);

		// 업로드 request 크기 적용.
		upload.setSizeMax(MAX_REQUEST_SIZE);

/*		
		// 실제 저장 경로를 설정.
		// String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIRECTORY;
		String uploadPath = rootDrive;

		for (String path : rootPath) {
			File filePath = new File(uploadPath + File.separator + path);
			if (!filePath.exists()) {
				filePath.mkdirs();
			}
			uploadPath += File.separator + path;
		}
		uploadPath += File.separator + UPLOAD_DIRECTORY;
*/
		String uploadPath = GetUploadPath.getUploadPath("pds.upload");
		File file = new File(uploadPath);
		if(!file.mkdirs()) {
			System.out.println(uploadPath+"생성을 실패했습니다.");
		}
		
/*		
		// 실제 저장 경로를 생성(없으면)
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}
*/		
		
		// 페이지 유지
		int pno=-1;
		String page=null;
		String perPageNum=null;
		String searchType=null;
		String keyword=null;
		
		PdsVO pds = new PdsVO();
		List<AttachVO> attachList = new ArrayList<AttachVO>();
		
		// request로 부터 받는 파일을 추출해서 저장.
		try {
			List<FileItem> formItems = upload.parseRequest(request);

			// 파일 개수 확인.
			if (formItems != null && formItems.size() > 0) {
				
				String title=null;
				String content=null;
				String writer=null;
				
				List<String> deleteFile = new ArrayList<String>();
				
				for (FileItem item : formItems) {
					if (!item.isFormField()) { //파일 가져오기
						
						String fileName = new File(item.getName()).getName();
						fileName = MakeFileName.toUUIDFileName(fileName, "$$");
						String filePath = uploadPath + File.separator + fileName;
						File storeFile = new File(filePath);
						
						// local HDD 에 저장.
						item.write(storeFile);

						// DB에 저장할 attach에 file 내용 추가.
						AttachVO attach = new AttachVO();
						attach.setFileName(fileName);
						attach.setUploadPath(uploadPath);
						attach.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1));

						attachList.add(attach);

						System.out.println("upload file : " + attach);

						request.setAttribute("message", "업로드 되었습니다.");
						
					}else { //텍스트 파라메터 가져오기
						
						
						switch (item.getFieldName()) {
						case "title":
							title = item.getString("utf-8");
							break;
						case "writer":
							writer = item.getString("utf-8");
							break;
						case "content":
							content = item.getString("utf-8");
							break;
						case "pno":
							pno = Integer.parseInt(item.getString("utf-8"));
							break;
						case "page":
							page = item.getString("utf-8");
							break;
						case "perPageNum":
							perPageNum = item.getString("utf-8");
							break;
						case "searchType":
							searchType = item.getString("utf-8");
							break;
						case "keyword":
							keyword = item.getString("utf-8");
							break;
						case "deleteFile":
							int ano = Integer.parseInt(item.getString("utf-8"));
							AttachVO attach = attachDAO.selectAttachByAno(ano);
							
							String filePath = attach.getUploadPath() + File.separator + attach.getFileName();
							File targetFile = new File(filePath);
							
							targetFile.delete();
							
							attachDAO.deleteAttach(ano);
							
							deleteFile.add(item.getString("utf-8"));
							break;
						}
					}
				} // end for
				
				pds.setTitle(title);
				pds.setContent(content);
				pds.setWriter(writer);
				pds.setPno(pno);
				pds.setAttachList(attachList);
				
				service.modify(pds);
				
				System.out.println("receive pds : \n" + pds);
				System.out.println("deleteFile : \n" + deleteFile);
			}
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "파일 업로드에 실패했습니다.");
		}
		
		// url 파라메터를 String 으로 만들경우 한글깨짐방지
		String url="redirect:detail.do?pno="+pno;
		
		url+="&page="+page+"&perPageNum="+perPageNum
			 +"&searchType="+searchType+"&keyword="+URLEncoder.encode(keyword, "utf-8");	
		
		return url;
	}

}
