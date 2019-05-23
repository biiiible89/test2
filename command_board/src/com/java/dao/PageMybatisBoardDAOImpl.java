package com.java.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.java.dto.BoardVO;
import com.java.request.Criteria;
import com.mybatis.sqlSession.OracleMyBatisSqlSession;

public class PageMybatisBoardDAOImpl implements PageBoardDAO {
	private static PageMybatisBoardDAOImpl thisInstance=
			new PageMybatisBoardDAOImpl();
	private PageMybatisBoardDAOImpl() {}
	public static PageMybatisBoardDAOImpl getInstance(){
		return thisInstance;
	}
	
	
	private MybatisBoardDAOImpl instance=MybatisBoardDAOImpl.getInstance();
	
	private SqlSessionFactory sessionFactory=
			OracleMyBatisSqlSession.getSqlSessionFactory();
	
	@Override
	public List<BoardVO> selectBoardCriteria(Criteria cri) throws SQLException {
		SqlSession session = sessionFactory.openSession();
		
		int offset=cri.getPageStartRowNum();
		int limit=cri.getPerPageNum();		
		RowBounds rowBounds=new RowBounds(offset,limit);		
		
		List<BoardVO> boardList=
				session.selectList("Board-Mapper.selectSearchBoardList",cri,rowBounds);
		session.close();
		
		return boardList;
	}
	
	@Override
	public int selectBoardCriteriaTotalCount(Criteria cri) throws SQLException {
		SqlSession session = sessionFactory.openSession();
				
		List<BoardVO> boardList=
				session.selectList("Board-Mapper.selectSearchBoardList",cri);
		session.close();
		return boardList.size();
	}

	@Override
	public List<BoardVO> selectBoardList() throws SQLException {		
		return instance.selectBoardList();
	}

	@Override
	public BoardVO selectBoardByBno(int bno) throws SQLException {	
		return instance.selectBoardByBno(bno);
	}
	
	@Override
	public void insertBoard(BoardVO board) throws SQLException {
		instance.insertBoard(board);	
	}

	@Override
	public void updateBoard(BoardVO board) throws SQLException {
		instance.updateBoard(board);
	}

	@Override
	public void deleteBoard(int bno) throws SQLException {
		instance.deleteBoard(bno);		
	}

	@Override
	public void increaseViewCnt(int bno) throws SQLException {
		instance.increaseViewCnt(bno);
	}

	@Override
	public int selectBoardSeqNext() throws SQLException {
		return instance.selectBoardSeqNext();
	}

}
