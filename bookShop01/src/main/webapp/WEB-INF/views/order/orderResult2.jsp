<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
</head>
<BODY>
	<div class="site-section">
		<div class="container">
			<div class="row mb-5">
				<div class="site-blocks-table">
					<h2 class="h3 mb-3 text-black">주문확인</h2>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="product-thumbnail">이미지</th>
								<th class="product-name">도서 이름</th>
								<th class="product-price">수량</th>
								<th class="product-quantity">삼품 가격</th>
								<th class="product-price">배송비</th>
								<th class="product-price">예상 적립금</th>
								<th class="product-total">합계 가격</th>
							</tr>
						</thead>
						<tbody>

							<form name="form_order">
								<c:forEach var="item" items="${myOrderList }">
									<tr>

										<td class="product-thumbnail"><img
											src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
											alt="Image" class="img-fluid"> <input type="hidden"
											id="h_goods_id" name="h_goods_id" value="${item.goods_id }" />
											<input type="hidden" id="h_goods_fileName"
											name="h_goods_fileName" value="${item.goods_fileName }" /></td>
										<td class="product-name">
											<h2 class="h5 text-black">${item.goods_title }</h2> <input
											type="hidden" id="h_goods_title" name="h_goods_title"
											value="${item.goods_title }" />
										</td>
										<td><p>
												${item.order_goods_qty }개 <input type="hidden"
													id="h_order_goods_qty" name="h_order_goods_qty"
													value="${item.order_goods_qty}" />
											</p></td>
										<td>
											<p class="text-secondaryGoods">
												<fmt:formatNumber value="${item.goods_sales_price }"
													type="number" var="price" />
												${price }원
											</p>
											<p class="text-dangerGoods font-weight-bold">
												<c:set var="goods_sales_price"
													value="${item.goods_sales_price*0.9}" />
												<fmt:formatNumber value="${goods_sales_price}" type="number"
													var="discounted_price" />
												${discounted_price}원(10%할인)
											</p>
										</td>
										<td>
											<p>0원</p>
										</td>
										<td>${1500 *item.order_goods_qty}원</td>
										<td><fmt:formatNumber
												value="${goods_sales_price * item.order_goods_qty}"
												type="number" var="total_sales_price" />
											<p class="font-weight-bold">${total_sales_price}원</p> <c:set
												var="goods_sales_total_price"
												value="${(item.goods_sales_price*item.order_goods_qty)-(goods_sales_price*item.order_goods_qty)}" />
											<fmt:formatNumber value="${goods_sales_total_price}"
												type="number" var="goods_sales_total" /> <input
											type="hidden" id="h_each_goods_price"
											name="h_each_goods_price"
											value="${goods_sales_price * item.order_goods_qty}" /></td>

									</tr>
								</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
				<div class="row margin-bottom">
					<div class="col-md-12">
						<h2 class="h3 mb-3 text-black">배송지 정보</h2>
					</div>
					<div class="col-md-72">
						<div class="p-3 p-lg-5 border">
	
	
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">배송 방법 </label>
	
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black"> ${myOrderInfo.delivery_method }</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">받으실 분</label>
	
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${myOrderInfo.receiver_name }</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">휴대폰 번호</label>
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${myOrderInfo.receiver_hp1}-${myOrderInfo.receiver_hp2}-${myOrderInfo.receiver_hp3}</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">전화 번호</label>
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${myOrderInfo.receiver_tel1}-${myOrderInfo.receiver_tel2}-${myOrderInfo.receiver_tel3}</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">주소</label>
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${myOrderInfo.delivery_address}</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">배송 매시지</label>
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${myOrderInfo.delivery_message}</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row margin-bottom">
					<div class="col-md-12">
						<h2 class="h3 mb-3 text-black">주문자 정보</h2>
					</div>
					<div class="col-md-72">
						<div class="p-3 p-lg-5 border">
	
	
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">이름 </label>
	
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black"> ${orderer.member_name}</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">핸드폰</label>
	
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${orderer.hp1}-${orderer.hp2}-${orderer.hp3}</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">이메일</label>
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${orderer.email1}@${orderer.email2}</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row margin-bottom">
					<div class="col-md-12">
						<h2 class="h3 mb-3 text-black">결제 정보</h2>
					</div>
					<div class="col-md-72">
						<div class="p-3 p-lg-5 border">
	
	
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_email" class="text-black">결제 방법 </label>

							</div>
							<div class="col-md-12">
								<p class="font-weight-bold text-black"> ${myOrderInfo.pay_method }</p>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_email" class="text-black">결제 카드</label>

							</div>
							<div class="col-md-12">
								<p class="font-weight-bold text-black">${myOrderInfo.card_com_name}</p>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_email" class="text-black">할부 기간</label>
							</div>
							<div class="col-md-12">
								<p class="font-weight-bold text-black">${myOrderInfo.card_pay_month }</p>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-md-6 center">
					<a href="${contextPath}/main/main.do"> <input
						type="button" class="btn btn-primary btn-lg btn-block"
						value="쇼핑 게속하기">
					</a>
				</div>
			</div>
		</div>
	</div>
</BODY>