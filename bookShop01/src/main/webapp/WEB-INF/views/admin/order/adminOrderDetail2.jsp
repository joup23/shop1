<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="orderList" value="${orderMap.orderList}" />
<c:set var="deliveryInfo" value="${orderMap.deliveryInfo}" />
<c:set var="orderer" value="${orderMap.orderer}" />

<script type="text/javascript">
	function fn_modify_order_state(order_id) {
		var s_delivery_state = document.getElementById("s_delivery_state");
		var index = s_delivery_state.selectedIndex; //선택한 옵션의 인덱스를 구합니다.
		var value = s_delivery_state[index].value; //선택한 옵션의 값을 구합니다.
		console.log("value: " + value);
		$
				.ajax({
					type : "post",
					async : false, //false인 경우 동기식으로 처리한다.
					url : "${contextPath}/admin/order/modifyDeliveryState.do",
					data : {
						order_id : order_id,
						'delivery_state' : value
					},
					success : function(data, textStatus) {
						if (data.trim() == 'mod_success') {
							alert("주문 정보를 수정했습니다.");
							location.href = "${contextPath}/admin/order/orderDetail.do?order_id="
									+ order_id;
						} else if (data.trim() == 'failed') {
							alert("다시 시도해 주세요.");
						}

					},
					error : function(data, textStatus) {
						alert("에러가 발생했습니다." + data);
					},
					complete : function(data, textStatus) {
						//alert("작업을완료 했습니다");

					}
				}); //end ajax		
	}
</script>
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
								<th colspan=2 class="product-quantity">주문 상품</th>
								<th class="product-price">수량</th>
								<th class="product-price">주문금액</th>
								<th class="product-price">배송비</th>
								<th class="product-price">예상 적립금</th>
								<th class="product-total">합계 가격</th>
							</tr>
						</thead>
						<c:forEach var="item" items="${orderList }">
							<tr>
								<td class="product-name">${item.order_id}</td>
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
								${deliveryInfo.delivery_method }</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">받으실 분</label>

						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${deliveryInfo.receiver_name }</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">휴대폰 번호</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">
								${deliveryInfo.receiver_hp1}-${deliveryInfo.receiver_hp2}-${deliveryInfo.receiver_hp3}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">전화 번호</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${deliveryInfo.receiver_tel1}-${deliveryInfo.receiver_tel2}-${deliveryInfo.receiver_tel3}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">주소</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">
								${deliveryInfo.delivery_address}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">배송 매시지</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${deliveryInfo.delivery_message}</p>
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
								${deliveryInfo.pay_method }</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">결제 카드</label>

						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${deliveryInfo.card_com_name}</p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="c_email" class="text-black">할부 기간</label>
						</div>
						<div class="col-md-12">
							<p class="font-weight-bold text-black">${deliveryInfo.card_pay_month }</p>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="row margin-bottom">
			<div class="col-md-12">
			<form name="frm_delivery_list" >
				<h2 class="h3 mb-3 text-black">배송 상태</h2>
				<div class="p-3 p-lg-5 border">


					<div class="form-group row">
						<div class="col-md-12">
							<span class="select-holderWidth"> <c:choose>
									<c:when
										test="${deliveryInfo.delivery_state=='delivery_prepared' }">
										<select style="background-color: lightgreen"
											id="s_delivery_state" name="s_delivery_state"
											class="form-controlMemberForm">
											<option value="delivery_prepared" selected>배송준비중</option>
											<option value="delivering">배송중</option>
											<option value="finished_delivering">배송완료</option>
											<option value="cancel_order">주문취소</option>
											<option value="returning_goods">반품</option>
										</select>
									</c:when>
									<c:when test="${deliveryInfo.delivery_state=='delivering' }">
										<select style="background-color: orange"
											id="s_delivery_state"
											name="s_delivery_state"
											class="form-controlMemberForm">
											<option value="delivery_prepared">배송준비중</option>
											<option value="delivering" selected>배송중</option>
											<option value="finished_delivering">배송완료</option>
											<option value="cancel_order">주문취소</option>
											<option value="returning_goods">반품</option>
										</select>
									</c:when>
									<c:when
										test="${deliveryInfo.delivery_state=='finished_delivering' }">
										<select style="background-color: lightgray"
											id="s_delivery_state"
											name="s_delivery_state"
											class="form-controlMemberForm">
											<option value="delivery_prepared">배송준비중</option>
											<option value="delivering">배송중</option>
											<option value="finished_delivering" selected>배송완료</option>
											<option value="cancel_order">주문취소</option>
											<option value="returning_goods">반품</option>
										</select>
									</c:when>
									<c:when test="${deliveryInfo.delivery_state=='cancel_order' }">
										<select style="background-color: #dc3545"
											id="s_delivery_state"
											name="s_delivery_state"
											class="form-controlMemberForm">
											<option value="delivery_prepared">배송준비중</option>
											<option value="delivering">배송중</option>
											<option value="finished_delivering">배송완료</option>
											<option value="cancel_order" selected>주문취소</option>
											<option value="returning_goods">반품</option>
										</select>
									</c:when>
									<c:when
										test="${deliveryInfo.delivery_state=='returning_goods' }">
										<select style="background-color: #dc3545"
											id="s_delivery_state"
											name="s_delivery_state"
											class="form-controlMemberForm">
											<option value="delivery_prepared">배송준비중</option>
											<option value="delivering">배송중</option>
											<option value="finished_delivering">배송완료</option>
											<option value="cancel_order">주문취소</option>
											<option value="returning_goods" selected>반품</option>
										</select>
									</c:when>
								</c:choose>
							</span> <input type="hidden" name="h_delivery_state"
								value="${deliveryInfo.delivery_state }" />

						</div>

					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<input type="button" value="배송수정" class="btn btn-smCustom btn-secondary no-pad"
								onClick="fn_modify_order_state('${deliveryInfo.order_id}')" />
						</div>
					</div>
				</div>
				</form>
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