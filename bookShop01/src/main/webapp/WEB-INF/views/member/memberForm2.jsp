<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
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

	function fn_overlapped() {
		var _id = $('#_member_id').val();

		$.ajax({
			url : '${contextPath}/member/overlapped.do',
			type : 'post',
			async : false,
			dataType : "text",
			data : {
				id : _id
			},
			success : function(data, textStatus) {
				if (data == 'false') {
					$('#chkMsg').html("사용가능한 아이디입니다.");
					$('#chkMsg').css('color', 'blue')
					$('#chkMsg').css('font-size', '12px')
					$('#member_id').val(_id);
				} else if (_id == '') {
					$('#chkMsg').html("아이디를 입력해주세요.");
					$('#chkMsg').css('color', '#8c92a0')
					$('#chkMsg').css('font-size', '12px')
				} else {
					$('#chkMsg').html("중복된 아이디입니다.");
					$('#chkMsg').css('color', 'red')
					$('#chkMsg').css('font-size', '12px')
				}
			},
			error : function() {
				alert("에러입니다");
			}
		});
	};

	/*원본 function fn_overlapped(){
	 var _id=$("#_member_id").val();
	 if(_id==''){
	 alert("ID를 입력하세요");
	 return;
	 }
	 $.ajax({
	 type:"post",
	 async:false,  
	 url:"${contextPath}/member/overlapped.do",
	 dataType:"text",
	 data: {id:_id},
	 success:function (data,textStatus){
	 if(data=='false'){
	 alert("사용할 수 있는 ID입니다.");
	 $('#btnOverlapped').prop("disabled", true);
	 $('#_member_id').prop("disabled", true);
	 $('#member_id').val(_id);
	 }else{
	 alert("사용할 수 없는 ID입니다.");
	 }
	 },
	 error:function(data,textStatus){
	 alert("에러가 발생했습니다.");ㅣ
	 },
	 complete:function(data,textStatus){
	 //alert("작업을완료 했습니다");
	 }
	 });  //end ajax	 
	 } */
</script>
</head>
<body>
	<div class="site-section3">
		<div class="containerLogin">
			<div class="row">
				<div class="col-md-12">
					<h2 class="h3 mb-3 text-black">회원가입</h2>
				</div>
				<div class="col-md-72">

					<form action="${contextPath}/member/addMember.do" method="post">

						<div class="p-3 p-lg-5 border">
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_fname" class="text-black">아이디 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-controlMemberId" id="_member_id" name="_member_id"
										oninput="fn_overlapped()"> <input type="hidden"
										name="member_id" id="member_id" /> <span id="chkMsg">
										<span id="chkMsg" class="chkMsg">아이디를 입력 해주세요.</span>
								</div>

							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">비밀번호 <span
										class="text-danger">*</span></label> <input type="password"
										class="form-controlMemberId" id="member_pw" name="member_pw"
										placeholder="">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_fname" class="text-black">이름 <span
										class="text-danger">*</span></label> <input type="text"
										class="form-controlMemberId" name="member_name">
								</div>

							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">성별 </label>

								</div>
								<div class="col-md-12">

									<input type="radio" name="member_gender" value="102" checked/> 남성 <input
										type="radio" name="member_gender" value="101"  /> 여성
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_subject" class="text-black">법정생년월일 </label>
								</div>
								<div class="col-md-12">
									<span class="select-holder"> <select
										name="member_birth_y" class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="year" begin="1" end="100">
												<c:choose>
													<c:when test="${year==80}">
														<option value="${ 1920+year}" selected>${ 1920+year}
														</option>
													</c:when>
													<c:otherwise>
														<option value="${ 1920+year}">${ 1920+year}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select>
									</span> 년 <span class="select-holder2"> <select
										name="member_birth_m" class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="month" begin="1" end="12">
												<c:choose>
													<c:when test="${month==5 }">
														<option value="${month }" selected>${month }</option>
													</c:when>
													<c:otherwise>
														<option value="${month }">${month}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select>
									</span> 월 <span class="select-holder2"> <select
										name="member_birth_d" class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="day" begin="1" end="31">
												<c:choose>
													<c:when test="${day==10 }">
														<option value="${day}" selected>${day}</option>
													</c:when>
													<c:otherwise>
														<option value="${day}">${day}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select>
									</span> 일 <span style="padding-left: 50px"></span>
								</div>
								<div class="col-md-12">
									<input type="radio" name="member_birth_gn" value="2" checked />&nbsp;양력&nbsp;
									<input type="radio" name="member_birth_gn" value="1" />&nbsp;음력&nbsp;

								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_message" class="text-black">전화번호 </label>
								</div>
								<div class="col-md-12">
									<span class="select-holder"> <select name="tel1"
										class="form-controlMemberForm select2"
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
									</span> - <input size="10px" type="text" name="tel2"
										class="form-controlMemberFormInput"> - <input
										size="10px" type="text" name="tel3"
										class="form-controlMemberFormInput">

								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_message" class="text-black">전화번호 </label>
								</div>
								<div class="col-md-12">
									<span class="select-holder"> <select name="hp1"
										class="form-controlMemberForm select3"
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
										class="form-controlMemberFormInput"> - <input
										size="10px" type="text" name="hp3"
										class="form-controlMemberFormInput">

								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_message" class="text-black">EMAIL </label>
								</div>
								<div class="col-md-12">
									<input size="10px" type="text" name="email1"
										class="form-controlMemberFormInput"> @ <input
										size="10px" type="text" name="email2"
										class="form-controlMemberFormInput"> <span
										class="select-holder"> <select name="email2"
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
								<div class="col-md-12">
									<input type="checkbox" name="emailsts_yn" value="Y" checked />
									쇼핑몰에서 발송하는 e-mail을 수신합니다.
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_address" class="text-black">주소</label>
								</div>
								<div class="col-md-8">
									<input type="text" class="form-controlAddress" id="zipcode"
										name="zipcode" placeholder="우편번호"> <a
										href="javascript:execDaumPostcode()"> <input type="button"
										class="btn btn-smCustom btn-secondary" value="주소 찾기"></a>
								</div>
							</div>

							<div class="form-group">
								<input type="text" class="form-control" id="roadAddress"
									name="roadAddress" placeholder="도로명 주소">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" id="jibunAddress"
									name="jibunAddress" placeholder="지번 주소">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" name="namujiAddress"
									placeholder="상세 주소">
							</div>



							<div class="form-group row">
								<div class="col-md-6">
									<input type="submit" class="btn btn-primary btn-lg btn-block"
										value="회원가입">

								</div>

								<div class="col-md-6">
									<a href="javascript:history.back();"><input type="button" class="btn btn-outline-danger btn-lg btn-block"
										value="뒤로가기"></a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>