<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<script>
	$(window).scroll(function() {
		var scrollTop = $(document).scrollTop();
		var def = 200;

		var $w = $(window), $banner = $('.side').outerHeight();

		if (scrollTop > $banner) {
			scrollTop = $banner;
		}
		if (scrollTop < 200) {
			scrollTop = 200;

		}
		var menu = scrollTop - 300;
		if (menu > def) {
			$(".followquick").stop();
			$(".followquick").animate({
				"top" : menu
			}, {
				duration : 300
			});
		}

	});
</script>

<script>
	var array_index = 0;
	var SERVER_URL = "${contextPath}/thumbnails.do";
	function fn_show_next_goods() {
		var img_sticky = document.getElementById("img_sticky");
		var cur_goods_num = document.getElementById("cur_goods_num");
		var _h_goods_id = document.frm_sticky.h_goods_id;
		var _h_goods_fileName = document.frm_sticky.h_goods_fileName;
		if (array_index < _h_goods_id.length - 1)
			array_index++;

		var goods_id = _h_goods_id[array_index].value;
		var fileName = _h_goods_fileName[array_index].value;
		img_sticky.src = SERVER_URL + "?goods_id=" + goods_id + "&fileName="
				+ fileName;
		cur_goods_num.innerHTML = array_index + 1;
	}

	function fn_show_previous_goods() {
		var img_sticky = document.getElementById("img_sticky");
		var cur_goods_num = document.getElementById("cur_goods_num");
		var _h_goods_id = document.frm_sticky.h_goods_id;
		var _h_goods_fileName = document.frm_sticky.h_goods_fileName;

		if (array_index > 0)
			array_index--;

		var goods_id = _h_goods_id[array_index].value;
		var fileName = _h_goods_fileName[array_index].value;
		img_sticky.src = SERVER_URL + "?goods_id=" + goods_id + "&fileName="
				+ fileName;
		cur_goods_num.innerHTML = array_index + 1;
	}

	function goodsDetail() {
		var cur_goods_num = document.getElementById("cur_goods_num");
		arrIdx = cur_goods_num.innerHTML - 1;

		var img_sticky = document.getElementById("img_sticky");
		var h_goods_id = document.frm_sticky.h_goods_id;
		var len = h_goods_id.length;

		if (len > 1) {
			goods_id = h_goods_id[arrIdx].value;
		} else {
			goods_id = h_goods_id.value;
		}

		var formObj = document.createElement("form");
		var i_goods_id = document.createElement("input");

		i_goods_id.name = "goods_id";
		i_goods_id.value = goods_id;

		formObj.appendChild(i_goods_id);
		document.body.appendChild(formObj);
		formObj.method = "get";
		formObj.action = "${contextPath}/goods/goodsDetail.do?goods_id="
				+ goods_id;
		formObj.submit();

	}
</script>
<body>
	<div class="col-md-3 order-1 mb-5 mb-md-0 side">
		<div class="sideMenu border p-4 rounded mb-4 rel">
			<h3 class="mb-3 h6 text-uppercase text-black d-block">카테고리</h3>
			<ul class="list-unstyled mb-0">
				<li class="mb-1"><a href="#" class="d-flex"><span>베스트
							셀러</span> <span class="text-black ml-auto">(2,220)</span></a></li>
				<li class="mb-1"><a href="#" class="d-flex"><span>스태디
							샐러</span> <span class="text-black ml-auto">(2,550)</span></a></li>
				<li class="mb-1"><a href="#" class="d-flex"><span>신간</span>
						<span class="text-black ml-auto">(2,124)</span></a></li>
			</ul>
		</div>


		<div class="followquick border p-4 rounded mb-4 hide">
			<div class="mb-4">
				<h3 class="mb-3 h6 text-uppercase text-black d-block">최근 본 상품</h3>
				<ul class="quick">
					<!--   상품이 없습니다. -->
					<c:choose>
						<c:when test="${ empty quickGoodsList }">
							<strong>상품이 없습니다.</strong>
						</c:when>
						<c:otherwise>
							<form name="frm_sticky">
								<c:forEach var="item" items="${quickGoodsList }"
									varStatus="itemNum">
									<c:choose>
										<c:when test="${itemNum.count==1 }">
											<a href="javascript:goodsDetail();"> <img id="img_sticky"
												src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
											</a>
											<input type="hidden" name="h_goods_id"
												value="${item.goods_id}" />
											<input type="hidden" name="h_goods_fileName"
												value="${item.goods_fileName}" />
											<br>

										</c:when>
										<c:otherwise>
											<input type="hidden" name="h_goods_id"
												value="${item.goods_id}" />
											<input type="hidden" name="h_goods_fileName"
												value="${item.goods_fileName}" />
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</form>

						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="quickText">
				<c:choose>
					<c:when test="${ empty quickGoodsList }">
						<h5>&nbsp; &nbsp; &nbsp; &nbsp; 0/0 &nbsp;</h5>
					</c:when>
					<c:otherwise>
						<h5>
							<a href='javascript:fn_show_previous_goods();'> 이전 </a> &nbsp; <span
								id="cur_goods_num">1</span>/${quickGoodsListNum} &nbsp; <a
								href='javascript:fn_show_next_goods();'> 다음 </a>
						</h5>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
</body>
</html>

