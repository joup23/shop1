<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
</head>
<body>
	<div class="col-md-9 order-2">
		<div class="row margin-bottom">
			<div class="col-md-12 mb-5">
				<div class="site-blocks-table">
					<div class="float-md-left mb-4">
						<h2 class="h3 mb-3 text-black">주문 상세 정보</h2>
					</div>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="product-thumbnail">주문 번호</th>
								<th class="product-name">주문 일자</th>
								<th colspan=2 class="product-quantity">주문 상품</th>
								<th class="product-price">수량</th>
								<th class="product-price">주문금액</th>
								<th class="product-price">배송비</th>
								<th class="product-price">예상 적립금</th>
								<th class="product-total">합계 가격</th>
							</tr>
						</thead>
						<c:forEach var="item" items="${myOrderList }">
							<tr>
								<td class="product-name">${item.order_id}</td>
								<td class="product-name">${item.pay_order_time}</td>
								<td class="product-thumbnail"><a
									href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
										<img
										src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
										alt="Image">
								</a></td>
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
										type="number" var="goods_sales_total" /> <input type="hidden"
									id="h_each_goods_price" name="h_each_goods_price"
									value="${goods_sales_price * item.order_goods_qty}" /></td>

							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<div class="row margin-bottom">
			<div class="col-md-12">
				<h2 class="h3 mb-3 text-black">배송지 정보</h2>
				<div class="p-3 p-lg-5 border">


					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">배송 방법 </label>

						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">
								${myOrderList[0].delivery_method }</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">받으실 분</label>

						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${myOrderList[0].receiver_name }</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">휴대폰 번호</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">
								${myOrderList[0].receiver_hp1}-${myOrderList[0].receiver_hp2}-${myOrderList[0].receiver_hp3}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">전화 번호</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${myOrderList[0].receiver_tel1}-${myOrderList[0].receiver_tel2}-${myOrderList[0].receiver_tel3}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">주소</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">
								${myOrderList[0].delivery_address}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">배송 매시지</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${myOrderList[0].delivery_message}</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row margin-bottom">
			<div class="col-md-12">
				<h2 class="h3 mb-3 text-black">주문자 정보</h2>
				<div class="p-3 p-lg-5 border">


					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">이름 </label>

						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">
								${orderer.member_name}</p>
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
				<div class="p-3 p-lg-5 border">


					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">결제 방법 </label>

						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">
								${myOrderList[0].pay_method }</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">결제 카드</label>

						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${myOrderList[0].card_com_name}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">할부 기간</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${myOrderList[0].card_pay_month }</p>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="form-group row">
			<div class="col-md-6 center">
				<a href="${contextPath}/main/main.do"> <input type="button"
					class="btn btn-primary btn-lg btn-block" value="쇼핑 게속하기">
				</a>
			</div>
			<div class="col-md-6 center">
				<a href="javascript:history.back();"><input type="button"
					class="btn btn-outline-danger btn-lg btn-block" value="뒤로가기"></a>
			</div>
		</div>

	</div>
</body>

