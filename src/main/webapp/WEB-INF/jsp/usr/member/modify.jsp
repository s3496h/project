<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MODIFY"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />

<script type="text/javascript">
	function MemberModify__submit(form) {
		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호 확인을 입력해 주세요.');
				return;
			}

			if (form.loginPwConfirm.value != form.loginPw.value) {
				alert('비밀번호가 일치하지 않습니다.');
				return;
			}
		}

		form.submit();
	}
</script>

<section class="mt-24 text-xl px-4">
	<div class="mx-auto max-w-4xl bg-white shadow-md rounded-lg overflow-hidden" style="max-width: 600px;">
		<h2 class="text-center mb-6">회원정보 수정</h2>
		<form onsubmit="MemberModify__submit(this); return false;" action="../member/doModify" method="POST">
			<div class="form-group mb-4">
				<label for="regDate" class="block font-bold mb-2">가입일</label>
				<input class="input input-bordered w-full" id="regDate" type="text" value="${rq.loginedMember.regDate}" readonly />
			</div>
			<div class="form-group mb-4">
				<label for="loginId" class="block font-bold mb-2">아이디</label>
				<input class="input input-bordered w-full" id="loginId" type="text" value="${rq.loginedMember.loginId}" readonly />
			</div>
			<div class="form-group mb-4">
				<label for="loginPw" class="block font-bold mb-2">새 비밀번호</label>
				<input class="input input-bordered w-full" id="loginPw" name="loginPw" type="password" placeholder="새 비밀번호를 입력하세요" autocomplete="off" />
			</div>
			<div class="form-group mb-4">
				<label for="loginPwConfirm" class="block font-bold mb-2">새 비밀번호 확인</label>
				<input class="input input-bordered w-full" id="loginPwConfirm" name="loginPwConfirm" type="password" placeholder="새 비밀번호를 다시 입력하세요" autocomplete="off" />
			</div>
			<div class="form-group mb-4">
				<label for="name" class="block font-bold mb-2">이름</label>
				<input class="input input-bordered w-full" id="name" name="name" type="text" value="${rq.loginedMember.name}" placeholder="이름을 입력하세요" />
			</div>
			<div class="form-group mb-4">
				<label for="nickname" class="block font-bold mb-2">닉네임</label>
				<input class="input input-bordered w-full" id="nickname" name="nickname" type="text" value="${rq.loginedMember.nickname}" placeholder="닉네임을 입력하세요" />
			</div>
			<div class="form-group mb-4">
				<label for="email" class="block font-bold mb-2">이메일</label>
				<input class="input input-bordered w-full" id="email" name="email" type="email" value="${rq.loginedMember.email}" placeholder="이메일을 입력하세요" />
			</div>
			<div class="form-group mb-4">
				<label for="cellphoneNum" class="block font-bold mb-2">전화번호</label>
				<input class="input input-bordered w-full" id="cellphoneNum" name="cellphoneNum" type="text" value="${rq.loginedMember.cellphoneNum}" placeholder="전화번호를 입력하세요" />
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn w-full">수정</button>
			</div>
		</form>
		<div class="text-center mt-4">
			<button class="btn btn" type="button" onclick="history.back()">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>
