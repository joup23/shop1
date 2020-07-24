<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Mukta:300,400,700">
<link rel="stylesheet"
	href="${contextPath}/resources/fonts/icomoon/style.css">

<link rel="stylesheet"
	href="${contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${contextPath}/resources/css/magnific-popup.css">
<link rel="stylesheet" href="${contextPath}/resources/css/jquery-ui.css">
<link rel="stylesheet"
	href="${contextPath}/resources/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="${contextPath}/resources/css/owl.theme.default.min.css">

<link rel="stylesheet" href="${contextPath}/resources/css/aos.css">
<link rel="stylesheet" href="${contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${contextPath}/resources/css/custom.css">

<link href="${contextPath}/resources/css/basic-jquery-slider.css"
	rel="stylesheet" type="text/css" media="screen">
<script src="${contextPath}/resources/jquery/stickysidebar.jquery.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/basic-jquery-slider.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/js/custom.js"
	type="text/javascript"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
	var loopSearch = true;
	function keywordSearch() {
		if (loopSearch == false)
			return;
		var value = document.frmSearch.searchWord.value;
		$.ajax({
			type : "get",
			async : true, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/goods/keywordSearch.do",
			data : {
				keyword : value
			},
			success : function(data, textStatus) {
				var jsonInfo = JSON.parse(data);
				displayResult(jsonInfo);
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다." + data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");

			}
		}); //end ajax	
	}

	function displayResult(jsonInfo) {
		var count = jsonInfo.keyword.length;
		if (count > 0) {
			var html = '';
			for ( var i in jsonInfo.keyword) {
				html += "<a href=\"javascript:select('" + jsonInfo.keyword[i]
						+ "')\">" + jsonInfo.keyword[i] + "</a><br/>";
			}
			var listView = document.getElementById("suggestList");
			listView.innerHTML = html;
			show('suggest');
		} else {
			hide('suggest');
		}
	}

	function select(selectedKeyword) {
		document.frmSearch.searchWord.value = selectedKeyword;
		loopSearch = false;
		hide('suggest');
	}

	function show(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			element.style.display = 'block';
		}
	}

	function hide(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			element.style.display = 'none';
		}
	}
