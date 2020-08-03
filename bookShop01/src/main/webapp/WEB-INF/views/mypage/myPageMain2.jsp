<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<c:if test="${message=='cancel_order'}">
	<script>
		window.onload = function() {
			init();
		}

		function init() {
			alert("주문을 취소했습니다.");
		}
	</script>
</c:if>
<script>
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
			<div class="col-md-12 mb-5">
				<div class="site-blocks-table">
					<div class="float-md-left mb-4">


						<h2 class="h3 mb-3 text-black">최근 주문내역</h2>
					</div>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="product-name">주문 번호</th>
								<th class="product-name">주문 일자</th>
								<th class="product-price">주문 상품</th>
								<th class="product-quantity">주문 상태</th>
								<th class="product-price">주문 취소</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty myOrderList  }">
									<tr>
										<td colspan=5 class="fixed"><strong>주문한 상품이
												없습니다.</strong></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${myOrderList }" varStatus="i">
										<c:choose>
											<c:when test="${ pre_order_id != item.order_id}">
												<c:choose>
													<c:when test="${item.delivery_state=='delivery_prepared' }">
														<tr bgcolor="lightgreen">
													</c:when>
													<c:when
														test="${item.delivery_state=='finished_delivering' }">
														<tr bgcolor="lightgray">
													</c:when>
													<c:otherwise>
														<tr bgcolor="orange">
													</c:otherwise>
												</c:choose>
												<tr>
													<td><a
														href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><span>${item.order_id }</span>
													</a></td>
													<td><span>${item.pay_order_time }</span></td>
													<td align="left"><strong> <c:forEach
																var="item2" items="${myOrderList}" varStatus="j">
																<c:if test="${item.order_id ==item2.order_id}">
																	<a
																		href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }/${item.order_goods_qty }개</a>
																	<br>
																</c:if>
															</c:forEach>
													</strong></td>
													<td><c:choose>
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
															<c:when test="${item.delivery_state=='returning_goods' }">
			       반품완료
			    </c:when>
														</c:choose></td>
													<td><c:choose>
															<c:when
																test="${item.delivery_state=='delivery_prepared'}">
																<input type="button" class="btn btn-primary btn-sm"
																	onClick="fn_cancel_order('${item.order_id}')"
																	value="주문취소" />
															</c:when>
															<c:otherwise>
																<input type="button" class="btn btn-primary btn-sm"
																	onClick="fn_cancel_order('${item.order_id}')"
																	value="주문취소" disabled />
															</c:otherwise>
														</c:choose></td>
												</tr>
												<c:set var="pre_order_id" value="${item.order_id}" />
											</c:when>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
					</table>
				</div>
				<div class="row margin-bottom">
					<div class="col-md-12">
						<h2 class="h3 mb-3 text-black">내 정보</h2>
					</div>
					<div class="col-md-72 pad15">
						<div class="p-3 p-lg-5 border">


							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">이메일</label>

								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${memberInfo.email1 }@${memberInfo.email2 }</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">전화 번호</label>

								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">${memberInfo.hp1 }-${memberInfo.hp2}-${memberInfo.hp3 }</p>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">주소</label>
								</div>
								<div class="col-md-12">
									<p class="font-weight-bold text-black">
										도로명: &nbsp;&nbsp; ${memberInfo.roadAddress }
										<br> 지번: &nbsp;&nbsp; ${memberInfo.jibunAddress }
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
