<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.code } LIST"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<%@ include file="../common/body.jspf"%>



<!-- 게시글 리스트 및 검색 폼 -->
<section class="mt-8 px-4">
    <div class="max-w-7xl mx-auto bg-white rounded-lg overflow-hidden">

        <!-- 검색 폼 및 글 작성 버튼 -->
        <div class="p-4 border-b border-gray-200">
            <div class="flex items-center justify-between mb-4">
                <div class="flex items-center space-x-4">
                    <div class="text-lg font-medium text-gray-700">${articlesCount }개</div>
                    <form action="" class="flex items-center space-x-4">
                        <input type="hidden" name="boardId" value="${param.boardId }" />
                        <select class="form-select border-gray-300" name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode }">
                            <option value="title">제목</option>
                            <option value="body">내용</option>
                            <option value="title,body">제목+내용</option>
                            <option value="writer">작성자</option>
                        </select>
                        <input type="text" placeholder="검색어 입력" name="searchKeyword" value="${param.searchKeyword }" class="form-input border-gray-300 rounded-md" />
                        <button type="submit" class="btn btn flex items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="h-5 w-5 text-gray-600">
                                <path fill-rule="evenodd" d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z" clip-rule="evenodd" />
                            </svg>
                        </button>
                    </form>
                </div>
                <!-- 글 작성 버튼 -->
                <a class="btn btn-outline btn-dark" href="../article/write">글 작성</a>
            </div>
        </div>

        <!-- 게시글 리스트 테이블 -->
         <div class="p-4">
            <table class="w-full border border-gray-200 rounded-lg">
                <thead class="text-left bg-white">
                    <tr>
                        <th class="p-3 text-left">ID</th>
                        <th class="p-3 text-left">등록일</th>
                        <th class="p-3 text-left">제목</th>
                        <th class="p-3 text-left">작성자</th>
                        <th class="p-3 text-center">좋아요</th>
                        <th class="p-3 text-center">싫어요</th>
                    </tr>
                </thead>
                <tbody class="text-gray-700">
                    <c:forEach var="article" items="${articles}">
                        <tr class="hover:bg-gray-100 transition-colors">
                            <td class="p-3">${article.id}</td>
                            <td class="p-3">${article.regDate.substring(0,10)}</td>
                            <td class="p-3">
                                <a class="text-blue-600 hover:underline" href="detail?id=${article.id}">
                                    ${article.title}
                                    <c:if test="${article.extra__repliesCount > 0 }">
                                        <span class="text-red-500">[${article.extra__repliesCount }]</span>
                                    </c:if>
                                </a>
                            </td>
                            <td class="p-3">${article.extra__writer}</td>
                            <td class="p-3 text-center">${article.goodReactionPoint}</td>
                            <td class="p-3 text-center">${article.badReactionPoint}</td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty articles}">
                        <tr>
                            <td colspan="6" class="p-3 text-center text-gray-500">게시글이 없습니다</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="p-4">
            <div class="flex justify-center">
                <ul class="inline-flex items-center">
                <c:set var="paginationLen" value="3" />
                <c:set var="startPage" value="${page - paginationLen >= 1 ? page - paginationLen : 1}" />
                <c:set var="endPage" value="${page + paginationLen <= pagesCount ? page + paginationLen : pagesCount}" />

                <c:set var="baseUri" value="?boardId=${boardId }" />
                <c:set var="baseUri" value="${baseUri }&searchKeywordTypeCode=${searchKeywordTypeCode}" />
                <c:set var="baseUri" value="${baseUri }&searchKeyword=${searchKeyword}" />

                <!-- 이전 페이지 버튼 -->
                <c:if test="${page > 1 }">
                    <a class="btn btn" href="${ baseUri}&page=${page - 1 }">« 이전</a>
                </c:if>

                <!-- 페이지 번호 버튼 -->
                <c:forEach begin="${startPage }" end="${endPage }" var="i">
                    <a class="btn ${param.page == i ? 'btn-active' : 'btn'}" href="${ baseUri}&page=${i }">${i }</a>
                </c:forEach>

                <!-- 다음 페이지 버튼 -->
                <c:if test="${page < pagesCount }">
                    <a class="btn btn" href="${ baseUri}&page=${page + 1 }">다음 »</a>
                </c:if>
               </ul>
            </div>
        </div>
    </div>
</section>

<%@ include file="../common/foot.jspf"%>