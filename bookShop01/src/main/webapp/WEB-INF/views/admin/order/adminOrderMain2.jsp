<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta charset="utf-8">
<c:choose>
	<c:when test='${not empty order_goods_list}'>
		<script type="text/javascript">
			window.onload = function() {
				init();
			}

			//화면이 표시되면서  각각의 주문건에 대한 배송 상태를 표시한다.
			function init() {
				var frm_delivery_list = document.frm_delivery_list;
				var h_delivery_state = frm_delivery_list.h_delivery_state;
				var s_delivery_state = frm_delivery_list.s_delivery_state;

				if (h_delivery_state.length == undefined) {
					s_delivery_state.value = h_delivery_state.value; //조회된 주문 정보가 1건인 경우
				} else {
					for (var i = 0; s_delivery_state.length; i++) {
						s_delivery_state[i].value = h_delivery_state[i].value;//조회된 주문 정보가 여러건인 경우
					}
				}
			}
		</script>
	</c:when>
</c:choose>
<script>
	function search_order_history(search_period) {
		temp = calcPeriod(search_period);
		var date = temp.split(",");
		beginDate = date[0];
		endDate = date[1];

		var formObj = document.createElement("form");
		var i_command = document.createElement("input");
		var i_beginDate = document.createElement("input");
		var i_endDate = document.createElement("input");

		i_beginDate.name = "beginDate";
		i_beginDate.value = beginDate;
		i_endDate.name = "endDate";
		i_endDate.value = endDate;

		formObj.appendChild(i_beginDate);
		formObj.appendChild(i_endDate);
		document.body.appendChild(formObj);
		formObj.method = "get";
		formObj.action = "${contextPath}/admin/order/adminOrderMain.do";
		formObj.submit();
	}

	function calcPeriod(search_period) {
		var dt = new Date();
		var beginYear, endYear;
		var beginMonth, endMonth;
		var beginDay, endDay;
		var beginDate, endDate;

		endYear = dt.getFullYear();
		endMonth = dt.getMonth() + 1;
		endDay = dt.getDate();
		if (search_period == 'today') {
			beginYear = endYear;
			beginMonth = endMonth;
			beginDay = endDay;
		} else if (search_period == 'one_week') {
			beginYear = dt.getFullYear();
			beginMonth = dt.getMonth() + 1;
			dt.setDate(endDay - 7);
			beginDay = dt.getDate();

		} else if (search_period == 'two_week') {
			beginYear = dt.getFullYear();
			beginMonth = dt.getMonth() + 1;
			dt.setDate(endDay - 14);
			beginDay = dt.getDate();
		} else if (search_period == 'one_month') {
			beginYear = dt.getFullYear();
			dt.setMonth(endMonth - 1);
			beginMonth = dt.getMonth();
			beginDay = dt.getDate();
		} else if (search_period == 'two_month') {
			beginYear = dt.getFullYear();
			dt.setMonth(endMonth - 2);
			beginMonth = dt.getMonth();
			beginDay = dt.getDate();
		} else if (search_period == 'three_month') {
			beginYear = dt.getFullYear();
			dt.setMonth(endMonth - 3);
			beginMonth = dt.getMonth();
			beginDay = dt.getDate();
		} else if (search_period == 'four_month') {
			beginYear = dt.getFullYear();
			dt.setMonth(endMonth - 4);
			beginMonth = dt.getMonth();
			beginDay = dt.getDate();
		}

		if (beginMonth < 10) {
			beginMonth = '0' + beginMonth;
			if (beginDay < 10) {
				beginDay = '0' + beginDay;
			}
		}
		if (endMonth < 10) {
			endMonth = '0' + endMonth;
			if (endDay < 10) {
				endDay = '0' + endDay;
			}
		}
		endDate = endYear + '-' + endMonth + '-' + endDay;
		beginDate = beginYear + '-' + beginMonth + '-' + beginDay;
		//alert(beginDate+","+endDate);
		return beginDate + "," + endDate;
	}

	function fn_modify_order_state(order_id, select_id) {
		var s_delivery_state = document.getElementById(select_id);
		var index = s_delivery_state.selectedIndex;
		var value = s_delivery_state[index].value;
		//console.log("value: "+value );

		$
				.ajax({
					type : "post",
					async : false,
					url : "${contextPath}/admin/order/modifyDeliveryState.do",
					data : {
						order_id : order_id,
						"delivery_state" : value
					},
					success : function(data, textStatus) {
						if (data.trim() == 'mod_success') {
							alert("주문 정보를 수정했습니다.");
							location.href = "${contextPath}//admin/order/adminOrderMain.do";
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

	function fn_enable_detail_search(r_search) {
		var frm_delivery_list = document.frm_delivery_list;
		t_beginYear = frm_delivery_list.beginYear;
		t_beginMonth = frm_delivery_list.beginMonth;
		t_beginDay = frm_delivery_list.beginDay;
		t_endYear = frm_delivery_list.endYear;
		t_endMonth = frm_delivery_list.endMonth;
		t_endDay = frm_delivery_list.endDay;
		s_search_type = frm_delivery_list.s_search_type;
		t_search_word = frm_delivery_list.t_search_word;
		btn_search = frm_delivery_list.btn_search;

		if (r_search.value == 'detail_search') {
			//alert(r_search.value);
			t_beginYear.disabled = false;
			t_beginMonth.disabled = false;
			t_beginDay.disabled = false;
			t_endYear.disabled = false;
			t_endMonth.disabled = false;
			t_endDay.disabled = false;

			s_search_type.disabled = false;
			t_search_word.disabled = false;
			btn_search.disabled = false;
		} else {
			t_beginYear.disabled = true;
			t_beginMonth.disabled = true;
			t_beginDay.disabled = true;
			t_endYear.disabled = true;
			t_endMonth.disabled = true;
			t_endDay.disabled = true;

			s_search_type.disabled = true;
			t_search_word.disabled = true;
			btn_search.disabled = true;
		}

	}

	function fn_detail_order(order_id) {
		//alert(order_id);
		var frm_delivery_list = document.frm_delivery_list;

		var formObj = document.createElement("form");
		var i_order_id = document.createElement("input");

		i_order_id.name = "order_id";
		i_order_id.value = order_id;

		formObj.appendChild(i_order_id);
		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/admin/order/orderDetail.do";
		formObj.submit();

	}

	//상세조회 버튼 클릭 시 수행
	function fn_detail_search() {
		var frm_delivery_list = document.frm_delivery_list;

		beginYear = frm_delivery_list.beginYear.value;
		beginMonth = frm_delivery_list.beginMonth.value;
		beginDay = frm_delivery_list.beginDay.value;
		endYear = frm_delivery_list.endYear.value;
		endMonth = frm_delivery_list.endMonth.value;
		endDay = frm_delivery_list.endDay.value;
		search_type = frm_delivery_list.s_search_type.value;
		search_word = frm_delivery_list.t_search_word.value;

		var formObj = document.createElement("form");
		var i_command = document.createElement("input");
		var i_beginDate = document.createElement("input");
		var i_endDate = document.createElement("input");
		var i_search_type = document.createElement("input");
		var i_search_word = document.createElement("input");

		//alert("beginYear:"+beginYear);
		//alert("endDay:"+endDay);
		//alert("search_type:"+search_type);
		//alert("search_word:"+search_word);

		i_command.name = "command";
		i_beginDate.name = "beginDate";
		i_endDate.name = "endDate";
		i_search_type.name = "search_type";
		i_search_word.name = "search_word";

		i_command.value = "list_detail_order_goods";
		i_beginDate.value = beginYear + "-" + beginMonth + "-" + beginDay;
		i_endDate.value = endYear + "-" + endMonth + "-" + endDay;
		i_search_type.value = search_type;
		i_search_word.value = search_word;

		formObj.appendChild(i_command);
		formObj.appendChild(i_beginDate);
		formObj.appendChild(i_endDate);
		formObj.appendChild(i_search_type);
		formObj.appendChild(i_search_word);
		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/admin/order/detailOrder.do";
		formObj.submit();
		//alert("submit");

	}
</script>
</head>
<body>
	<div class="col-md-9 order-2">
		<div class="row mb-5">
			<div class="col-md-12">
				<h2 class="h3 mb-3 text-black">주문 조회</h2>
				<div class="site-blocks-table">

					<form method="post">
						<div class="p-3 p-lg-5 border">
							<div class="form-group row">
								<div class="col-md-12">
									<input type="radio" name="r_search_option"
										value="simple_search" checked
										onClick="fn_enable_detail_search(this)" /> 간단조회
									&nbsp;&nbsp;&nbsp; <input type="radio" name="r_search_option"
										onClick="fn_enable_detail_search(this)" /> 상세조회
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<span class="select-holder"> <select name="curYear"
										class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="i" begin="0" end="5">
												<c:choose>
													<c:when test="${endYear==endYear-i }">
														<option value="${endYear}" selected>${endYear}</option>
													</c:when>
													<c:otherwise>
														<option value="${endYear-i }">${endYear-i }</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select>
									</span>년 <span class="select-holder2"> <select name="curMonth"
										class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="i" begin="1" end="12">
												<c:choose>
													<c:when test="${endMonth==i }">
														<option value="${i }" selected>${i }</option>
													</c:when>
													<c:otherwise>
														<option value="${i }">${i }</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select></span>월 <span class="select-holder2"> <select name="curDay"
										class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="i" begin="1" end="31">
												<c:choose>
													<c:when test="${endDay==i }">
														<option value="${i }" selected>${i }</option>
													</c:when>
													<c:otherwise>
														<option value="${i }">${i }</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select></span>일 &nbsp;이전&nbsp;&nbsp;&nbsp;&nbsp;
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<a href="javascript:search_order_history('today')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="당일">
									</a> <a href="javascript:search_order_history('one_week')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="1주">
									</a> <a href="javascript:search_order_history('two_week')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="2주">
									</a> <a href="javascript:search_order_history('one_month')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="1개월">
									</a> <a href="javascript:search_order_history('two_month')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="2개월">
									</a> <a href="javascript:search_order_history('three_month')">
										<input type="button"
										class="btn btn-smCustom btn-secondary no-pad" value="3개월">
									</a> <a href="javascript:search_order_history('four_month')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="4개월">
									</a> &nbsp;까지 조회
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<span class="select-holder4"> <select
										name="s_search_type" class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<option value="all" checked>전체</option>
											<option value="orderer_name">주문자 이름</option>
											<option value="orderer_id">주문자 아이디</option>
											<option value="orderer_hp">주문자 휴대폰 번호</option>
											<option value="orderer_goods">주문 상품 품명</option>
									</select>
									</span> <input type="text" class="form-controlMemberFormInput" /> <input
										type="button" value="조회" name="btn_search"
										onClick="fn_detail_search()"
										class="btn btn-smCustom btn-secondary no-pad" />
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">조회한 기간</div>
								<div class="col-md-12">
									<input type="text" size="4" class="form-controlMypage"
										value="${beginYear}" />년 <input type="text" size="4"
										class="form-controlMypage" value="${beginMonth}" />월 <input
										type="text" size="4" class="form-controlMypage"
										value="${beginDay}" />일 ~ <input type="text" size="4"
										class="form-controlMypage" value="${endYear}" />년 <input
										type="text" size="4" class="form-controlMypage"
										value="${endMonth}" />월 <input type="text" size="4"
										class="form-controlMypage" value="${endDay}" />일
								</div>
							</div>

						</div>
					</form>

					<table class="table table-bordered">
						<thead>
							<tr class="bg-light">
								<th class="product-name">주문 번호</th>
								<th class="product-name">주문 일자</th>
								<th class="product-name">주문 내역</th>
								<th class="product-name">주문 상품</th>
								<th class="product-price">배송 상태</th>
								<th class="product-quantity">배송 수정</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty newOrderList  }">
									<tr>
										<td colspan=7 class="fixed"><p>주문한 상품이 없습니다.</p></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${newOrderList}" varStatus="i">
										<c:choose>
											<c:when test="${item.order_id != pre_order_id }">
												<tr>
													<td><a
														href="javascript:fn_detail_order('${item.order_id}')"><p>${item.order_id}</p>
													</a></td>
													<td><p>${item.pay_order_time }</p></td>
													<td class="text-left"><p>
															주문자:${item.orderer_name}<br> 주문자
															전화번호:${item.orderer_hp}<br>
															수령자:${item.receiver_name}<br> 수령자
															전화번호:${item.receiver_hp1}-${item.receiver_hp2}-${item.receiver_hp3}
														</p></td>
													<td class="text-left">
														<p>${item.goods_title}(${item.order_goods_qty})<br>
														</p> <c:forEach var="item2" items="${newOrderList}"
															varStatus="j">
															<c:if test="${j.index > i.index }">
																<c:if test="${item.order_id ==item2.order_id}">
																	<p>${item2.goods_title}(${item2.order_goods_qty})</p>
																	<br>
																</c:if>
															</c:if>
														</c:forEach>
													</td>

													<td><span class="select-holderWidth"> <c:choose>
																<c:when
																	test="${item.delivery_state=='delivery_prepared' }">
																	<select style="background-color: lightgreen"
																		id="s_delivery_state${i.index }"
																		name="s_delivery_state${i.index }"
																		class="form-controlMemberForm">
																		<option value="delivery_prepared" selected>배송준비중</option>
																		<option value="delivering">배송중</option>
																		<option value="finished_delivering">배송완료</option>
																		<option value="cancel_order">주문취소</option>
																		<option value="returning_goods">반품</option>
																	</select>
																</c:when>
																<c:when test="${item.delivery_state=='delivering' }">
																	<select style="background-color: orange"
																		id="s_delivery_state${i.index }"
																		name="s_delivery_state${i.index }"
																		class="form-controlMemberForm">
																		<option value="delivery_prepared">배송준비중</option>
																		<option value="delivering" selected>배송중</option>
																		<option value="finished_delivering">배송완료</option>
																		<option value="cancel_order">주문취소</option>
																		<option value="returning_goods">반품</option>
																	</select>
																</c:when>
																<c:when
																	test="${item.delivery_state=='finished_delivering' }">
																	<select style="background-color: lightgray"
																		id="s_delivery_state${i.index }"
																		name="s_delivery_state${i.index }"
																		class="form-controlMemberForm">
																		<option value="delivery_prepared">배송준비중</option>
																		<option value="delivering">배송중</option>
																		<option value="finished_delivering" selected>배송완료</option>
																		<option value="cancel_order">주문취소</option>
																		<option value="returning_goods">반품</option>
																	</select>
																</c:when>
																<c:when test="${item.delivery_state=='cancel_order' }">
																	<select style="background-color: #dc3545"
																		id="s_delivery_state${i.index }"
																		name="s_delivery_state${i.index }"
																		class="form-controlMemberForm">
																		<option value="delivery_prepared">배송준비중</option>
																		<option value="delivering">배송중</option>
																		<option value="finished_delivering">배송완료</option>
																		<option value="cancel_order" selected>주문취소</option>
																		<option value="returning_goods">반품</option>
																	</select>
																</c:when>
																<c:when
																	test="${item.delivery_state=='returning_goods' }">
																	<select style="background-color: #dc3545"
																		id="s_delivery_state${i.index }"
																		name="s_delivery_state${i.index }"
																		class="form-controlMemberForm">
																		<option value="delivery_prepared">배송준비중</option>
																		<option value="delivering">배송중</option>
																		<option value="finished_delivering">배송완료</option>
																		<option value="cancel_order">주문취소</option>
																		<option value="returning_goods" selected>반품</option>
																	</select>
																</c:when>
															</c:choose>
													</span></td>

													<td><input type="button" value="배송수정" class="btn btn-smCustom btn-secondary no-pad"
														onClick="fn_modify_order_state('${item.order_id}','s_delivery_state${i.index}')" />
													</td>
												</tr>
												<c:set var="pre_order_id" value="${item.order_id }" />
											</c:when>
										</c:choose>
									</c:forEach>

								</c:otherwise>
							</c:choose>
							<tr>
								<td colspan=8 class="fixed"><c:forEach var="page" begin="1"
										end="10" step="1">
										<c:if test="${section >1 && page==1 }">
											<a
												href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;&nbsp;</a>
										</c:if>
										<a
											href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }
										</a>
										<c:if test="${page ==10 }">
											<a
												href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp;
												next</a>
										</c:if>
									</c:forEach></td>
							</tr>
					</table>

				</div>
				<div class="form-group row">

					<div class="col-md-6 center">
						<form action="${contextPath}/admin/goods/addNewGoodsForm.do">
							<input type="hidden" name="command" value="modify_my_info" /> <input
								type="submit" name="btn_cancel_member"
								class="btn btn-primary btn-lg btn-block" value="상품 등록">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

