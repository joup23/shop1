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

	window.onload = function() {
		selectBoxInit();
	}

	function selectBoxInit() {

		var tel1 = '${memberInfo.tel1 }';
		var hp1 = '${memberInfo.hp1}';
		var selTel1 = document.getElementById('tel1');
		var selHp1 = document.getElementById('hp1');
		var optionTel1 = selTel1.options;
		var optionHp1 = selHp1.options;
		var val;
		for (var i = 0; i < optionTel1.length; i++) {
			val = optionTel1[i].value;
			if (tel1 == val) {
				optionTel1[i].selected = true;
				break;
			}
		}

		for (var i = 0; i < optionHp1.length; i++) {
			val = optionHp1[i].value;
			if (hp1 == val) {
				optionHp1[i].selected = true;
				break;
			}
		}

	}

	function fn_modify_member_info(attribute) {
		var value;
		// alert(member_id);
		// alert("mod_type:"+mod_type);
		var frm_mod_member = document.frm_mod_member;
		if (attribute == 'member_pw') {
			value = frm_mod_member.member_pw.value;
			//alert("member_pw:"+value);
		} else if (attribute == 'member_gender') {
			var member_gender = frm_mod_member.member_gender;
			for (var i = 0; member_gender.length; i++) {
				if (member_gender[i].checked) {
					value = member_gender[i].value;
					break;
				}
			}

		} else if (attribute == 'member_birth') {
			var member_birth_y = frm_mod_member.member_birth_y;
			var member_birth_m = frm_mod_member.member_birth_m;
			var member_birth_d = frm_mod_member.member_birth_d;
			var member_birth_gn = frm_mod_member.member_birth_gn;

			for (var i = 0; member_birth_y.length; i++) {
				if (member_birth_y[i].selected) {
					value_y = member_birth_y[i].value;
					break;
				}
			}
			for (var i = 0; member_birth_m.length; i++) {
				if (member_birth_m[i].selected) {
					value_m = member_birth_m[i].value;
					break;
				}
			}

			for (var i = 0; member_birth_d.length; i++) {
				if (member_birth_d[i].selected) {
					value_d = member_birth_d[i].value;
					break;
				}
			}

			//alert("수정 년:"+value_y+","+value_m+","+value_d);
			for (var i = 0; member_birth_gn.length; i++) {
				if (member_birth_gn[i].checked) {
					value_gn = member_birth_gn[i].value;
					break;
				}
			}
			//alert("생년 양음년 "+value_gn);
			value = +value_y + "," + value_m + "," + value_d + "," + value_gn;
		} else if (attribute == 'tel') {
			var tel1 = frm_mod_member.tel1;
			var tel2 = frm_mod_member.tel2;
			var tel3 = frm_mod_member.tel3;

			for (var i = 0; tel1.length; i++) {
				if (tel1[i].selected) {
					value_tel1 = tel1[i].value;
					break;
				}
			}
			value_tel2 = tel2.value;
			value_tel3 = tel3.value;
			value = value_tel1 + "," + value_tel2 + ", " + value_tel3;
		} else if (attribute == 'hp') {
			var hp1 = frm_mod_member.hp1;
			var hp2 = frm_mod_member.hp2;
			var hp3 = frm_mod_member.hp3;
			var smssts_yn = frm_mod_member.smssts_yn;

			for (var i = 0; hp1.length; i++) {
				if (hp1[i].selected) {
					value_hp1 = hp1[i].value;
					break;
				}
			}
			value_hp2 = hp2.value;
			value_hp3 = hp3.value;
			value_smssts_yn = smssts_yn.checked;
			value = value_hp1 + "," + value_hp2 + ", " + value_hp3 + ","
					+ value_smssts_yn;
		} else if (attribute == 'email') {
			var email1 = frm_mod_member.email1;
			var email2 = frm_mod_member.email2;
			var emailsts_yn = frm_mod_member.emailsts_yn;

			value_email1 = email1.value;
			value_email2 = email2.value;
			value_emailsts_yn = emailsts_yn.checked;
			value = value_email1 + "," + value_email2 + "," + value_emailsts_yn;
			//alert(value);
		} else if (attribute == 'address') {
			var zipcode = frm_mod_member.zipcode;
			var roadAddress = frm_mod_member.roadAddress;
			var jibunAddress = frm_mod_member.jibunAddress;
			var namujiAddress = frm_mod_member.namujiAddress;

			value_zipcode = zipcode.value;
			value_roadAddress = roadAddress.value;
			value_jibunAddress = jibunAddress.value;
			value_namujiAddress = namujiAddress.value;
			value = value_zipcode + "," + value_roadAddress + ","
					+ value_jibunAddress + "," + value_namujiAddress;
		}
		console.log(attribute);

		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/mypage/modifyMyInfo.do",
			data : {
				attribute : attribute,
				value : value,
			},
			success : function(data, textStatus) {
				if (data.trim() == 'mod_success') {
					alert("회원 정보를 수정했습니다.");
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
</script>
</head>

<body>
	<div class="col-md-9 order-2">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md-12 mb-5">
					<h2 class="h3 mb-3 text-black">내 상세 정보</h2>
				</div>
				<div class="col-md-72">

					<form name="frm_mod_member">

						<div class="p-3 p-lg-5 border">
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_fname" class="text-black">아이디</label> <input
										type="text" class="form-controlMemberId" name="_member_id"
										value="${memberInfo.member_id }" disabled>
								</div>

							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black block">비밀번호 </label> <input
										type="password" class="form-controlMemberInfo" id="member_pw"
										name="member_pw" placeholder=""> <input type="button"
										class="btn btn-smCustom btn-secondary no-pad right"
										value="수정하기" onClick="fn_modify_member_info('member_pw')" />
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_fname" class="text-black block">이름</label> <input
										type="text" value="${memberInfo.member_name }" disabled
										class="form-controlMemberId" name="member_name">
								</div>

							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_email" class="text-black">성별 </label>

								</div>
								<div class="col-md-12">
									<c:choose>
										<c:when test="${memberInfo.member_gender =='101' }">
											<input type="radio" name="member_gender" value="102" checked />
									남성 <input type="radio" name="member_gender" value="101" /> 여성
									</c:when>
										<c:otherwise>
											<input type="radio" name="member_gender" value="102" />
									남성 <input type="radio" name="member_gender" value="101" checked /> 여성
									</c:otherwise>
									</c:choose>
									<input type="button" value="수정하기"
										class="btn btn-smCustom btn-secondary no-pad right"
										onClick="fn_modify_member_info('member_gender')" />
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
											<c:forEach var="i" begin="1" end="100">
												<c:choose>
													<c:when test="${memberInfo.member_birth_y==1920+i }">
														<option value="${ 1920+i}" selected>${ 1920+i}</option>
													</c:when>
													<c:otherwise>
														<option value="${ 1920+i}">${ 1920+i}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select>
									</span> 년 <span class="select-holder2"> <select
										name="member_birth_m" class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="i" begin="1" end="12">
												<c:choose>
													<c:when test="${memberInfo.member_birth_m==i }">
														<option value="${i }" selected>${i }</option>
													</c:when>
													<c:otherwise>
														<option value="${i }">${i }</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select>
									</span> 월 <span class="select-holder2"> <select
										name="member_birth_d" class="form-controlMemberForm select1"
										onmousedown="if(this.options.length>6){this.size=6;}"
										onchange='this.size=0;' onblur="this.size=0;">
											<c:forEach var="i" begin="1" end="31">
												<c:choose>
													<c:when test="${memberInfo.member_birth_d==i }">
														<option value="${i }" selected>${i }</option>
													</c:when>
													<c:otherwise>
														<option value="${i }">${i }</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
									</select>
									</span> 일 <span style="padding-left: 50px"></span>
								</div>
								<div class="col-md-12">
									<c:choose>
										<c:when test="${memberInfo.member_birth_gn=='2' }">
											<input type="radio" name="member_birth_gn" value="2" checked />양력
						
											<input type="radio" name="member_birth_gn" value="1" />음력
										</c:when>
										<c:otherwise>
											<input type="radio" name="member_birth_gn" value="2" />양력
						  					<input type="radio" name="member_birth_gn" value="1"
												checked />음력
										</c:otherwise>
									</c:choose>
									<input type="button" value="수정하기"
										class="btn btn-smCustom btn-secondary no-pad right"
										onClick="fn_modify_member_info('member_birth')" />
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
										class="form-controlMemberFormInput"
										value="${memberInfo.tel2 }"> - <input size="10px"
										type="text" name="tel3" class="form-controlMemberFormInput"
										value="${memberInfo.tel3 }"> <input type="button"
										value="수정하기"
										class="btn btn-smCustom btn-secondary no-pad right"
										onClick="fn_modify_member_info('tel')" />
								</div>
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_message" class="text-black">휴대폰 번호 </label>
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
										value="${memberInfo.hp2 }" class="form-controlMemberFormInput">
									- <input size="10px" type="text" name="hp3"
										value="${memberInfo.hp3 }" class="form-controlMemberFormInput">
									<input type="button" value="수정하기"
										class="btn btn-smCustom btn-secondary no-pad right"
										onClick="fn_modify_member_info('hp')" />
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_message" class="text-black">EMAIL </label>
								</div>
								<div class="col-md-12">
									<input size="10px" type="text" name="email1"
										value="${memberInfo.email1 }"
										class="form-controlMemberFormInput"> @ <input
										size="10px" type="text" name="email2"
										value="${memberInfo.email2 }"
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
									<c:choose>
										<c:when test="${memberInfo.emailsts_yn=='true' }">
											<input type="checkbox" name="emailsts_yn" value="Y" checked />
									쇼핑몰에서 발송하는 e-mail을 수신합니다.
										</c:when>
										<c:otherwise>
											<input type="checkbox" name="emailsts_yn" value="Y" />
									쇼핑몰에서 발송하는 e-mail을 수신합니다.
										</c:otherwise>
									</c:choose>
									<input type="button" value="수정하기"
										class="btn btn-smCustom btn-secondary no-pad right"
										onClick="fn_modify_member_info('email')" />
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_address" class="text-black">주소</label>
								</div>
								<div class="col-md-12">
									<input type="text" class="form-controlAddress" id="zipcode"
										name="zipcode" placeholder="우편번호"
										value="${memberInfo.zipcode }"> <a
										href="javascript:execDaumPostcode()"> <input type="button"
										class="btn btn-smCustom btn-secondary" value="주소 찾기"></a>
									<input type="button" value="수정하기"
										class="btn btn-smCustom btn-secondary no-pad right"
										onClick="fn_modify_member_info('address')" />
								</div>
							</div>

							<div class="form-group">
								<input type="text" class="form-control" id="roadAddress"
									value="${memberInfo.roadAddress }" name="roadAddress"
									placeholder="도로명 주소">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" id="jibunAddress"
									value="${memberInfo.jibunAddress }" name="jibunAddress"
									placeholder="지번 주소">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" name="namujiAddress"
									value="${memberInfo.namujiAddress }" placeholder="상세 주소">
							</div>



							<div class="form-group row">

								<div class="col-md-6 center">
									<input type="hidden" name="command" value="modify_my_info" />
									<a href="javascript:history.back();"><input type="button"
										name="btn_cancel_member"
										class="btn btn-outline-danger btn-lg btn-block" value="수정 취소"></a>
								</div>
							</div>
						</div>
						<input type="hidden" name="h_tel1" value="${memberInfo.tel1}" />
						<input type="hidden" name="h_hp1" value="${memberInfo.hp1}" />
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
