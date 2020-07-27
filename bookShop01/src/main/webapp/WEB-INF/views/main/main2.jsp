<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"	isELIgnored="false"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
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

<div class="site-section block-3 site-blocks-2 bg-light">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-7 site-section-heading text-center pt-4">
				<h2>베스트 셀러test입니다.</h2>
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
   
   