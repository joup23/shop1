<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="euc-kr" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goods}" />
<c:set var="imageFileList" value="${goodsMap.imageFileList}" />

<c:choose>
	<c:when test='${not empty goods.goods_status}'>
		<script>
			window.onload = function() {
				init();
			}

			function init() {
				var frm_mod_goods = document.frm_mod_goods;
				var h_goods_status = frm_mod_goods.h_goods_status;
				var goods_status = h_goods_status.value;
				var select_goods_status = frm_mod_goods.goods_status;
				select_goods_status.value = goods_status;
			}
		</script>
	</c:when>
</c:choose>
<script type="text/javascript">
	function fn_modify_goods(goods_id, attribute) {
		var frm_mod_goods = document.frm_mod_goods;
		var value = "";
		if (attribute == 'goods_sort') {
			value = frm_mod_goods.goods_sort.value;
		} else if (attribute == 'goods_title') {
			value = frm_mod_goods.goods_title.value;
		} else if (attribute == 'goods_writer') {
			value = frm_mod_goods.goods_writer.value;
		} else if (attribute == 'goods_publisher') {
			value = frm_mod_goods.goods_publisher.value;
		} else if (attribute == 'goods_price') {
			value = frm_mod_goods.goods_price.value;
		} else if (attribute == 'goods_sales_price') {
			value = frm_mod_goods.goods_sales_price.value;
		} else if (attribute == 'goods_point') {
			value = frm_mod_goods.goods_point.value;
		} else if (attribute == 'goods_published_date') {
			value = frm_mod_goods.goods_published_date.value;
		} else if (attribute == 'goods_page_total') {
			value = frm_mod_goods.goods_page_total.value;
		} else if (attribute == 'goods_isbn') {
			value = frm_mod_goods.goods_isbn.value;
		} else if (attribute == 'goods_delivery_price') {
			value = frm_mod_goods.goods_delivery_price.value;
		} else if (attribute == 'goods_delivery_date') {
			value = frm_mod_goods.goods_delivery_date.value;
		} else if (attribute == 'goods_status') {
			value = frm_mod_goods.goods_status.value;
		} else if (attribute == 'goods_contents_order') {
			value = frm_mod_goods.goods_contents_order.value;
		} else if (attribute == 'goods_writer_intro') {
			value = frm_mod_goods.goods_writer_intro.value;
		} else if (attribute == 'goods_intro') {
			value = frm_mod_goods.goods_intro.value;
		} else if (attribute == 'publisher_comment') {
			value = frm_mod_goods.publisher_comment.value;
		} else if (attribute == 'recommendation') {
			value = frm_mod_goods.recommendation.value;
		}

		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
			data : {
				goods_id : goods_id,
				attribute : attribute,
				value : value
			},
			success : function(data, textStatus) {
				if (data.trim() == 'mod_success') {
					alert("상품 정보를 수정했습니다.");
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

	function readURL(input, preview) {
		//  alert(preview);
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#' + preview).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	var cnt = 1;
	function fn_addFile() {
		$("#d_file").append(
				"<br>" + "<input  type='file' class='btn btn-smCustom btn-secondary no-pad margin-bottom' name='detail_image" + cnt
						+ "' id='detail_image" + cnt
						+ "'  onchange=readURL(this,'previewImage" + cnt
						+ "') />");
		$("#d_file").append(
				"<img  id='previewImage"+cnt+"'   width=200 height=200  />");
		$("#d_file")
				.append(
						"<input  type='button' class='btn btn-smCustom btn-secondary no-pad margin-bottom right' value='추가하기'  onClick=addNewImageFile('detail_image"
								+ cnt
								+ "','${imageFileList[0].goods_id}','detail_image')  />");
		cnt++;
	}

	function modifyImageFile(fileId, goods_id, image_id, fileType) {
		// alert(fileId);
		var form = $('#FILE_FORM')[0];
		var formData = new FormData(form);
		formData.append("fileName", $('#' + fileId)[0].files[0]);
		formData.append("goods_id", goods_id);
		formData.append("image_id", image_id);
		formData.append("fileType", fileType);

		$.ajax({
			url : '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(result) {
				alert("이미지를 수정했습니다!");
			}
		});
	}

	function addNewImageFile(fileId, goods_id, fileType) {
		//  alert(fileId);
		var form = $('#FILE_FORM')[0];
		var formData = new FormData(form);
		formData.append("uploadFile", $('#' + fileId)[0].files[0]);
		formData.append("goods_id", goods_id);
		formData.append("fileType", fileType);

		$.ajax({
			url : '${contextPath}/admin/goods/addNewGoodsImage.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'post',
			success : function(result) {
				alert("이미지를 수정했습니다!");
			}
		});
	}

	function deleteImageFile(goods_id, image_id, imageFileName, trId) {
		var tr = document.getElementById(trId);

		$.ajax({
			type : "post",
			async : true, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/admin/goods/removeGoodsImage.do",
			data : {
				goods_id : goods_id,
				image_id : image_id,
				imageFileName : imageFileName
			},
			success : function(data, textStatus) {
				alert("이미지를 삭제했습니다!!");
				tr.style.display = 'none';
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다." + textStatus);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");

			}
		}); //end ajax	
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
</HEAD>
<BODY>
	<div class="col-md-9 order-2">
		<div class="row mb-5">
			<div class="col-md-12">
				<form name="frm_mod_goods" method="post">
					<h2 class="h3 mb-3 text-black">상품 수정</h2>
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
																<c:choose>
																	<c:when test="${goods.goods_sort=='컴퓨터와 인터넷' }">
																		<option value="컴퓨터와 인터넷" selected>컴퓨터와 인터넷</option>
																		<option value="디지털 기기">디지털 기기</option>
																	</c:when>
																	<c:when test="${goods.goods_sort=='디지털 기기' }">
																		<option value="컴퓨터와 인터넷">컴퓨터와 인터넷</option>
																		<option value="디지털 기기" selected>디지털 기기</option>
																	</c:when>
																</c:choose>
														</select>
														</span> <input type="button" value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_sort')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															이름</label> <input type="text" class="form-controlMemberInfo"
															value="${goods.goods_title }" name="goods_title">
														<input type="button" value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_title')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">저자</label> <input
															type="text" class="form-controlMemberInfo"
															value="${goods.goods_writer }" name="goods_writer">
														<input type="button" value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_writer')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">출판사</label>
														<input type="text" class="form-controlMemberInfo"
															value="${goods.goods_publisher }" name="goods_publisher">
														<input type="button" value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_publisher')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															정가</label> <input type="text" class="form-controlMemberInfo"
															value="${goods.goods_price }" name="goods_price">
														<input type="button" value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_price')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															판매 가격</label> <input type="text" class="form-controlMemberInfo"
															value="${goods.goods_sales_price }"
															name="goods_sales_price"> <input type="button"
															value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_sales_price')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															구매 포인트</label> <input type="text" class="form-controlMemberInfo"
															value="${goods.goods_point }" name="goods_point">
														<input type="button" value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_point')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															출판일</label> <input type="date" class="form-controlMemberInfo"
															value="${goods.goods_published_date }"
															name="goods_published_date"> <input type="button"
															value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_published_date')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품 총
															페이지수</label> <input type="text" class="form-controlMemberInfo"
															value="${goods.goods_total_page }"
															name="goods_total_page"> <input type="button"
															value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_total_page')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															ISBN</label> <input type="text" class="form-controlMemberInfo"
															value="${goods.goods_isbn }" name="goods_isbn"> <input
															type="button" value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_isbn')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															배송비</label> <input type="text" class="form-controlMemberInfo"
															value="${goods.goods_delivery_price }"
															name="goods_delivery_price"> <input type="button"
															value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_delivery_price')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_fname" class="text-black block">제품
															도착 예정일</label> <input type="date" class="form-controlMemberInfo"
															value="${goods.goods_delivery_date }"
															name="goods_delivery_date"> <input type="button"
															value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_delivery_date')" />
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-12">
														<label for="c_subject" class="text-black block">제품
															종류 </label>
													</div>
													<div class="col-md-12">
														<span class="select-holder"> <select
															name="goods_status"
															class="form-controlMemberForm select1"
															onmousedown="if(this.options.length>6){this.size=6;}"
															onchange='this.size=0;' onblur="this.size=0;">
																<option value="bestseller">베스트셀러</option>
																<option value="steadyseller">스테디셀러</option>
																<option value="newbook" selected>신간</option>
																<option value="on_sale">판매중</option>
																<option value="buy_out">품절</option>
																<option value="out_of_print">절판</option>
														</select>
														</span> <input type="hidden" name="h_goods_status"
															value="${goods.goods_status }" /> <input type="button"
															value="수정하기"
															class="btn btn-smCustom btn-secondary no-pad right"
															onClick="fn_modify_goods('${goods.goods_id }','goods_status')" />
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
											<form id="FILE_FORM" method="post"
												enctype="multipart/form-data">
												<div class="p-3 p-lg-5 border">

													<c:forEach var="item" items="${imageFileList }"
														varStatus="itemNum">
														<c:choose>
															<c:when test="${item.fileType=='main_image' }">
																<div class="form-group row">
																	<div class="col-md-12">
																		<label for="c_subject" class="text-black">메인
																			이미지 </label>
																	</div>
																	<div class="col-md-12">
																		<input type="file" id="main_image" name="main_image"
																			class="btn btn-smCustom btn-secondary no-pad margin-bottom"
																			onchange="readURL(this,'preview${itemNum.count}');" />
																		<input type="hidden" name="image_id"
																			value="${item.image_id}" /> <input type="button"
																			value="수정하기"
																			class="btn btn-smCustom btn-secondary no-pad right margin-right"
																			onClick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')" />
																		<img id="preview${itemNum.count }" width=200
																			height=200
																			src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" />
																	</div>

																</div>
															</c:when>
															<c:otherwise>
																<div class="form-group row">
																	<div class="col-md-12">
																		<label for="c_subject" class="text-black">상세
																			이미지${itemNum.count-1 }</label>
																	</div>
																	<div class="col-md-12">
																			<input type="file" id="detail_image"
																				name="detail_image"
																				class="btn btn-smCustom btn-secondary no-pad margin-bottom"
																				onchange="readURL(this,'preview${itemNum.count}');" />

																			<input type="hidden" name="image_id"
																				value="${item.image_id}" />
																	
																			<input type="button" value="수정하기"
																				class="btn btn-smCustom btn-secondary no-pad right margin-right"
																				onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')" />
																			<input type="button"
																				value="삭제하기"
																				class="btn btn-smCustom btn-secondary no-pad right margin-right"
																				onClick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}','${itemNum.count-1}')" />
																		<img id="preview${itemNum.count }" width=200
																			height=200
																			src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" />
																	</div>

																</div>
															</c:otherwise>
														</c:choose>
													</c:forEach>
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
											</form>
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