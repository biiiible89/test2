package com.java.service;

import java.sql.SQLException;
import java.util.Map;

import com.java.dto.ReplyVO;
import com.java.request.Criteria;

public interface ReplyService {
	
		//리스트보기
		Map<String,Object> getReplyList(int bno,Criteria cri)
									throws SQLException;		
		//등록
		void registReply(ReplyVO reply)throws SQLException;
			
		//수정
		void modifyReply(ReplyVO reply)throws SQLException;
		
		//삭제
		void removeReply(int rno)throws SQLException;
}
