<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script>
	function search_order_history(fixedSearchPeriod) {
		var formObj = document.createElement("form");
		var i_fixedSearch_period = document.createElement("input");
		i_fixedSearch_period.name = "fixedSearchPeriod";
		i_fixedSearch_period.value = fixedSearchPeriod;
		formObj.appendChild(i_fixedSearch_period);
		document.body.appendChild(formObj);
		formObj.method = "get";
		formObj.action = "${contextPath}/mypage/listMyOrderHistory.do";
		formObj.submit();
	}

	function fn_cancel_order(order_id) {
		var answer = confirm("주문을 취소하시겠습니까?");
		if (answer == true) {
			var formObj = document.createElement("form");
			var i_order_id = document.createElement("input");

			i_order_id.name = "order_id";
			i_order_id.value = order_id;

			formObj.appendChild(i_order_id);
			document.body.appendChild(formObj);
			formObj.method = "post";
			formObj.action = "${contextPath}/mypage/cancelMyOrder.do";
			formObj.submit();
		}
	}
</script>
</head>
<body>
	<div class="col-md-9 order-2">
		<div class="row mb-5">
			<div class="col-md-12">
				<h2 class="h3 mb-3 text-black">주문 배송 내역</h2>
				<div class="site-blocks-table">

					<form method="post">
						<div class="p-3 p-lg-5 border">
							<div class="form-group row">
								<div class="col-md-12">
									<input type="radio" name="simple" checked /> 간단조회
									&nbsp;&nbsp;&nbsp; <input type="radio" name="simple" /> 일간
									&nbsp;&nbsp;&nbsp; <input type="radio" name="simple" /> 월간
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
									<span class="select-holder3"> <select
										name="search_condition" class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<option value="2015" checked>전체</option>
											<option value="2014">수령자</option>
											<option value="2013">주문자</option>
											<option value="2012">주문번호</option>
									</select>
									</span> <input type="text" class="form-controlMemberFormInput" /> <input
										type="button" value="조회"
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
							<tr>
								<th class="product-name">주문 번호</th>
								<th class="product-name">주문 일자</th>
								<th class="product-name">주문 내역</th>
								<th class="product-price">주문 금액/수량</th>
								<th class="product-quantity">주문 상태</th>
								<th class="product-name">주문자</th>
								<th class="product-name">수령자</th>
								<th class="product-price">주문 취소</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty myOrderHistList  }">
									<tr>
										<td colspan=5 class="fixed"><strong>주문한 상품이
												없습니다.</strong></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${myOrderHistList }" varStatus="i">
										<c:choose>
											<c:when test="${ pre_order_id != item.order_id}">
												<tr>
													<td><a
														href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><strong>${item.order_id }</strong>
													</a></td>
													<td><strong>${item.pay_order_time }</strong></td>
													<td><strong> <c:forEach var="item2"
																items="${myOrderHistList}" varStatus="j">
																<c:if test="${item.order_id ==item2.order_id}">
																	<p>
																	<a
																		href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }</a>
																	</p>
																</c:if>
															</c:forEach>
													</strong></td>
													<td><strong> <c:forEach var="item2"
																items="${myOrderHistList}" varStatus="j">
																<c:if test="${item.order_id ==item2.order_id}">
				             ${item.goods_sales_price*item.order_goods_qty }원/${item.order_goods_qty }<br>
																</c:if>
															</c:forEach>
													</strong></td>
													<td><strong> <c:choose>
																<c:when
																	test="${item.delivery_state=='delivery_prepared' }">
					       배송준비중
					    </c:when>
																<c:when test="${item.delivery_state=='delivering' }">
					       배송중
					    </c:when>
																<c:when
																	test="${item.delivery_state=='finished_delivering' }">
					       배송완료
					    </c:when>
																<c:when test="${item.delivery_state=='cancel_order' }">
					       주문취소
					    </c:when>
																<c:when
																	test="${item.delivery_state=='returning_goods' }">
					       반품
					    </c:when>
															</c:choose>
													</strong></td>
													<td><strong>${item.orderer_name }</strong></td>
													<td><strong>${item.receiver_name }</strong></td>
													<td><c:choose>
															<c:when
																test="${item.delivery_state=='delivery_prepared'}">
																<input type="button" class="btn btn-primary btn-sm"
																	onClick="fn_cancel_order('${item.order_id}')"
																	value="주문취소" />
															</c:when>
															<c:otherwise>
																<input type="button"
																	onClick="fn_cancel_order('${item.order_id}')"
																	value="주문취소" disabled />
															</c:otherwise>
														</c:choose></td>
												</tr>
												<c:set var="pre_order_id" value="${item.order_id }" />
											</c:when>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
					</table>

				</div>
			</div>
		</div>
	</div>
</body>
</html>