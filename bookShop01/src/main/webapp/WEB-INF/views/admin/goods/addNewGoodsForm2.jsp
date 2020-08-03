<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<meta charset="utf-8">
<head>
<script type="text/javascript">
	var cnt = 0;
	function fn_addFile() {
		if (cnt == 0) {
			$("#d_file")
					.append(
							"<br>"
									+ "<input  type='file' name='main_image' id='f_main_image' />");
		} else {
			$("#d_file")
					.append(
							"<br>"
									+ "<input  type='file' name='detail_image"+cnt+"' />");
		}

		cnt++;
	}

	function fn_add_new_goods(obj) {
		fileName = $('#f_main_image').val();
		if (fileName != null && fileName != undefined) {
			obj.submit();
		} else {
			alert("메인 이미지는 반드시 첨부해야 합니다.");
			return;
		}

	}
</script>
<script>
	$(document).ready(function() {

		//When page loads...
		$(".tab_content").hide(); //Hide all content
		$("ul.tabs li:first").addClass("active").show(); //Activate first tab
		$(".tab_content:first").show(); //Show first tab content

		//On Click Event
		$("ul.tabs li").click(function() {

			$("ul.tabs li").removeClass("active"); //Remove any "active" class
			$(this).addClass("active"); //Add "active" class to selected tab
			$(".tab_content").hide(); //Hide all tab content

			var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
			$(activeTab).fadeIn(); //Fade in the active ID content
			return false;
		});

	});
</script>
</head>
<BODY>
	<div class="col-md-9 order-2">
		<div class="row mb-5">
			<div class="col-md-12">
				<form action="${contextPath}/admin/goods/addNewGoods.do"
					method="post" enctype="multipart/form-data">
					<h2 class="h3 mb-3 text-black">상품 등록</h2>
					<div class="row">
						<div class="col-md-12 margin-top site-navbar">
							<nav class="site-navigation margin-bottom" role="navigation">
								<div class="container">
									<ul
										class="site-menu js-clone-nav d-sm-block d-md-block tabs border-bottom no-pad  text-md-center">
										<li><a href="#tab1">상품정보</a></li>
										<li><a href="#tab2">상품목차</a></li>
										<li><a href="#tab3">상품저자소개</a></li>
										<li><a href="#tab4">상품소개</a></li>
										<li><a href="#tab5">출판사 상품 평가</a></li>
										<li><a href="#tab6">추천사</a></li>
										<li><a href="#tab7">상품 이미지</a></li>
									</ul>
									<div class="tab_container">
										<div class="tab_content" id="tab1">
											<div class="p-3 p-lg-5 border">

												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_subject" class="text-black">제품 분류 </label>
													</div>
													<div class="col-md-12">
														<span class="select-holder"> <select
															name="goods_sort" class="form-controlMemberForm select1"
															onmousedown="if(this.options.length>6){this.size=6;}"
															onchange='this.size=0;' onblur="this.size=0;">
																<option value="컴퓨터와 인터넷" selected>컴퓨터와 인터넷
																<option value="디지털 기기">디지털 기기
														</select>
														</span>
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 이름</label> <input
															type="text" class="form-controlMemberId"
															name="goods_title">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">저자</label> <input
															type="text" class="form-controlMemberId"
															name="goods_writer">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">출판사</label> <input
															type="text" class="form-controlMemberId"
															name="goods_publisher">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 정가</label> <input
															type="text" class="form-controlMemberId"
															name="goods_price">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 판매 가격</label> <input
															type="text" class="form-controlMemberId"
															name="goods_sales_price">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 구매 포인트</label>
														<input type="text" class="form-controlMemberId"
															name="goods_point">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 출판일</label> <input
															type="date" class="form-controlMemberId"
															name="goods_published_date">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 총 페이지수</label>
														<input type="text" class="form-controlMemberId"
															name="goods_total_page">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 ISBN</label> <input
															type="text" class="form-controlMemberId"
															name="goods_isbn">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 배송비</label> <input
															type="text" class="form-controlMemberId"
															name="goods_delivery_price">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black">제품 도착 예정일</label>
														<input type="date" class="form-controlMemberId"
															name="goods_delivery_date">
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_subject" class="text-black">제품 종류 </label>
													</div>
													<div class="col-md-12">
														<span class="select-holder"> <select
															name="goods_status" class="form-controlMemberForm select1"
															onmousedown="if(this.options.length>6){this.size=6;}"
															onchange='this.size=0;' onblur="this.size=0;">
																<option value="bestseller">베스트셀러</option>
																<option value="steadyseller">스테디셀러</option>
																<option value="newbook" selected>신간</option>
																<option value="on_sale">판매중</option>
																<option value="buy_out">품절</option>
																<option value="out_of_print">절판</option>
														</select>
														</span>
													</div>
												</div>

											</div>
										</div>
										<div class="tab_content" id="tab2">
											<h4>책 목차</h4>

										</div>
										<div class="tab_content" id="tab3">
											<h4>제품 저자 소개</h4>
										</div>
										<div class="tab_content" id="tab4">
											<h4>제품 소개</h4>
										</div>
										<div class="tab_content" id="tab5">
											<h4>출판사 제품 평가</h4>
										</div>
										<div class="tab_content" id="tab6">
											<h4>추천사</h4>
										</div>
										<div class="tab_content" id="tab7">
											<div class="p-3 p-lg-5 border">

												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_subject" class="text-black">이미지 파일
															첨부 </label>
													</div>
													<div class="col-md-12">
														<input type="button" value="파일 추가" onClick="fn_addFile()" />
														<div id="d_file"></div>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</nav>
							<div class="form-group row">
								<div class="col-md-6">
									<input type="button" class="btn btn-primary btn-lg btn-block"
										onClick="fn_add_new_goods(this.form)" value="상품 등록">

								</div>

								<div class="col-md-6">
									<a href="javascript:history.back();"><input type="button"
										class="btn btn-outline-danger btn-lg btn-block" value="뒤로가기"></a>
								</div>
							</div>
						</div>

					</div>


				</form>
			</div>
		</div>
	</div>
</BODY>