</script>
<script language="JavaScript">
	$(document).ready(
			function() {
				var $banner = $(".banner1").find("ul");

				var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
				var $bannerHeight = $banner.children().outerHeight(); // 높이
				var $length = $banner.children().length;//이미지의 갯수
				var rollingId;

				//정해진 초마다 함수 실행
				rollingId = setInterval(function() {
					rollingStart();
				}, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

				function rollingStart() {
					$banner.css("width", $bannerWidth * $length + "px");
					$banner.css("height", $bannerHeight + "px");
					//alert(bannerHeight);
					//배너의 좌측 위치를 옮겨 준다.
					$banner.animate({
						left : -$bannerWidth + "px"
					}, 1500, function() { //숫자는 롤링 진행되는 시간이다.
						//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
						$(this).append(
								"<li>" + $(this).find("li:first").html()
										+ "</li>");
						//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
						$(this).find("li:first").remove();
						//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
						$(this).css("left", 0);
						//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
					});
				}
			});
</script>
</head>
<body>
	<div class="site-wrap">
		<header class="site-navbar" role="banner">
			<div class="site-navbar-top">
				<div class="container">
					<div class="row align-items-center">

						<div id="search"
							class="col-6 col-md-4 order-2 order-md-1 site-search-icon text-left">
							<form name="frmSearch"
								action="${contextPath}/goods/searchGoods.do"
								class="site-block-top-search">
								<span class="icon icon-search2"></span> <input type="text"
									name="searchWord" onKeyUp="keywordSearch()"
									class="form-control border-0" placeholder="Search">
							</form>
						</div>
						<div id="suggest" class="suggest">
							<div id="suggestList"></div>
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
													title="장바구니"></span> <span class="count">2</span>
											</a></li>
											<li><a href="#" title="마이페이지"><span
													class="icon icon-local_shipping"></span></a></li>
										</c:when>
										<c:otherwise>
											<li><a href="${contextPath}/member/loginForm.do"
												title="로그인"><span class="icon icon-user"></span></a></li>
											<li><a href="${contextPath}/member/memberForm.do"
												title="회원가입"><span class="icon icon-person_add"></span></a></li>
											<li><a href="${contextPath}/cart/myCartList.do"
												class="site-cart"> <span class="icon icon-shopping_cart"
													title="장바구니"></span> <span class="count">2</span>
											</a></li>
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
		<!-- 해더 끝 -->

		<!-- 배너 시작 -->

		<div class="site-blocks-cover1" data-aos="fade">
			<div class="container1"
				style="background-image: url(${contextPath}/resources/images/backgroud.jpg);">
				<div class="banner1">
					<ul class="">
						<li><img
							src="${contextPath}/resources/images/main_banner01.jpg"></li>
						<li><img
							src="${contextPath}/resources/images/main_banner02.jpg"></li>
						<li><img
							src="${contextPath}/resources/images/main_banner03.jpg"></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 배너 끝 -->

		<!-- 메인 시작 -->
		<div class="site-section block-3 site-blocks-2 bg-light">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-md-7 site-section-heading text-center pt-4">
						<h2>베스트 셀러</h2>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="nonloop-block-3 owl-carousel">
							<!-- 시작 -->
							<c:forEach var="item" items="${goodsMap.bestseller }">
								<c:set var="goods_count" value="${goods_count+1 }" />
								<div class="item border">
									<div class="block-4 text-center">
										<figure class="block-4-image">
											<a
												href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
												<img
												src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
												alt="Image placeholder" class="img-fluid1">
											</a>
										</figure>
										<div class="block-4-text p-4">
											<h3>
												<a href="#">${item.goods_title }</a>
											</h3>
											<p class="mb-0">${item.goods_publisher}</p>
											<p class="text-primary font-weight-bold">
												<fmt:formatNumber value="${item.goods_price}" type="number"
													var="goods_price" />
												${goods_price}원
											</p>
										</div>
									</div>
								</div>
							</c:forEach>
							<!-- 끝 -->
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="site-section2 block-3 site-blocks-2 bg-light">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-md-7 site-section-heading text-center pt-4">
						<h2>신 상품</h2>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="nonloop-block-3 owl-carousel">
							<!-- 시작 -->
							<c:forEach var="item" items="${goodsMap.newbook }">
								<c:set var="goods_count" value="${goods_count+1 }" />
								<div class="item border">
									<div class="block-4 text-center">
										<figure class="block-4-image">
											<a
												href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
												<img
												src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
												alt="Image placeholder" class="img-fluid1">
											</a>
										</figure>
										<div class="block-4-text p-4">
											<h3>
												<a href="#">${item.goods_title }</a>
											</h3>
											<p class="mb-0">${item.goods_publisher}</p>
											<p class="text-primary font-weight-bold">
												<fmt:formatNumber value="${item.goods_price}" type="number"
													var="goods_price" />
												${goods_price}원
											</p>
										</div>
									</div>
								</div>
							</c:forEach>
							<!-- 끝 -->
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="site-section block-3 site-blocks-2 bg-light">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-md-7 site-section-heading text-center pt-4">
						<h2>스테디 셀러</h2>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="nonloop-block-3 owl-carousel">
							<!-- 시작 -->
							<c:forEach var="item" items="${goodsMap.steadyseller }">
								<c:set var="goods_count" value="${goods_count+1 }" />
								<div class="item border">
									<div class="block-4 text-center">
										<figure class="block-4-image">
											<a
												href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
												<img
												src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
												alt="Image placeholder" class="img-fluid1">
											</a>
										</figure>
										<div class="block-4-text p-4">
											<h3>
												<a href="#">${item.goods_title }</a>
											</h3>
											<p class="mb-0">${item.goods_publisher}</p>
											<p class="text-primary font-weight-bold">
												<fmt:formatNumber value="${item.goods_price}" type="number"
													var="goods_price" />
												${goods_price}원
											</p>
										</div>
									</div>
								</div>
							</c:forEach>
							<!-- 끝 -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 푸터 시작 -->
		<footer class="site-footer border-top">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 mb-5 mb-lg-0">
						<div class="row">
							<div class="col-md-12">
								<h3 class="footer-heading mb-4">Navigations</h3>
							</div>
							<div class="col-md-6 col-lg-4">
								<ul class="list-unstyled">
									<li><a href="#">Sell online</a></li>
									<li><a href="#">Features</a></li>
									<li><a href="#">Shopping cart</a></li>
									<li><a href="#">Store builder</a></li>
								</ul>
							</div>
							<div class="col-md-6 col-lg-4">
								<ul class="list-unstyled">
									<li><a href="#">Mobile commerce</a></li>
									<li><a href="#">Dropshipping</a></li>
									<li><a href="#">Website development</a></li>
								</ul>
							</div>
							<div class="col-md-6 col-lg-4">
								<ul class="list-unstyled">
									<li><a href="#">Point of sale</a></li>
									<li><a href="#">Hardware</a></li>
									<li><a href="#">Software</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-lg-3">
						<div class="block-5 mb-5">
							<h3 class="footer-heading mb-4">Contact Info</h3>
							<ul class="list-unstyled">
								<li class="address">203 Fake St. Mountain View, San
									Francisco, California, USA</li>
								<li class="phone"><a href="tel://23923929210">+2 392
										3929 210</a></li>
								<li class="email">emailaddress@domain.com</li>
							</ul>
						</div>
					</div>
					<div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
						<form action="#" method="post">
							<label for="email_subscribe" class="footer-heading">Subscribe</label>
							<div class="form-group">
								<input type="text" class="form-control py-4"
									id="email_subscribe" placeholder="Email"> <br/><input
									type="submit" class="btn btn-sm btn-primary" value="Send">
							</div>
						</form>
					</div>

				</div>
				<div class="row pt-5 mt-5 text-center">
					<div class="col-md-12">
						<p>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;
							<script data-cfasync="false"
								src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
							<script>
								document.write(new Date().getFullYear());
							</script>
							All rights reserved | This template is made with <i
								class="icon-heart" aria-hidden="true"></i> by <a
								href="https://colorlib.com" target="_blank" class="text-primary">Colorlib</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						</p>
					</div>

				</div>
			</div>
		</footer>
		<!-- 푸터 -->

		<!-- 메인 끝 -->
		<script src="${contextPath}/resources/js/jquery-3.3.1.min.js"></script>
		<script src="${contextPath}/resources/js/jquery-ui.js"></script>
		<script src="${contextPath}/resources/js/popper.min.js"></script>
		<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
		<script src="${contextPath}/resources/js/owl.carousel.min.js"></script>
		<script src="${contextPath}/resources/js/jquery.magnific-popup.min.js"></script>
		<script src="${contextPath}/resources/js/aos.js"></script>

		<script src="${contextPath}/resources/js/main.js"></script>
	</div>
</body>
</html>
