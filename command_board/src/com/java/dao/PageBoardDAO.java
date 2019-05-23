package com.java.dao;

import java.sql.SQLException;
import java.util.List;

import com.java.dto.BoardVO;
import com.java.request.Criteria;

public interface PageBoardDAO extends BoardDAO {
	
	List<BoardVO> selectBoardCriteria(Criteria cri)	throws SQLException;
	int selectBoardCriteriaTotalCount(Criteria cri) throws SQLException;
}
