<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<%@ include file="../common/body.jspf"%>
<section class="mt-24 px-4 text-xl">
  <div class="max-w-md mx-auto bg-white shadow-lg rounded-lg p-8">
    <h1 class="text-2xl font-bold mb-6 text-center">로그인</h1>
    <form action="../member/doLogin" method="POST" class="space-y-4">
      <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
      
      <div class="flex flex-col">
        <label for="loginId" class="mb-2 text-gray-700">아이디</label>
        <input class="input input-bordered w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" 
               name="loginId" id="loginId" autocomplete="off" type="text" placeholder="아이디를 입력해" required />
      </div>

      <div class="flex flex-col">
        <label for="loginPw" class="mb-2 text-gray-700">비밀번호</label>
        <input class="input input-bordered w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" 
               name="loginPw" id="loginPw" autocomplete="off" type="password" placeholder="비밀번호를 입력해" required />
      </div>

      <div class="flex justify-center mt-6">
        <button class="btn btn-dark w-full py-2 rounded-lg text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
          로그인
        </button>
      </div>


      <div class="flex justify-between mt-4 text-sm items-center">
        <div class="flex space-x-4">
          <a class="text-blue-500 hover:underline" href="${rq.findLoginIdUri}">아이디 찾기</a>
          <a class="text-blue-500 hover:underline" href="${rq.findLoginPwUri}">비밀번호 찾기</a>
        </div>
        <button class="btn text-blue-600 hover:underline" type="button" onclick="history.back()">뒤로가기</button>
      </div>
    </form>
  </div>
</section>

<%@ include file="../common/foot.jspf"%>
