<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="CHECKPW"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<%@ include file="../common/body.jspf"%>

<!-- 비밀번호 확인 페이지 -->
<section class="mt-24 px-4 text-xl">
  <div class="max-w-md mx-auto bg-white shadow-lg rounded-lg p-8">
	<h2 class="text-center" style="margin: 0 0 10px 0; text-align: left;">회원정보 수정</h2>
<p class="text-center" style="margin: 0 0 20px 0; text-align: left;">회원님의 정보를 수정하기 위해 비밀번호를 입력해주세요.</p>
		<form action="../member/doCheckPw" method="POST">
			<table class="table" style="width: 100%;">
				<tbody>
					<tr>
						<th style="text-align: left; padding-right: 10px;">아이디</th>
						<td style="text-align: left;">${rq.loginedMember.loginId}</td>
					</tr>
					<tr>
						<th style="text-align: left; padding-right: 10px;">비밀번호</th>
						<td>
							<input class="input input-bordered input w-full" name="loginPw" autocomplete="off" type="password" placeholder="비밀번호를 입력해주세요" required />
						</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-4 text-center">
				<button type="submit" class="btn btn-dark w-full">비밀번호 확인</button>
			</div>
		</form>
<div class="mt-4" style="text-align: left;">
    <button class="btn btn-dark" type="button" onclick="history.back()">뒤로가기</button>
</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>