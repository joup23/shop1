package com.bookshop01.member.service;

import java.util.Map;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.bookshop01.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public String getUsername(String member_id)throws Exception;
	/*
	 * public UserDetails loadUserByUsername(String username)throws
	 * UsernameNotFoundException;
	 */
}
