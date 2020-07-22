package com.bookshop01.member.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import com.bookshop01.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl  implements MemberDAO{
	@Autowired
	private SqlSession sqlSession;	
	
	public MemberVO getUserById(String username) {
		return sqlSession.selectOne("mapper.member.selectUsername", username);
	}
	
	@Override
	public String selectUsername(String id) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectUsername",id);
		return result;
	}
	
	@Override
	public MemberVO login(Map loginMap) throws DataAccessException{
		MemberVO member=(MemberVO)sqlSession.selectOne("mapper.member.loginBcrypt",loginMap);
	   return member;
	}
	
	/* ¿øº»
	 * @Override public MemberVO login(Map loginMap) throws DataAccessException{
	 * MemberVO
	 * member=(MemberVO)sqlSession.selectOne("mapper.member.login",loginMap); return
	 * member; }
	 */
	
	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewMember",memberVO);
	}

	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.member.selectOverlappedID",id);
		return result;
	}
	
	
}
