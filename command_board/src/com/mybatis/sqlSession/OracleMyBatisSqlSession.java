package com.mybatis.sqlSession;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class OracleMyBatisSqlSession {
	
	private static OracleMyBatisSqlSession instance=
			new OracleMyBatisSqlSession();
	private OracleMyBatisSqlSession() {}
	public static OracleMyBatisSqlSession getInstance() {
		return instance;
	}
	
	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		
		String config="com/mybatis/resource/sqlConfig.xml";
		
		try {
			Reader reader=Resources.getResourceAsReader(config);
			
			sqlSessionFactory=new SqlSessionFactoryBuilder().build(reader);
			
			/*reader.close();*/
			
			System.out.println("sqlSessionFactory 성공했습니다.");
		}catch(Exception e) {			
			System.out.println("sqlSessionFactory 실패했습니다.");
			e.printStackTrace();
		}
		
	}
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
}
