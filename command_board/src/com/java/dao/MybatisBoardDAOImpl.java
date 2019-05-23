package com.java.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.java.dto.BoardVO;
import com.mybatis.sqlSession.OracleMyBatisSqlSession;

public class MybatisBoardDAOImpl implements BoardDAO {
	
	private static MybatisBoardDAOImpl instance=
			new MybatisBoardDAOImpl();
	private MybatisBoardDAOImpl() {}
	public static MybatisBoardDAOImpl getInstance() {
		return instance;
	}
	
	private SqlSessionFactory sessionFactory=
				OracleMyBatisSqlSession.getSqlSessionFactory();
	
	@Override
	public List<BoardVO> selectBoardList() throws SQLException {
		SqlSession session = sessionFactory.openSession();		
		List<BoardVO> boardList=
				session.selectList("Board-Mapper.selectBoardList",null);		
		session.close();		
		return boardList;
	}

	@Override
	public BoardVO selectBoardByBno(int bno) throws SQLException {
		SqlSession session = sessionFactory.openSession();		
		BoardVO board=
				session.selectOne("Board-Mapper.selectBoardByBno",bno);
		session.close();
		return board;
	}

	@Override
	public void insertBoard(BoardVO board) throws SQLException {
		SqlSession session = sessionFactory.openSession(true);		
		session.update("Board-Mapper.insertBoard",board);
		session.close();
	}

	@Override
	public void updateBoard(BoardVO board) throws SQLException {
		SqlSession session = sessionFactory.openSession(true);		
		session.update("Board-Mapper.updateBoard",board);
		session.close();
	}

	@Override
	public void deleteBoard(int bno) throws SQLException {
		SqlSession session = sessionFactory.openSession(true);		
		session.update("Board-Mapper.deleteBoard",bno);
		session.close();
	}

	@Override
	public void increaseViewCnt(int bno) throws SQLException {
		SqlSession session = sessionFactory.openSession(true);		
		session.update("Board-Mapper.increaseViewCnt",bno);
		session.close();
	}

	@Override
	public int selectBoardSeqNext() throws SQLException {
		SqlSession session = sessionFactory.openSession();
		int seq_num=
				session.selectOne("Board-Mapper.selectBoardSeqNext");
		session.close();
		return seq_num;
	}

}
