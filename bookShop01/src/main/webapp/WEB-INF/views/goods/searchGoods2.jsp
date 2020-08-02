<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	//치환 변수 선언합니다.
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<head>
<title>검색 도서 목록 페이지</title>
</head>
<body>
				<div class="col-md-9 order-2">

					<div class="row">
						<div class="col-md-12 mb-5">
							<div class="float-md-left mb-4">
								<h2 class="text-black h5">검색 결과</h2>
							</div>
							<div class="d-flex">
								<div class="dropdown mr-1 ml-md-auto">
									<button type="button"
										class="btn btn-secondary btn-sm dropdown-toggle"
										id="dropdownMenuOffset" data-toggle="dropdown"
										aria-haspopup="true" aria-expanded="false">정렬 방식</button>
									<div class="dropdown-menu" aria-labelledby="dropdownMenuOffset">
										<a class="dropdown-item" href="#">최신</a> <a
											class="dropdown-item" href="#">조회</a> <a
											class="dropdown-item" href="#">가격</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-5">
						<c:forEach var="item" items="${goodsList }">
							<div class="col-sm-6 col-lg-4 mb-4" data-aos="fade-up">
								<div class="block-4 text-center border">
									<figure class="block-4-image">
										<a
											href="${contextPath}/goods/goodsDetailTest.do?goods_id=${item.goods_id}">
											<img
											src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
											alt="Image placeholder" class="img-fluid">
										</a>
									</figure>
									<div class="block-4-text p-4">
										<h3>
											<a
												href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
										</h3>
										<c:set var="goods_pub_date"
											value="${item.goods_published_date }" />
										<c:set var="arr" value="${fn:split(goods_pub_date,' ')}" />
										<p class="mb-0">${item.goods_writer }저
											| ${item.goods_publisher } |
											<c:out value="${arr[0]}" />
										</p>
										<fmt:formatNumber value="${item.goods_price}" type="number"
											var="price" />
										<p class="text-secondaryGoods">${price }원</p>
										<p class="text-dangerGoods font-weight-bold">
											<fmt:formatNumber value="${item.goods_price*0.9}"
												type="number" var="discounted_price" />
											${discounted_price}원
										</p>
										<p class="text-secondaryGoods2">(10% 할인)</p>

									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="row" data-aos="fade-up">
						<div class="col-md-12 text-center">
							<div class="site-block-27">
								<ul>
									<li><a href="#">&lt;</a></li>
									<li class="active"><span>1</span></li>
									<li><a href="#">2</a></li>
									<li><a href="#">3</a></li>
									<li><a href="#">4</a></li>
									<li><a href="#">5</a></li>
									<li><a href="#">&gt;</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>




</body>