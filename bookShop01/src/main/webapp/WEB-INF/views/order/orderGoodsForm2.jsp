<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- 주문자 휴대폰 번호 -->
<c:set var="orderer_hp" value="" />
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0" />
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0" />
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />
<!-- 총 배송비 -->
<c:set var="total_delivery_price" value="0" />

<head>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}
						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('roadAddress').value = fullRoadAddr;
						document.getElementById('jibunAddress').value = data.jibunAddress;
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							//예상되는 도로명 주소에 조합형 주소를 추가한다.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
						} else {
							document.getElementById('guide').innerHTML = '';
						}
					}
				}).open();
	}
	window.onload = function() {
		init();
	}
	function init() {
		var form_order = document.form_order;
		var h_tel1 = form_order.h_tel1;
		var h_hp1 = form_order.h_hp1;
		var tel1 = h_tel1.value;
		var hp1 = h_hp1.value;
		var select_tel1 = form_order.tel1;
		var select_hp1 = form_order.hp1;
		select_tel1.value = tel1;
		select_hp1.value = hp1;
	}
	function reset_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("hp1");
		var e_hp2 = document.getElementById("hp2");
		var e_hp3 = document.getElementById("hp3");
		var e_tel1 = document.getElementById("tel1");
		var e_tel2 = document.getElementById("tel2");
		var e_tel3 = document.getElementById("tel3");
		var e_zipcode = document.getElementById("zipcode");
		var e_roadAddress = document.getElementById("roadAddress");
		var e_jibunAddress = document.getElementById("jibunAddress");
		var e_namujiAddress = document.getElementById("namujiAddress");
		e_receiver_name.value = "";
		e_hp1.value = 0;
		e_hp2.value = "";
		e_hp3.value = "";
		e_tel1.value = "";
		e_tel2.value = "";
		e_tel3.value = "";
		e_zipcode.value = "";
		e_roadAddress.value = "";
		e_jibunAddress.value = "";
		e_namujiAddress.value = "";
	}
	function restore_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("hp1");
		var e_hp2 = document.getElementById("hp2");
		var e_hp3 = document.getElementById("hp3");
		var e_tel1 = document.getElementById("tel1");
		var e_tel2 = document.getElementById("tel2");
		var e_tel3 = document.getElementById("tel3");
		var e_zipcode = document.getElementById("zipcode");
		var e_roadAddress = document.getElementById("roadAddress");
		var e_jibunAddress = document.getElementById("jibunAddress");
		var e_namujiAddress = document.getElementById("namujiAddress");
		var h_receiver_name = document.getElementById("h_receiver_name");
		var h_hp1 = document.getElementById("h_hp1");
		var h_hp2 = document.getElementById("h_hp2");
		var h_hp3 = document.getElementById("h_hp3");
		var h_tel1 = document.getElementById("h_tel1");
		var h_tel2 = document.getElementById("h_tel2");
		var h_tel3 = document.getElementById("h_tel3");
		var h_zipcode = document.getElementById("h_zipcode");
		var h_roadAddress = document.getElementById("h_roadAddress");
		var h_jibunAddress = document.getElementById("h_jibunAddress");
		var h_namujiAddress = document.getElementById("h_namujiAddress");
		//alert(e_receiver_name.value);
		e_receiver_name.value = h_receiver_name.value;
		e_hp1.value = h_hp1.value;
		e_hp2.value = h_hp2.value;
		e_hp3.value = h_hp3.value;
		e_tel1.value = h_tel1.value;
		e_tel2.value = h_tel2.value;
		e_tel3.value = h_tel3.value;
		e_zipcode.value = h_zipcode.value;
		e_roadAddress.value = h_roadAddress.value;
		e_jibunAddress.value = h_jibunAddress.value;
		e_namujiAddress.value = h_namujiAddress.value;
	}
	function fn_pay_phone() {
		var e_card = document.getElementById("tr_pay_card");
		var e_phone = document.getElementById("tr_pay_phone");
		e_card.style.visibility = "hidden";
		e_phone.style.visibility = "visible";
	}
	function fn_pay_card() {
		var e_card = document.getElementById("tr_pay_card");
		var e_phone = document.getElementById("tr_pay_phone");
		e_card.style.visibility = "visible";
		e_phone.style.visibility = "hidden";
	}
	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');
			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}
		else if (type == 'close') {
			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}
	var goods_id = "";
	var goods_title = "";
	var goods_fileName = "";
	var order_goods_qty
	var each_goods_price;
	var total_order_goods_price;
	var total_order_goods_qty;
	var orderer_name
	var receiver_name
	var hp1;
	var hp2;
	var hp3;
	var tel1;
	var tel2;
	var tel3;
	var receiver_hp_num;
	var receiver_tel_num;
	var delivery_address;
	var delivery_message;
	var delivery_method;
	var gift_wrapping;
	var pay_method;
	var card_com_name;
	var card_pay_month;
	var pay_orderer_hp_num;
	function fn_show_order_detail() {
		goods_id = "";
		goods_title = "";
		var frm = document.form_order;
		var h_goods_id = frm.h_goods_id;
		var h_goods_title = frm.h_goods_title;
		var h_goods_fileName = frm.h_goods_fileName;
		var r_delivery_method = frm.delivery_method;
		var h_order_goods_qty = document.getElementById("h_order_goods_qty");
		var h_total_order_goods_qty = document
				.getElementById("h_total_order_goods_qty");
		var h_total_sales_price = document
				.getElementById("h_total_sales_price");
		var h_final_total_Price = document
				.getElementById("h_final_total_Price");
		var h_orderer_name = document.getElementById("h_orderer_name");
		var i_receiver_name = document.getElementById("receiver_name");
		if (h_goods_id.length < 2 || h_goods_id.length == null) {
			goods_id += h_goods_id.value;
		} else {
			for (var i = 0; i < h_goods_id.length; i++) {
				goods_id += h_goods_id[i].value + "<br>";
			}
		}
		if (h_goods_title.length < 2 || h_goods_title.length == null) {
			goods_title += h_goods_title.value;
		} else {
			for (var i = 0; i < h_goods_title.length; i++) {
				goods_title += h_goods_title[i].value + "<br>";
			}
		}
		if (h_goods_fileName.length < 2 || h_goods_fileName.length == null) {
			goods_fileName += h_goods_fileName.value;
		} else {
			for (var i = 0; i < h_goods_fileName.length; i++) {
				goods_fileName += h_goods_fileName[i].value + "<br>";
			}
		}
		total_order_goods_price = h_final_total_Price.value;
		total_order_goods_qty = h_total_order_goods_qty.value;
		for (var i = 0; i < r_delivery_method.length; i++) {
			if (r_delivery_method[i].checked == true) {
				delivery_method = r_delivery_method[i].value
				break;
			}
		}
		var r_gift_wrapping = frm.gift_wrapping;
		for (var i = 0; i < r_gift_wrapping.length; i++) {
			if (r_gift_wrapping[i].checked == true) {
				gift_wrapping = r_gift_wrapping[i].value
				break;
			}
		}
		var r_pay_method = frm.pay_method;
		for (var i = 0; i < r_pay_method.length; i++) {
			if (r_pay_method[i].checked == true) {
				pay_method = r_pay_method[i].value
				if (pay_method == "신용카드") {
					var i_card_com_name = document
							.getElementById("card_com_name");
					var i_card_pay_month = document
							.getElementById("card_pay_month");
					card_com_name = i_card_com_name.value;
					card_pay_month = i_card_pay_month.value;
					pay_method += "<Br>" + "카드사:" + card_com_name + "<br>"
							+ "할부개월수:" + card_pay_month;
					pay_orderer_hp_num = "해당없음";
				} else if (pay_method == "휴대폰결제") {
					var i_pay_order_tel1 = document
							.getElementById("pay_order_tel1");
					var i_pay_order_tel2 = document
							.getElementById("pay_order_tel2");
					var i_pay_order_tel3 = document
							.getElementById("pay_order_tel3");
					pay_orderer_hp_num = i_pay_order_tel1.value + "-"
							+ i_pay_order_tel2.value + "-"
							+ i_pay_order_tel3.value;
					pay_method += "<Br>" + "결제휴대폰번호:" + pay_orderer_hp_num;
					card_com_name = "해당없음";
					card_pay_month = "해당없음";
				} //end if
				break;
			}// end for
		}
		var i_hp1 = document.getElementById("hp1");
		var i_hp2 = document.getElementById("hp2");
		var i_hp3 = document.getElementById("hp3");
		var i_tel1 = document.getElementById("tel1");
		var i_tel2 = document.getElementById("tel2");
		var i_tel3 = document.getElementById("tel3");
		var i_zipcode = document.getElementById("zipcode");
		var i_roadAddress = document.getElementById("roadAddress");
		var i_jibunAddress = document.getElementById("jibunAddress");
		var i_namujiAddress = document.getElementById("namujiAddress");
		var i_delivery_message = document.getElementById("delivery_message");
		var i_pay_method = document.getElementById("pay_method");
		//	alert("총주문 금액:"+total_order_goods_price);
		order_goods_qty = h_order_goods_qty.value;
		//order_total_price=h_order_total_price.value;
		orderer_name = h_orderer_name.value;
		receiver_name = i_receiver_name.value;
		hp1 = i_hp1.value;
		hp2 = i_hp2.value;
		hp3 = i_hp3.value;
		tel1 = i_tel1.value;
		tel2 = i_tel2.value;
		tel3 = i_tel3.value;
		receiver_hp_num = hp1 + "-" + hp2 + "-" + hp3;
		receiver_tel_num = tel1 + "-" + tel2 + "-" + tel3;
		delivery_address = "우편번호:" + i_zipcode.value + "<br>" + "도로명 주소:"
				+ i_roadAddress.value + "<br>" + "[지번 주소:"
				+ i_jibunAddress.value + "]<br>" + i_namujiAddress.value;
		delivery_message = i_delivery_message.value;
		var p_order_goods_id = document.getElementById("p_order_goods_id");
		var p_order_goods_title = document
				.getElementById("p_order_goods_title");
		var p_order_goods_qty = document.getElementById("p_order_goods_qty");
		var p_total_order_goods_qty = document
				.getElementById("p_total_order_goods_qty");
		var p_total_order_goods_price = document
				.getElementById("p_total_order_goods_price");
		var p_orderer_name = document.getElementById("p_orderer_name");
		var p_receiver_name = document.getElementById("p_receiver_name");
		var p_delivery_method = document.getElementById("p_delivery_method");
		var p_receiver_hp_num = document.getElementById("p_receiver_hp_num");
		var p_receiver_tel_num = document.getElementById("p_receiver_tel_num");
		var p_delivery_address = document.getElementById("p_delivery_address");
		var p_delivery_message = document.getElementById("p_delivery_message");
		var p_gift_wrapping = document.getElementById("p_gift_wrapping");
		var p_pay_method = document.getElementById("p_pay_method");
		imagePopup('open');
	}
	function fn_process_pay_order() {
		var formObj = document.createElement("form");
		var i_receiver_name = document.createElement("input");
		var i_receiver_hp1 = document.createElement("input");
		var i_receiver_hp2 = document.createElement("input");
		var i_receiver_hp3 = document.createElement("input");
		var i_receiver_tel1 = document.createElement("input");
		var i_receiver_tel2 = document.createElement("input");
		var i_receiver_tel3 = document.createElement("input");
		var i_delivery_address = document.createElement("input");
		var i_delivery_message = document.createElement("input");
		var i_delivery_method = document.createElement("input");
		var i_gift_wrapping = document.createElement("input");
		var i_pay_method = document.createElement("input");
		var i_card_com_name = document.createElement("input");
		var i_card_pay_month = document.createElement("input");
		var i_pay_orderer_hp_num = document.createElement("input");
		i_receiver_name.name = "receiver_name";
		i_receiver_hp1.name = "receiver_hp1";
		i_receiver_hp2.name = "receiver_hp2";
		i_receiver_hp3.name = "receiver_hp3";
		i_receiver_tel1.name = "receiver_tel1";
		i_receiver_tel2.name = "receiver_tel2";
		i_receiver_tel3.name = "receiver_tel3";
		i_delivery_address.name = "delivery_address";
		i_delivery_message.name = "delivery_message";
		i_delivery_method.name = "delivery_method";
		i_gift_wrapping.name = "gift_wrapping";
		i_pay_method.name = "pay_method";
		i_card_com_name.name = "card_com_name";
		i_card_pay_month.name = "card_pay_month";
		i_pay_orderer_hp_num.name = "pay_orderer_hp_num";
		i_receiver_name.value = receiver_name;
		i_receiver_hp1.value = hp1;
		i_receiver_hp2.value = hp2;
		i_receiver_hp3.value = hp3;
		i_receiver_tel1.value = tel1;
		i_receiver_tel2.value = tel2;
		i_receiver_tel3.value = tel3;
		;
		i_delivery_address.value = delivery_address;
		i_delivery_message.value = delivery_message;
		i_delivery_method.value = delivery_method;
		i_gift_wrapping.value = gift_wrapping;
		i_pay_method.value = pay_method;
		i_card_com_name.value = card_com_name;
		i_card_pay_month.value = card_pay_month;
		i_pay_orderer_hp_num.value = pay_orderer_hp_num;
		formObj.appendChild(i_receiver_name);
		formObj.appendChild(i_receiver_hp1);
		formObj.appendChild(i_receiver_hp2);
		formObj.appendChild(i_receiver_hp3);
		formObj.appendChild(i_receiver_tel1);
		formObj.appendChild(i_receiver_tel2);
		formObj.appendChild(i_receiver_tel3);
		formObj.appendChild(i_delivery_address);
		formObj.appendChild(i_delivery_message);
		formObj.appendChild(i_delivery_method);
		formObj.appendChild(i_gift_wrapping);
		formObj.appendChild(i_pay_method);
		formObj.appendChild(i_card_com_name);
		formObj.appendChild(i_card_pay_month);
		formObj.appendChild(i_pay_orderer_hp_num);
		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/order/payToOrderGoods.do";
		formObj.submit();
		imagePopup('close');
	}
