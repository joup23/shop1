<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="myCartList" value="${cartMap.myCartList}" />
<c:set var="myGoodsList" value="${cartMap.myGoodsList}" />

<c:set var="totalGoodsNum" value="0" />
<!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="0" />
<!-- 총 배송비 -->
<c:set var="totalDiscountedPrice" value="0" />
<!-- 총 할인금액 -->
<head>
<script type="text/javascript">
	function calcGoodsPrice(bookPrice, obj) {
		var totalPrice, final_total_price, totalNum;
		var goods_qty = document.getElementById("select_goods_qty");
		//alert("총 상품금액"+goods_qty.value);
		var p_totalNum = document.getElementById("p_totalNum");
		var p_totalPrice = document.getElementById("p_totalPrice");
		var p_final_totalPrice = document.getElementById("p_final_totalPrice");
		var h_totalNum = document.getElementById("h_totalNum");
		var h_totalPrice = document.getElementById("h_totalPrice");
		var h_totalDelivery = document.getElementById("h_totalDelivery");
		var h_final_total_price = document.getElementById("h_final_totalPrice");
		if (obj.checked == true) {
			//	alert("체크 했음")

			totalNum = Number(h_totalNum.value) + Number(goods_qty.value);
			//alert("totalNum:"+totalNum);
			totalPrice = Number(h_totalPrice.value)
					+ Number(goods_qty.value * bookPrice);
			//alert("totalPrice:"+totalPrice);
			final_total_price = totalPrice + Number(h_totalDelivery.value);
			//alert("final_total_price:"+final_total_price);

		} else {
			//	alert("h_totalNum.value:"+h_totalNum.value);
			totalNum = Number(h_totalNum.value) - Number(goods_qty.value);
			//	alert("totalNum:"+ totalNum);
			totalPrice = Number(h_totalPrice.value) - Number(goods_qty.value)
					* bookPrice;
			//	alert("totalPrice="+totalPrice);
			final_total_price = totalPrice - Number(h_totalDelivery.value);
			//	alert("final_total_price:"+final_total_price);
		}

		h_totalNum.value = totalNum;

		h_totalPrice.value = totalPrice;
		h_final_total_price.value = final_total_price;

		p_totalNum.innerHTML = totalNum;
		p_totalPrice.innerHTML = totalPrice;
		p_final_totalPrice.innerHTML = final_total_price;
	}

	function modify_cart_qty(goods_id, bookPrice, index) {
		//alert(index);
		var length = document.frm_order_all_cart.cart_goods_qty.length;
		var _cart_goods_qty = 0;
		if (length > 1) { //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
			_cart_goods_qty = document.frm_order_all_cart.cart_goods_qty[index].value;
		} else {
			_cart_goods_qty = document.frm_order_all_cart.cart_goods_qty.value;
		}

		var cart_goods_qty = Number(_cart_goods_qty);
		//alert("cart_goods_qty:"+cart_goods_qty);
		//console.log(cart_goods_qty);
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/modifyCartQty.do",
			data : {
				goods_id : goods_id,
				cart_goods_qty : cart_goods_qty
			},

			success : function(data, textStatus) {
				//alert(data);
				if (data.trim() == 'modify_success') {
					alert("수량을 변경했습니다!!");
				} else {
					alert("다시 시도해 주세요!!");
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

	function delete_cart_goods(cart_id) {
		var cart_id = Number(cart_id);
		var formObj = document.createElement("form");
		var i_cart = document.createElement("input");
		i_cart.name = "cart_id";
		i_cart.value = cart_id;

		formObj.appendChild(i_cart);
		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/cart/removeCartGoods.do";
		formObj.submit();
	}

	function fn_order_each_goods(goods_id, goods_title, goods_sales_price,
			fileName) {
		var total_price, final_total_price, _goods_qty;
		var cart_goods_qty = document.getElementById("cart_goods_qty");

		_order_goods_qty = cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
		var formObj = document.createElement("form");
		var i_goods_id = document.createElement("input");
		var i_goods_title = document.createElement("input");
		var i_goods_sales_price = document.createElement("input");
		var i_fileName = document.createElement("input");
		var i_order_goods_qty = document.createElement("input");

		i_goods_id.name = "goods_id";
		i_goods_title.name = "goods_title";
		i_goods_sales_price.name = "goods_sales_price";
		i_fileName.name = "goods_fileName";
		i_order_goods_qty.name = "order_goods_qty";

		i_goods_id.value = goods_id;
		i_order_goods_qty.value = _order_goods_qty;
		i_goods_title.value = goods_title;
		i_goods_sales_price.value = goods_sales_price;
		i_fileName.value = fileName;

		formObj.appendChild(i_goods_id);
		formObj.appendChild(i_goods_title);
		formObj.appendChild(i_goods_sales_price);
		formObj.appendChild(i_fileName);
		formObj.appendChild(i_order_goods_qty);

		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/order/orderEachGoods.do";
		formObj.submit();
	}

	function fn_order_all_cart_goods() {
		//	alert("모두 주문하기");
		var order_goods_qty;
		var order_goods_id;
		var objForm = document.frm_order_all_cart;
		var cart_goods_qty = objForm.cart_goods_qty;
		var h_order_each_goods_qty = objForm.h_order_each_goods_qty;
		var checked_goods = objForm.checked_goods;
		var length = checked_goods.length;

		//alert(length);
		if (length > 1) {
			for (var i = 0; i < length; i++) {
				if (checked_goods[i].checked == true) {
					order_goods_id = checked_goods[i].value;
					order_goods_qty = cart_goods_qty[i].value;
					cart_goods_qty[i].value = "";
					cart_goods_qty[i].value = order_goods_id + ":"
							+ order_goods_qty;
					//alert(select_goods_qty[i].value);
					console.log(cart_goods_qty[i].value);
				}
			}
		} else {
			order_goods_id = checked_goods.value;
			order_goods_qty = cart_goods_qty.value;
			cart_goods_qty.value = order_goods_id + ":" + order_goods_qty;
			//alert(select_goods_qty.value);
		}

		objForm.method = "post";
		objForm.action = "${contextPath}/order/orderAllCartGoods.do";
		objForm.submit();
	}
</script>
</head>
<body>
	<div class="site-section">
		<div class="container">
			<div class="row mb-5">
				<div class="site-blocks-table">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="product-quantity">구분</th>
								<th class="product-thumbnail">이미지</th>
								<th class="product-name">도서 이름</th>
								<th class="product-price">가격</th>
								<th class="product-quantity">수량</th>
								<th class="product-total">가격</th>
								<th class="product-remove">지우기</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty myCartList }">
									<tr>
										<td colspan=6>장바구니에 상품이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>

									<form name="frm_order_all_cart">
										<c:forEach var="item" items="${myGoodsList }" varStatus="cnt">
											<tr>
												<c:set var="cart_goods_qty"
													value="${myCartList[cnt.count-1].cart_goods_qty}" />
												<c:set var="cart_id"
													value="${myCartList[cnt.count-1].cart_id}" />
												<td><input type="checkbox" name="checked_goods" checked
													value="${item.goods_id }"
													onClick="calcGoodsPrice(${item.goods_sales_price },this)"></td>
												<td class="product-thumbnail"><img
													src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"
													alt="Image" class="img-fluid"></td>
												<td class="product-name">
													<h2 class="h5 text-black">${item.goods_title }</h2>
												</td>
												<td><p class="text-secondaryGoods">
														<fmt:formatNumber value="${item.goods_price }"
															type="number" var="price" />
														${price }원
													</p>
													<p class="text-dangerGoods font-weight-bold">
														<fmt:formatNumber value="${item.goods_sales_price*0.9}"
															type="number" var="discounted_price" />
														${discounted_price}원(10%할인)
													</p></td>
												<td>
													<div class="input-group mb-3 bottom_no_margin text-center"
														style="max-width: 120px;">
														<div class="input-group-prepend">
															<button class="btn btn-outline-primary js-btn-minus"
																type="button">&minus;</button>
														</div>
														<input type="text" class="form-control text-center"
															value="${cart_goods_qty}" placeholder=""
															aria-label="Example text with button addon"
															name="cart_goods_qty" id="cart_goods_qty"
															aria-describedby="button-addon1">
														<!-- 수량에따른 가격변경 할것 -->
														<div class="input-group-append">
															<button class="btn btn-outline-primary js-btn-plus"
																type="button">&plus;</button>
														</div>

													</div> <a
													href="javascript:modify_cart_qty(${item.goods_id },${item.goods_sales_price*0.9 },${cnt.count-1 });"
													class="btn btn-smCustom btn-secondary">수량변경</a>
												</td>
												<td><fmt:formatNumber
														value="${item.goods_sales_price*0.9*cart_goods_qty}"
														type="number" var="total_sales_price" />
													${total_sales_price}원</td>
												<td><a
													href="javascript:delete_cart_goods('${cart_id}');"
													class="btn btn-primary btn-sm">X</a></td>
											</tr>
											<c:set var="totalGoodsPrice"
												value="${totalGoodsPrice+item.goods_sales_price*0.9*cart_goods_qty }" />
											<c:set var="totalGoodsNum"
												value="${totalGoodsNum+cart_goods_qty }" />
										</c:forEach>
								</c:otherwise>
							</c:choose>




						</tbody>
					</table>
				</div>
			</div>

			<div class="row">
				<div class="col-md-6">
					<div class="row mb-5">

						<div class="col-md-6">
							<button class="btn btn-outline-primary btn-sm btn-block">쇼핑
								계속하기</button>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<label class="text-black h4" for="coupon">쿠폰</label>
							<p>쿠폰 번호를 입력해주세요.</p>
						</div>
						<div class="col-md-8 mb-3 mb-md-0">
							<input type="text" class="form-control py-3" id="coupon"
								placeholder="Coupon Code">
						</div>
						<div class="col-md-4">
							<button class="btn btn-primary btn-sm">쿠폰 등록</button>
						</div>
					</div>
				</div>
				<div class="col-md-6 pl-5">
					<div class="row justify-content-end">
						<div class="col-md-7">
							<div class="row">
								<div class="col-md-12 text-right border-bottom mb-5">
									<h3 class="text-black h4 text-uppercase">총 상품금액</h3>
									<input id="h_totalGoodsNum" type="hidden"
										value="${totalGoodsNum}" />
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-md-6">
									<span class="text-black">총 갯수</span>
								</div>
								<div class="col-md-6 text-right">
									<strong class="text-black">${totalGoodsNum}개</strong>
								</div>
							</div>
							<div class="row mb-5">
								<div class="col-md-6">
									<span class="text-black">합계</span>
								</div>
								<div class="col-md-6 text-right">

									<input id="h_totalGoodsNum" type="hidden"
										value="${totalGoodsNum}" />
									<fmt:formatNumber value="${totalGoodsPrice}" type="number"
										var="total_goods_price" />
									${total_goods_price}원 <input id="h_totalGoodsPrice"
										type="hidden" value="${totalGoodsPrice}" /> <input
										id="h_totalDeliveryPrice" type="hidden"
										value="${totalDeliveryPrice}" /> <input
										id="h_totalSalesPrice" type="hidden"
										value="${totalSalesPrice}" /> <strong class="text-black">
										<fmt:formatNumber
											value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}"
											type="number" var="total_price" /> ${total_price}원
									</strong> <input id="h_final_totalPrice" type="hidden"
										value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" />
								</div>
							</div>

							<div class="row">
								<div class="col-md-12">
									<a class="btn btn-primary btn-lg py-3 btn-block"
										href="javascript:fn_order_all_cart_goods()">상품 결제</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
</body>
