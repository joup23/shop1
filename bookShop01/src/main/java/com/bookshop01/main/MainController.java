package com.bookshop01.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.cart.service.CartService;
import com.bookshop01.cart.vo.CartVO;
import com.bookshop01.common.base.BaseController;
import com.bookshop01.goods.service.GoodsService;
import com.bookshop01.goods.vo.GoodsVO;
import com.bookshop01.member.vo.MemberVO;

@Controller("mainController")
@EnableAspectJAutoProxy
public class MainController extends BaseController {
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CartService cartService;
	
	@Autowired
	private CartVO cartVO;
	
	@RequestMapping(value= "/main/main.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		mav.addObject("goodsMap", goodsMap);
		return mav;
	}
	@RequestMapping(value= "/test/main.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView testMain(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		session=request.getSession();
		
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		if(memberVO != null) {
			String member_id=memberVO.getMember_id();
			cartVO.setMember_id(member_id);
			
			int cartCount = cartService.cartCount(cartVO);
			mav.addObject("cartCount", cartCount);
		} else {
		
		}
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		
		mav.addObject("goodsMap", goodsMap);
		return mav;
	}
}
