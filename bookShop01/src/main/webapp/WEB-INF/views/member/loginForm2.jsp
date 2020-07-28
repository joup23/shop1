<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message }'>
	<script>
		var message = "${message}"
		window.onload = function() {
			result();
		}

		function result() {
			alert(message);
		}
	</script>
</c:if>
</head>
<body>
	<!-- 시작 -->
	<div class="site-section">
		<div class="containerLogin">
			<div class="row">
				<div class="col-md-12">
					<h2 class="h3 mb-3 text-black">로그인</h2>
				</div>
				<div class="col-md-72">

					<form action="${contextPath}/member/login.do" method="post">

						<div class="p-3 p-lg-5 border">
							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_subject" class="text-black">아이디 </label> <input
										type="text" class="form-control" id="c_subject"
										name="member_id">
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-12">
									<label for="c_message" class="text-black">패스워드 </label> <input
										type="password" class="form-control" id="c_subject"
										name="member_pw">
								</div>
							</div>

							<div class="form-group row">
								<div class="col-lg-12">
									<input type="submit" class="btn btn-primary btn-lg btn-block"
										value="로그인">
								</div>
							</div>
							<div class="border p-3">
								<h3 class="h6 mb-0Login">
									<a href="${contextPath}/member/memberForm.do">회원가입</a> / 
									<a data-toggle="collapse"
										href="#collapsepaypal" role="button" aria-expanded="false"
										aria-controls="collapsepaypal">아이디 찾기</a> / 
									<a data-toggle="collapse"
										href="#collapsepaypal" role="button" aria-expanded="false"
										aria-controls="collapsepaypal">비밀번호 찾기</a>	
								</h3>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>