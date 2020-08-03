<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script>
	function search_goods_list(fixedSearchPeriod) {
		var formObj = document.createElement("form");
		var i_fixedSearch_period = document.createElement("input");
		i_fixedSearch_period.name = "fixedSearchPeriod";
		i_fixedSearch_period.value = fixedSearchPeriod;
		formObj.appendChild(i_fixedSearch_period);
		document.body.appendChild(formObj);
		formObj.method = "get";
		formObj.action = "${contextPath}/admin/goods/adminGoodsMain.do";
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
</script>
</head>
<body>
	<div class="col-md-9 order-2">
		<div class="row mb-5">
			<div class="col-md-12">
				<h2 class="h3 mb-3 text-black">상품 조회</h2>
				<div class="site-blocks-table">

					<form method="post">
						<div class="p-3 p-lg-5 border">
							<div class="form-group row">
								<div class="col-md-12">
									<input type="radio" name="r_search" checked /> 등록일조회
									&nbsp;&nbsp;&nbsp; <input type="radio" name="r_search" /> 상세조회
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
									<a href="javascript:search_goods_list('today')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="당일">
									</a> <a href="javascript:search_goods_list('one_week')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="1주">
									</a> <a href="javascript:search_goods_list('two_week')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="2주">
									</a> <a href="javascript:search_goods_list('one_month')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="1개월">
									</a> <a href="javascript:search_goods_list('two_month')"> <input
										type="button" class="btn btn-smCustom btn-secondary no-pad"
										value="2개월">
									</a> <a href="javascript:search_goods_list('three_month')">
										<input type="button"
										class="btn btn-smCustom btn-secondary no-pad" value="3개월">
									</a> <a href="javascript:search_goods_list('four_month')"> <input
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
											<option value="2014">상품번호</option>
											<option value="2013">상품이름</option>
											<option value="2012">제조사</option>
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
								<th class="product-name">상품 번호</th>
								<th class="product-name">상품 이름</th>
								<th class="product-name">저자</th>
								<th class="product-price">출판사</th>
								<th class="product-quantity">상품 가격</th>
								<th class="product-name">입고 일자</th>
								<th class="product-name">출판일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty newGoodsList  }">
									<tr>
										<td colspan=7 class="fixed"><strong>조회한 상품이
												없습니다.</strong></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${newGoodsList }">
										<tr>
											<td><strong>${item.goods_id }</strong></td>
											<td><a
												href="${pageContext.request.contextPath}/admin/goods/modifyGoodsForm.do?goods_id=${item.goods_id}"><strong>${item.goods_title }</strong>
											</a></td>
											<td><strong>${item.goods_writer }</strong></td>
											<td><strong>${item.goods_publisher } </strong></td>
											<td><strong> ${item.goods_sales_price } </strong></td>
											<td><strong> ${item.goods_credate } </strong></td>
											<td><c:set var="pub_date"
													value="${item.goods_published_date}" /> <c:set var="arr"
													value="${fn:split(pub_date,' ')}" /> <strong> <c:out
														value="${arr[0]}" /></strong></td>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<tr>
								<td colspan=8 class="fixed"><c:forEach var="page" begin="1"
										end="10" step="1">
										<c:if test="${section >1 && page==1 }">
											<a
												href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
												&nbsp;</a>
										</c:if>
										<a
											href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }
										</a>
										<c:if test="${page ==10 }">
											<a
												href="${contextPath}/admin/goods/adminGooodsMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp;
												next</a>
										</c:if>
									</c:forEach></td>
							</tr>
					</table>

				</div>
				<div class="form-group row">

					<div class="col-md-6 center">
						<form action="${contextPath}/admin/goods/addNewGoodsForm.do">
							<input type="hidden" name="command" value="modify_my_info" />
							<input
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