package com.java.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.java.dto.AttachVO;

public class MakeFileName {

	// uuid를 만들어 fileName에 붙여준다.
	public static String toUUIDFileName(String fileName, String delimiter) {
		String uuid = UUID.randomUUID().toString().replace("-", "");
		return uuid + delimiter + fileName;
	}
	
	// delimiter 앞에서 짤라준다.
	public static String parseFileNameFromUUID(String fileName, String delimiter) {
		String[] uuidFileName = fileName.split(delimiter);
		return uuidFileName[uuidFileName.length-1];
	}
	
	public static List<AttachVO> parseFileNameFromAttaches(
		List<AttachVO> attachList, String delimiter){
		
			List<AttachVO> renameAttachList = new ArrayList<AttachVO>();
		
			for(AttachVO attach:attachList) {
				String fileName = attach.getFileName();
				//DB상의 fileName
				fileName = parseFileNameFromUUID(fileName, delimiter);
				//uuid가 제거된 fileName
				attach.setFileName(fileName);
				
				renameAttachList.add(attach);
			}
		return renameAttachList;
	}
}
