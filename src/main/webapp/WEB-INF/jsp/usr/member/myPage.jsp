<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원정보"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />

<section class="mt-24 text-xl px-4">
    <div class="mx-auto max-w-4xl bg-white shadow-md rounded-lg overflow-hidden" style="max-width: 600px;">
        <h2 class="text-center mb-6">회원 정보</h2>
        <div class="form-group mb-4">
            <label for="regDate" class="block font-bold mb-2">가입일</label>
            <input class="input input-bordered w-full" id="regDate" type="text" value="${rq.loginedMember.regDate}" readonly />
        </div>
        <div class="form-group mb-4">
            <label for="loginId" class="block font-bold mb-2">아이디</label>
            <input class="input input-bordered w-full" id="loginId" type="text" value="${rq.loginedMember.loginId}" readonly />
        </div>
        <div class="form-group mb-4">
            <label for="name" class="block font-bold mb-2">이름</label>
            <input class="input input-bordered w-full" id="name" type="text" value="${rq.loginedMember.name}" readonly />
        </div>
        <div class="form-group mb-4">
            <label for="nickname" class="block font-bold mb-2">닉네임</label>
            <input class="input input-bordered w-full" id="nickname" type="text" value="${rq.loginedMember.nickname}" readonly />
        </div>
        <div class="form-group mb-4">
            <label for="email" class="block font-bold mb-2">이메일</label>
            <input class="input input-bordered w-full" id="email" type="text" value="${rq.loginedMember.email}" readonly />
        </div>
        <div class="form-group mb-4">
            <label for="cellphoneNum" class="block font-bold mb-2">전화번호</label>
            <input class="input input-bordered w-full" id="cellphoneNum" type="text" value="${rq.loginedMember.cellphoneNum}" readonly />
        </div>
        <div class="text-center mt-6 flex justify-between items-center">
            <a href="../member/checkPw" class="btn btn-dark py-2 px-4 rounded-lg text-white bg-blue-600 hover:bg-blue-700 transition">회원정보 수정</a>
            <button class="btn py-2 px-4 rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-200 transition" type="button" onclick="history.back()">뒤로가기</button>
        </div>
    </div>
</section>

<%@ include file="../common/foot.jspf"%>