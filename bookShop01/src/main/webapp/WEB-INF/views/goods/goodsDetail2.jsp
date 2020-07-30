<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goodsVO}" />
<c:set var="imageList" value="${goodsMap.imageList }" />
<%
	//치환 변수 선언합니다.
//pageContext.setAttribute("crcn", "\r\n"); //개행문자
pageContext.setAttribute("crcn", "\n"); //Ajax로 변경 시 개행 문자 
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<html>
<head>
<script type="text/javascript">
	function add_cart(goods_id) {
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/addGoodsInCart.do",
			data : {
				goods_id : goods_id

			},
			success : function(data, textStatus) {
				//alert(data);
				//	$('#message').append(data);
				if (data.trim() == 'add_success') {
					alert("카트에 담았습니다.");
				} else if (data.trim() == 'already_existed') {
					alert("이미 카트에 등록된 상품입니다.");
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

	function fn_order_each_goods(goods_id, goods_title, goods_sales_price,
			fileName) {
		var _isLogOn = document.getElementById("isLogOn");
		var isLogOn = _isLogOn.value;

		if (isLogOn == "false" || isLogOn == '') {
			alert("로그인 후 주문이 가능합니다!!!");
		}

		var total_price, final_total_price;
		var order_goods_qty = document.getElementById("order_goods_qty");

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
		i_order_goods_qty.value = order_goods_qty.value;
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
<body>
	<div class="col-md-9 order-2">
		<div class="row border-bottom">
			<div class="col-md-12 border-bottom">
				<h2 class="text-black">${goods.goods_title }</h2>
				<p>${goods.goods_writer}&nbsp;저|${goods.goods_publisher}</p>
			</div>
			<div class="col-md-5 height-auto pad-top">
				<img
					src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}"
					alt="Image" class="img-fluid goodsImg">
			</div>
			<div class="col-md-7 pad-top">
				<ul class="list-unstyled mb-0 border-bottom">
					<li class="mb-1 d-flex"><span>발행일</span> <span
						class="text-black ml-auto"><c:set var="pub_date"
								value="${goods.goods_published_date}" /> <c:set var="arr"
								value="${fn:split(pub_date,' ')}" /> <c:out value="${arr[0]}" /></span></li>
					<li class="mb-1 d-flex"><span>페이지 수</span> <span
						class="text-black ml-auto">${goods.goods_total_page}쪽</span></li>
					<li class="mb-1 d-flex"><span>도서번호</span> <span
						class="text-black ml-auto">${goods.goods_isbn}</span></li>
				</ul>
				<ul class="list-unstyled mb-0 border-bottom">
					<li class="mb-1 d-flex"><span>배송비</span> <span
						class="text-black ml-auto">무료</span></li>
					<li class="mb-1 d-flex"><span>배송 안내</span> <span
						class="text-black ml-auto">당일배송</span></li>
					<li class="mb-1 d-flex"><span>도착 예정일</span> <span
						class="text-black ml-auto">지금 주문 시 내일 도착 예정</span></li>
				</ul>

				<div class="mb-5 margin-top bottom_no_margin border-bottom">
					<div class="input-group mb-3 center" style="max-width: 120px;">
						<div class="input-group-prepend">
							<button class="btn btn-outline-primary js-btn-minus"
								type="button">&minus;</button>
						</div>
						<input type="text" class="form-control text-center" value="1"
							placeholder="" aria-label="Example text with button addon"
							aria-describedby="button-addon1" id="order_goods_qty">
						<div class="input-group-append">
							<button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
						</div>
					</div>

				</div>
				<div class="mb-5 margin-top-bottom text-center">
					<a
						href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}');"
						class="buy-now btn btn-smGood btn-primary good-button">바로 구매</a> <a
						href="javascript:add_cart('${goods.goods_id }')"
						class="buy-now btn btn-smGood btn-primary good-button">장바구니</a> <a
						href="#" class="buy-now btn btn-smGood btn-primary good-button">위시리스트</a>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12 margin-top border-bottom site-navbar">
				<nav class="site-navigation text-right text-md-center"
					role="navigation">
					<div class="container">
						<ul
							class="site-menu js-clone-nav d-sm-block d-md-block tabs border-bottom">
							<li><a href="#tab1">책소개</a></li>
							<li><a href="#tab2">저자소개</a></li>
							<li><a href="#tab3">책목차</a></li>
							<li><a href="#tab4">출판사서평</a></li>
							<li><a href="#tab5">추천사</a></li>
							<li><a href="#tab6">리뷰</a></li>
						</ul>
						<div class="tab_container">
							<div class="tab_content" id="tab1">
								<h4>책소개</h4>
								<p>${fn:replace(goods.goods_intro,crcn,br)}</p>
								<c:forEach var="image" items="${imageList }">
									<img
										src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${image.fileName}"
										class="img-fluid">
								</c:forEach>
							</div>
							<div class="tab_content" id="tab2">
								<h4>저자소개</h4>
								<p>
								<div class="writer">저자 : ${goods.goods_writer}</div>
								<p>${fn:replace(goods.goods_writer_intro,crcn,br) }</p>

							</div>
							<div class="tab_content" id="tab3">
								<h4>책목차</h4>
								<p>${fn:replace(goods.goods_contents_order,crcn,br)}</p>
							</div>
							<div class="tab_content" id="tab4">
								<h4>출판사서평</h4>
								<p>${fn:replace(goods.goods_publisher_comment ,crcn,br)}</p>
							</div>
							<div class="tab_content" id="tab5">
								<h4>추천사</h4>
								<p>${fn:replace(goods.goods_recommendation,crcn,br) }</p>
							</div>
							<div class="tab_content" id="tab6">
								<h4>리뷰</h4>
							</div>
						</div>
					</div>
				</nav>
			</div>
		</div>
	</div>

</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}" />