</script>
</head>
<body>

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
									<c:set var="final_total_order_price"
										value="${final_total_order_price+ goods_sales_price* item.order_goods_qty}" />
									<c:set var="total_order_price"
										value="${total_order_price+ item.goods_sales_price* item.order_goods_qty}" />
									<c:set var="total_order_goods_qty"
										value="${total_order_goods_qty+item.order_goods_qty }" />
									<c:set var="total_order_sales_price"
										value="${total_order_sales_price+goods_sales_total_price}" />
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
								<input type="radio" id="delivery_method" name="delivery_method"
									value="일반택배" checked>일반택배 &nbsp;&nbsp;&nbsp; <input
									type="radio" id="delivery_method" name="delivery_method"
									value="편의점택배">편의점택배 &nbsp;&nbsp;&nbsp; <input
									type="radio" id="delivery_method" name="delivery_method"
									value="해외배송">해외배송 &nbsp;&nbsp;&nbsp;
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_email" class="text-black">배송지 선택</label>

							</div>
							<div class="col-md-12">
								<input type="radio" name="delivery_place"
									onClick="restore_all()" value="기본배송지" checked>기본배송지
								&nbsp;&nbsp;&nbsp; <input type="radio" name="delivery_place"
									value="새로입력" onClick="reset_all()">새로입력
								&nbsp;&nbsp;&nbsp; <input type="radio" name="delivery_place"
									value="최근배송지">최근배송지 &nbsp;&nbsp;&nbsp;
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_email" class="text-black">받으실 분 </label> <input
									class="form-controlMemberId" id="receiver_name"
									name="receiver_name" type="text" size="40"
									value="${orderer.member_name }" /> <input
									class="form-controlMemberId" type="hidden" id="h_orderer_name"
									name="h_orderer_name" value="${orderer.member_name }" /> <input
									class="form-controlMemberId" type="hidden" id="h_receiver_name"
									name="h_receiver_name" value="${orderer.member_name }" />
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_message" class="text-black">휴대폰 번호</label>
							</div>
							<div class="col-md-12">
								<span class="select-holder"> <select name="hp1" id="hp1"
									class="form-controlMemberForm select1"
									onmousedown="if(this.options.length>6){this.size=6;}"
									onchange='this.size=0;' onblur="this.size=0;">
										<option>없음</option>
										<option selected value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
								</select>
								</span> - <input size="10px" type="text" name="hp2"
									class="form-controlMemberFormInput" value="${orderer.hp2 }"
									id="hp2"> - <input size="10px" type="text" name="hp3"
									value="${orderer.hp3 }" id="hp3"
									class="form-controlMemberFormInput"> <input
									type="hidden" id="h_hp1" name="h_hp1" value="${orderer.hp1 }" />
								<input type="hidden" id="h_hp2" name="h_hp2"
									value="${orderer.hp2 }" /> <input type="hidden" id="h_hp3"
									name="h_hp3" value="${orderer.hp3 }" />
								<c:set var="orderer_hp"
									value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3 }" />
							</div>
						</div>

						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_message" class="text-black">전화번호 </label>
							</div>
							<div class="col-md-12">
								<span class="select-holder"> <select name="tel1"
									id="tel1" class="form-controlMemberForm select2"
									onmousedown="if(this.options.length>6){this.size=6;}"
									onchange='this.size=0;' onblur="this.size=0;">
										<option>없음</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="0502">0502</option>
										<option value="0503">0503</option>
										<option value="0505">0505</option>
										<option value="0506">0506</option>
										<option value="0507">0507</option>
										<option value="0508">0508</option>
										<option value="070">070</option>
								</select>
								</span> - <input size="10px" type="text" id="tel2" name="tel2"
									value="${orderer.tel2 }" class="form-controlMemberFormInput">
								- <input size="10px" type="text" id="tel3" name="tel3"
									value="${orderer.tel3 }" class="form-controlMemberFormInput">
								<input type="hidden" id="h_tel1" name="h_tel1"
									value="${orderer.tel1 }" /> <input type="hidden" id="h_tel2"
									name="h_tel2" value="${orderer.tel2 }" /> <input type="hidden"
									id="h_tel3" name="h_tel3" value="${orderer.tel3 }" />
							</div>
						</div>

						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_address" class="text-black">주소</label>
							</div>
							<div class="col-md-8">
								<input type="text" class="form-controlAddress" id="zipcode"
									name="zipcode" placeholder="우편번호" value="${orderer.zipcode }">
								<a href="javascript:execDaumPostcode()"> <input
									type="button" class="btn btn-smCustom btn-secondary"
									value="주소 찾기"></a>
							</div>
						</div>

						<div class="form-group">
							<input type="text" class="form-control" id="roadAddress"
								name="roadAddress" placeholder="도로명 주소"
								value="${orderer.roadAddress }">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" id="jibunAddress"
								name="jibunAddress" placeholder="지번 주소"
								value="${orderer.jibunAddress }">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="namujiAddress"
								id="namujiAddress" placeholder="상세 주소"
								value="${orderer.namujiAddress }">
						</div>
						<input type="hidden" id="h_zipcode" name="h_zipcode"
							value="${orderer.zipcode }" /> <input type="hidden"
							id="h_roadAddress" name="h_roadAddress"
							value="${orderer.roadAddress }" /> <input type="hidden"
							id="h_jibunAddress" name="h_jibunAddress"
							value="${orderer.jibunAddress }" /> <input type="hidden"
							id="h_namujiAddress" name="h_namujiAddress"
							value="${orderer.namujiAddress }" />

						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_email" class="text-black">배송 매시지 </label> <input
									id="delivery_message" name="delivery_message" type="text"
									size="50" placeholder="택배 기사님께 전달할 메시지를 남겨주세요."
									class="form-controlMemberId" />
							</div>
						</div>
						<input type="hidden" id="gift_wrapping" name="gift_wrapping"
							value="yes">
					</div>
				</div>
			</div>
			<div class="row margin-bottom">
				<div class="col-md-12">
					<h2 class="h3 mb-3 text-black">주문 고객</h2>
				</div>
				<div class="col-md-72">
					<div class="p-3 p-lg-5 border">
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_fname" class="text-black">이름 </label> <input
									type="text" class="form-controlMemberId" name="member_name"
									value="${orderer.member_name}">
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_message" class="text-black">휴대폰 번호 </label> <input
									class="form-controlMemberId" type="text"
									value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15" />
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_message" class="text-black">EMAIL </label>
							</div>
							<div class="col-md-12">
								<input size="10px" type="text" name="email1"
									class="form-controlMemberFormInput" value="${orderer.email1}">
								@ <input size="10px" type="text" name="email2"
									class="form-controlMemberFormInput" value="${orderer.email2}">
								<span class="select-holder"> <select name="email2"
									class="form-controlMemberForm select2"
									onmousedown="if(this.options.length>6){this.size=6;}"
									onchange='this.size=0;' onblur="this.size=0;">
										<option value="non">직접입력</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="naver.com">naver.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="paran.com">paran.com</option>
										<option value="nate.com">nate.com</option>
										<option value="google.com">google.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="empal.com">empal.com</option>
										<option value="korea.com">korea.com</option>
										<option value="freechal.com">freechal.com</option>
								</select>
								</span>

							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- <H1>3.할인 정보</H1>
				<div class="detail_table">
					<table>
						<tbody>
							<tr class="dot_line">
								<td width=100>적립금</td>
								<td><input name="discount_juklip" type="text" size="10" />원/1000원
									&nbsp;&nbsp;&nbsp; <input type="checkbox" /> 모두 사용하기</td>
							</tr>
							<tr class="dot_line">
								<td>예치금</td>
								<td><input name="discount_yechi" type="text" size="10" />원/1000원
									&nbsp;&nbsp;&nbsp; <input type="checkbox" /> 모두 사용하기</td>
							</tr>
							<tr class="dot_line">
								<td>상품권 전환금</td>
								<td cellpadding="5"><input name="discount_sangpum"
									type="text" size="10" />원/0원 &nbsp;&nbsp;&nbsp; <input
									type="checkbox" /> 모두 사용하기</td>
							</tr>
							<tr class="dot_line">
								<td>OK 캐쉬백 포인트</td>
								<td cellpadding="5"><input name="discount_okcashbag"
									type="text" size="10" />원/0원 &nbsp;&nbsp;&nbsp; <input
									type="checkbox" /> 모두 사용하기</td>
							</tr>
							<tr class="dot_line">
								<td>쿠폰할인</td>
								<td cellpadding="5"><input name="discount_coupon"
									type="text" size="10" />원/0원 &nbsp;&nbsp;&nbsp; <input
									type="checkbox" /> 모두 사용하기</td>
							</tr>
						</tbody>
					</table>
				</div> -->

			<div class="row margin-bottom">
				<div class="col-md-12">
					<h2 class="h3 mb-3 text-black">주문 합계</h2>
				</div>
				<div class="col-md-72">
					<div class="p-3 p-lg-5 border">
						<table class="table site-block-order-table mb-5 bottom_no_margin">
							<thead>
								<th class="product-name">총 상품 수</th>
								<th class="product-name">총 상품 금액</th>
								<th class="product-name">총 배송비</th>
								<th class="product-name">총 할인 금액</th>
								<th class="product-name">최종 결제금액</th>
							</thead>
							<tbody>
								<tr>
									<td>
										<h2 class="h5 text-black">${total_order_goods_qty}개</h2> <input
										id="h_total_order_goods_qty" type="hidden"
										value="${total_order_goods_qty}" />
									</td>
									<td><fmt:formatNumber var="tot_or_pr"
											value="${total_order_price}" />
										<h2 class="h5 text-black">${tot_or_pr}원</h2> <input
										id="h_totalPrice" type="hidden" value="${total_order_price}" />
									</td>
									<td>
										<h2 class="h5 text-black">${total_delivery_price }원</h2> <input
										id="h_totalDelivery" type="hidden"
										value="${total_delivery_price}" />
									</td>
									<td><fmt:formatNumber var="tot_ord_dis_price"
											value="${total_order_sales_price }" />
										<h2 class="h5 text-black text-dangerGoods">${tot_ord_dis_price }원</h2>
										<input id="h_total_sales_price" type="hidden"
										value="${total_order_sales_price}" /></td>

									<td><fmt:formatNumber var="final_tot_ord_pr"
											value="${final_total_order_price }" />
										<h2 class="h5 text-black font-weight-bold">${final_tot_ord_pr }원</h2>
										<input id="h_final_total_Price" type="hidden"
										value="${final_total_order_price}" /></td>
								</tr>
							</tbody>
						</table>

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
								<label for="c_email" class="text-black">결제 방법</label>
							</div>
							<div class="col-md-12 border-top">
								<input type="radio" id="pay_method" name="pay_method"
									value="신용카드" onClick="fn_pay_card()" checked>신용카드
								&nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
									name="pay_method" value="제휴 신용카드">제휴 신용카드
								&nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
									name="pay_method" value="실시간 계좌이체">실시간 계좌이체
								&nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
									name="pay_method" value="무통장 입금">무통장 입금
								&nbsp;&nbsp;&nbsp;
							</div>
							<div class="col-md-12 border-top">
								<input type="radio" id="pay_method" name="pay_method"
									value="휴대폰결제" onClick="fn_pay_phone()">휴대폰 결제
								&nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
									name="pay_method" value="카카오페이(간편결제)">카카오페이(간편결제)
								&nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
									name="pay_method" value="페이나우(간편결제)">페이나우(간편결제)
								&nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
									name="pay_method" value="페이코(간편결제)">페이코(간편결제)
								&nbsp;&nbsp;&nbsp;
							</div>
							<div class="col-md-12 border-top-bottom">
								<input type="radio" id="pay_method" name="pay_method"
									value="직접입금">직접입금&nbsp;&nbsp;&nbsp;
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_message" class="text-black">카드 선택 </label>
							</div>
							<div class="col-md-12">
								<span class="select-holder"> <select name="card_com_name"
									id="card_com_name" class="form-controlMemberForm select1"
									onmousedown="if(this.options.length>6){this.size=6;}"
									onchange='this.size=0;' onblur="this.size=0;">
										<option value="삼성" selected>삼성</option>
										<option value="하나SK">하나SK</option>
										<option value="현대">현대</option>
										<option value="KB">KB</option>
										<option value="신한">신한</option>
										<option value="롯데">롯데</option>
										<option value="BC">BC</option>
										<option value="시티">시티</option>
										<option value="NH농협">NH농협</option>
								</select>
								</span>

							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_message" class="text-black">할부 기간 </label>
							</div>
							<div class="col-md-12">
								<span class="select-holder"> <select id="card_pay_month"
									name="card_pay_month" class="form-controlMemberForm select2"
									onmousedown="if(this.options.length>4){this.size=4;}"
									onchange='this.size=0;' onblur="this.size=0;">
										<option value="일시불" selected>일시불</option>
										<option value="2개월">2개월</option>
										<option value="3개월">3개월</option>
										<option value="4개월">4개월</option>
										<option value="5개월">5개월</option>
										<option value="6개월">6개월</option>
								</select>
								</span>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_message" class="text-black">휴대전화 </label>
							</div>
							<div class="col-md-12">
								<span class="select-holder"> <select id="pay_order_tel1"
									name="pay_order_tel1" class="form-controlMemberForm select3"
									onmousedown="if(this.options.length>6){this.size=6;}"
									onchange='this.size=0;' onblur="this.size=0;">
										<option>없음</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="0502">0502</option>
										<option value="0503">0503</option>
										<option value="0505">0505</option>
										<option value="0506">0506</option>
										<option value="0507">0507</option>
										<option value="0508">0508</option>
										<option value="070">070</option>
								</select>
								</span> - <input size="10px" type="text" id="pay_order_tel2"
									name="pay_order_tel2" class="form-controlMemberFormInput">
								- <input size="10px" type="text" id="pay_order_tel3"
									name="pay_order_tel3" class="form-controlMemberFormInput">

							</div>
						</div>
					</div>

				</div>

			</div>
			<div class="form-group row">
				<div class="col-md-6">
					<a href="javascript:fn_show_order_detail();"> <input
						type="button" class="btn btn-primary btn-lg btn-block"
						value="결제하기">
					</a>
				</div>

				<div class="col-md-6">
					<a href="${contextPath}/main/main.do"><input type="button"
						class="btn btn-outline-danger btn-lg btn-block" value="취소하기"></a>
				</div>
			</div>

			</form>
		</div>
	</div>
	<!-- 이거 수정해야함 -->
	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
			<div id="popup_order_detail">
				<!-- 팝업창 닫기 버튼 -->
				<a href="javascript:"
					onClick="javascript:imagePopup('close', '.layer01');"> <img
					src="${contextPath}/resources/image/close.png" id="close" />
				</a> <br />
				<div class="detail_table margin-bottom">
					<h1 class="order_final_Text">최종 결제 확인</h1>
					<input class="btn btn-sm btn-primary" name="btn_process_pay_order"
						type="button" onClick="fn_process_pay_order()" value="최종결제하기">
					</td>

				</div>
			</div>
		</div>
</body>