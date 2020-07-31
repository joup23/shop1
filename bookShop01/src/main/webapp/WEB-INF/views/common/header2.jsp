<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<body>
	<div class="site-wrap">
		<header class="site-navbar" role="banner">
			<div class="site-navbar-top">
				<div class="container">
					<div class="row align-items-center">

						<div id="search"
							class="col-6 col-md-4 order-2 order-md-1 site-search-icon text-left">
							<form name="frmSearch"
								action="${contextPath}/goods/searchGoodsTest.do"
								class="site-block-top-search">
								<span class="icon icon-search2"></span> <input type="text"
									name="searchWord" onKeyUp="keywordSearch()"
									class="form-control border-0" placeholder="Search">
							</form>
							<div id="suggest" class="suggest1">
								<div id="suggestList" class="suggestList"></div>
							</div>
						</div>


						<div
							class="col-12 mb-3 mb-md-0 col-md-4 order-1 order-md-2 text-center">
							<div class="site-logo">
								<a href="${contextPath}/main/main.do" class="js-logo-clone">BookShop</a>
							</div>
						</div>

						<div class="col-6 col-md-4 order-3 order-md-3 text-right">
							<div class="site-top-icons">
								<ul>
									<c:choose>
										<c:when test="${isLogOn==true and not empty memberInfo }">
											<li><a href="${contextPath}/member/logout.do"
												title="로그아웃"><span class="icon icon-user-times"></span></a></li>
											<li><a href="${contextPath}/mypage/myPageMain.do"
												title="마이페이지"><span class="icon icon-user"></span></a></li>
											<li><a href="${contextPath}/cart/myCartList.do"
												class="site-cart"> <span class="icon icon-shopping_cart"
													title="장바구니"></span> <span class="count">${cartCount}</span>
											</a></li>
											<li><a href="#" title="주문배송"><span
													class="icon icon-local_shipping"></span></a></li>
										</c:when>
										<c:otherwise>
											<li><a href="${contextPath}/member/loginForm.do"
												title="로그인"><span class="icon icon-user"></span></a></li>
											<li><a href="${contextPath}/member/memberForm.do"
												title="회원가입"><span class="icon icon-person_add"></span></a></li>
										</c:otherwise>
									</c:choose>

									<li class="d-inline-block d-md-none ml-md-0"><a href="#"
										class="site-menu-toggle js-menu-toggle"><span
											class="icon icon-menu"></span></a></li>
									<c:if
										test="${isLogOn==true and memberInfo.member_id =='admin' }">
										<li><a
											href="${contextPath}/admin/goods/adminGoodsMain.do"
											title="관리자"> <span class="icon icon-cogs"></span></a></li>
									</c:if>
								</ul>
							</div>
						</div>

					</div>
				</div>
			</div>

			<nav class="site-navigation text-right text-md-center"
				role="navigation">
				<div class="container">
					<ul class="site-menu js-clone-nav d-none d-md-block">
						<li class="has-children"><a
							href="${contextPath}/main/main.do">도서</a>
							<ul class="dropdown">
								<li><a href="#">베스트 셀러</a></li>
								<li><a href="#">스테디 셀러</a></li>
								<li><a href="#">신간</a></li>

							</ul></li>
						<li class="has-children"><a href="about.html">음반</a>
							<ul class="dropdown">
								<li><a href="#">가요</a></li>
								<li><a href="#">록</a></li>
								<li><a href="#">클래식</a></li>
								<li><a href="#">뉴에이지</a></li>
								<li><a href="#">재즈</a></li>
								<li><a href="#">기타</a></li>
							</ul></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">신상품</a></li>
						<li><a href="#">고객센터</a></li>
					</ul>
				</div>
			</nav>
		</header>
</body>
</html>