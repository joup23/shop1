package com.bookshop01.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bookshop01.member.vo.MemberVO;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");

		if (memberVO != null) {
			String auth = memberVO.getAuthority();
			if (!auth.equals("ADMIN")) {
				response.sendRedirect("/bookshop01/main/main.do");
				return false;
			}
		}

		if (memberVO == null) {
			response.sendRedirect("/bookshop01/member/loginForm.do");
			return false;
		}

		return true;
	}

}
