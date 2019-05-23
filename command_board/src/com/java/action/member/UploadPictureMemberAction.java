package com.java.action.member;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.java.action.Action;
import com.java.utils.GetUploadPath;
import com.java.utils.MakeFileName;

public class UploadPictureMemberAction implements Action {

	private static final int MEMORY_THRESHOLD = 1024 * 500; // 500KB
	private static final int MAX_FILE_SIZE = 1024 * 1024 * 1; // 1MB
	private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 2; // 2MB
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// request 파일 첨부 여부 확인.
				if (!ServletFileUpload.isMultipartContent(request)) {
					PrintWriter out = response.getWriter();

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

				// 실제 저장 경로를 설정.
				// properties를 만들면서 필요가 없음
				// String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIRECTORY;
				// String uploadPath = rootDrive;

		/*		for (String path : rootPath) {
					File filePath = new File(uploadPath + File.separator + path);
					if (!filePath.exists()) {
						filePath.mkdirs();
					}
					uploadPath += File.separator + path;
				}
		*/
				String uploadPath = GetUploadPath.getUploadPath("member.picture.upload");
				
				File file = new File(uploadPath);
				if(!file.mkdirs()) {
					System.out.println(uploadPath+"가 이미 존재하거나 생성에 실패했습니다.");
				}
				
		/* 
				 * 
				uploadPath += File.separator + UPLOAD_DIRECTORY;

				// 실제 저장 경로를 생성(없으면)
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdir();
				}
		*/

				// request로 부터 받는 파일을 추출해서 저장.
				try {
					List<FileItem> formItems = upload.parseRequest(request);

					// 파일 개수 확인.
					if (formItems != null && formItems.size() > 0) {
						for (FileItem item : formItems) {	// form items 반복하여 꺼내는 곳
							if (!item.isFormField()) { // 파일일 경우 해당
								String fileName = MakeFileName.toUUIDFileName(".jpg", "");
								String filePath = uploadPath + File.separator + fileName;
								File storeFile = new File(filePath);

								// local HDD 에 저장.
								item.write(storeFile);
								
								PrintWriter out = response.getWriter();
								out.print(fileName);
							}else {	// 텍스트인 경우
								switch (item.getFieldName()) {
								case "oldPicture":
									String oldFileName = item.getString("utf-8");
									File oldFile = new File(uploadPath+File.separator+oldFileName);
									if(oldFile.exists()) {
										oldFile.delete();
									}
									break;
								}
							}
						}
					}
				} catch (Exception e) {

				}
		return null;
	}

}
