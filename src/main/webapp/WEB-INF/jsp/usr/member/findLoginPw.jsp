<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>
<hr/>
<script type="text/javascript">
	let MemberFindLoginPw__submitFormDone = false;
	function MemberFindLoginPw__submit(form) {
		if (MemberFindLoginPw__submitFormDone) {
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		form.email.value = form.email.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디 써라');
			form.loginId.focus();
			return;
		}
		if (form.email.value.length == 0) {
			alert('email 써라');
			form.email.focus();
			return;
		}
		MemberFindLoginPw__submitFormDone = true;
		alert('메일로 임시 비밀번호를 발송했습니다');
		form.submit();
	}
</script>
<%@ include file="../common/body.jspf"%>

<section class="mt-24 px-4 text-xl">
	<div class="max-w-md mx-auto bg-white shadow-lg rounded-lg p-8">
	<h1 class="text-2xl font-bold mb-6 text-center">비밀번호 찾기</h1>
		<form action="../member/doFindLoginPw" method="POST" onsubmit="MemberFindLoginPw__submit(this);">
			<input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri  }" />
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<tbody>
					<tr>
						<th>아이디</th>
						<td style="text-align: center;">
							<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text" placeholder="아이디를 입력해주세요"
								name="loginId" />
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td style="text-align: center;">
							<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text" placeholder="이메일을 입력해주세요"
								name="email" />
						</td>
					</tr>
					<tr>
						<th></th>
						<td style="text-align: center;"> 
							<button class="btn btn-dark" type="submit">비밀번호 찾기</button>
						</td>
					</tr>
					<tr>
						<th></th>
						<td style="text-align: center;">
							<a class="btn btn-outline btn-dark" href="../member/login">로그인</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>