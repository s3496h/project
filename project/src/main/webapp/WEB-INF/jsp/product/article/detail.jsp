<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../common/head.jspf"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${product.name}-상세정보</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
	<%@ include file="../common/body.jspf"%>

	<div class="w-full p-0">
		<!-- Center and limit the width of the functional section -->
		<div class="max-w-4xl mx-auto p-6 bg-white shadow-md rounded-lg">
			<!-- Updated classes here -->
			<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
				<div>
					<img src="<c:url value='/images/${product.productId}.jpg'/>" alt="${product.name}"
						class="w-full h-auto rounded-lg shadow-md">
				</div>

				<div>
					<h1 class="text-4xl font-bold text-gray-800 mb-4">${product.name}</h1>
					<p class="text-gray-600 text-lg mb-4">${product.description}</p>

					<div class="text-2xl font-semibold text-red-500 mb-6">
						가격:
						<fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩" />
					</div>

					<div class="mb-4">
						<label for="size" class="block text-sm font-medium text-gray-700">사이즈</label> <select id="size" name="size"
							class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
							<c:forEach var="size" items="${product.sizes}">
								<option value="${size}">${size}</option>
							</c:forEach>
						</select>
					</div>

					<div class="mb-4">
						<label for="color" class="block text-sm font-medium text-gray-700">색상</label> <select id="color" name="color"
							class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
							<c:forEach var="color" items="${product.colors}">
								<option value="${color}">${color}</option>
							</c:forEach>
						</select>
					</div>

					<form action="<c:url value='/cart/add'/>" method="post">
						<input type="hidden" name="productId" value="${product.productId}"> <input type="hidden" name="quantity"
							value="1">
						<button type="submit"
							class="w-full bg-indigo-600 text-white font-semibold py-3 rounded-lg hover:bg-indigo-700 transition duration-300">
							장바구니에 담기</button>
					</form>

					<div class="mt-6">
						<span class="text-gray-700 font-semibold">공유하기:</span> <a
							href="https://www.facebook.com/sharer/sharer.php?u=https://example.com/product/${product.productId}"
							class="text-blue-500 hover:text-blue-700 ml-4" target="_blank"> <i class="fab fa-facebook fa-lg"></i>
						</a> <a
							href="https://twitter.com/intent/tweet?url=https://example.com/product/${product.productId}&text=Check%20out%20this%20product!"
							class="text-blue-300 hover:text-blue-500 ml-4" target="_blank"> <i class="fab fa-twitter fa-lg"></i>
						</a> <a href="https://www.instagram.com/" class="text-pink-500 hover:text-pink-700 ml-4" target="_blank"> <i
							class="fab fa-instagram fa-lg"></i>
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Review Section -->
		<div class="max-w-4xl mx-auto p-6 mt-8 bg-white shadow-md rounded-lg">
			<h2 class="text-3xl font-bold mb-4">리뷰</h2>

			<c:if test="${not empty reviews}">
				<ul class="space-y-4">
					<!-- Display reviews dynamically -->
					<c:forEach var="review" items="${reviews}">
						<li class="border border-gray-300 rounded-lg p-4 shadow-md bg-white"><strong>${review.userName}</strong>
						<li class="border border-gray-300 rounded-lg p-4 shadow-md bg-white"><strong>${review.writerNickname}</strong>
							<div class="flex items-center mt-1">
								<!-- Star Rating Display -->
								<c:forEach var="i" begin="1" end="5">
									<i
										class="<c:choose>
                                    <c:when test='${i <= review.rating}'>
                                        fas fa-star text-yellow-500
                                    </c:when>
                                    <c:otherwise>
                                        far fa-star text-gray-300
                                    </c:otherwise>
                                </c:choose>"></i>
								</c:forEach>
							</div>
							<p class="mt-2">${review.content}</p></li>
					</c:forEach>
				</ul>

<!-- Pagination Controls -->
<div class="flex items-center justify-center mt-6 space-x-2">
    <!-- First Page -->
    <c:if test="${page > 1}">
        <a href="?id=${product.id}&page=1" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">처음</a>
    </c:if>

    <!-- Previous Page -->
    <c:if test="${page > 1}">
        <a href="?id=${product.id}&page=${page - 1}" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">이전</a>
    </c:if>

    <!-- Page Number Links -->
    <c:choose>
        <c:when test="${totalPages <= 5}">
            <!-- Show all page numbers if 5 or fewer pages -->
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == page}">
                        <span class="bg-indigo-500 text-white px-4 py-2 rounded-full border border-indigo-500 font-semibold">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?id=${product.id}&page=${i}" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- Show a fixed range of 5 pages -->
            <c:choose>
                <c:when test="${page <= 3}">
                    <!-- For pages 1-3, show pages 1-5 -->
                    <c:forEach var="i" begin="1" end="5">
                        <c:choose>
                            <c:when test="${i == page}">
                                <span class="bg-indigo-500 text-white px-4 py-2 rounded-full border border-indigo-500 font-semibold">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?id=${product.id}&page=${i}" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <!-- Ellipsis if there are more pages after -->
                    <c:if test="${totalPages > 5}">
                        <span class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300">...</span>
                    </c:if>
                </c:when>
                <c:when test="${page > 3 && page < totalPages - 2}">
                    <!-- Show pages around the current page -->
                    <c:if test="${page > 4}">
                        <span class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300">...</span>
                    </c:if>
                    <c:forEach var="i" begin="${page - 2}" end="${page + 2}">
                        <c:choose>
                            <c:when test="${i == page}">
                                <span class="bg-indigo-500 text-white px-4 py-2 rounded-full border border-indigo-500 font-semibold">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?id=${product.id}&page=${i}" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${page < totalPages - 3}">
                        <span class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300">...</span>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <!-- For pages at the end, show the last 5 pages -->
                    <c:if test="${totalPages > 5}">
                        <span class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300">...</span>
                    </c:if>
                    <c:forEach var="i" begin="${totalPages - 4}" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == page}">
                                <span class="bg-indigo-500 text-white px-4 py-2 rounded-full border border-indigo-500 font-semibold">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?id=${product.id}&page=${i}" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>

    <!-- Next Page -->
    <c:if test="${page < totalPages}">
        <a href="?id=${product.id}&page=${page + 1}" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">다음</a>
    </c:if>

    <!-- Last Page -->
    <c:if test="${page < totalPages}">
        <a href="?id=${product.id}&page=${totalPages}" class="bg-gray-100 text-gray-800 px-4 py-2 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors duration-300">마지막</a>
    </c:if>
</div>
		</c:if>	
			<c:if test="${empty reviews}">
				<p class="text-gray-500">리뷰가 없습니다.</p>
			</c:if>

			<!-- Add Review Section -->
			<c:if test="${rq.isLogined()}">
				<h2 class="text-2xl font-semibold mt-8 mb-4">리뷰 추가</h2>
				<form action="${pageContext.request.contextPath}/reviews/add" method="post" class="space-y-4">
					<input type="hidden" name="productId" value="${product.id}"> 
					<input type="text" name="userName"placeholder="이름을 입력하세요" required class="w-full border border-gray-300 rounded-md p-2">
					<input type="text" name="writerNickname"placeholder="닉네임을 입력하세요" required class="w-full border border-gray-300 rounded-md p-2">
					<textarea name="content" placeholder="리뷰를 입력하세요" required class="w-full border border-gray-300 rounded-md p-2"></textarea>

					<!-- Star Rating Selection -->
					<div class="flex items-center space-x-2">
						<input type="hidden" name="rating" id="rating" value="0">
						<!-- This hidden field stores the selected rating -->
						<div class="flex space-x-1" id="star-rating">
							<!-- Star icons -->
							<i class="far fa-star text-gray-300 cursor-pointer text-2xl" data-value="1"></i> <i
								class="far fa-star text-gray-300 cursor-pointer text-2xl" data-value="2"></i> <i
								class="far fa-star text-gray-300 cursor-pointer text-2xl" data-value="3"></i> <i
								class="far fa-star text-gray-300 cursor-pointer text-2xl" data-value="4"></i> <i
								class="far fa-star text-gray-300 cursor-pointer text-2xl" data-value="5"></i>
						</div>
					</div>

					<button type="submit"
						class="w-full bg-indigo-600 text-white font-semibold py-2 rounded-lg hover:bg-indigo-700 transition duration-300">
						리뷰 추가</button>
				</form>
			</c:if>

			<c:if test="${empty rq.loginedMember}">
				<p class="text-red-500 mt-4">로그인 후에 리뷰를 작성할 수 있습니다.</p>
			</c:if>
		</div>

		<!-- JavaScript for Interactive Star Rating -->
		<script>
    document.addEventListener('DOMContentLoaded', function() {
        const stars = document.querySelectorAll('#star-rating i');
        const ratingInput = document.getElementById('rating');

        // Add click event to each star
        stars.forEach(star => {
            star.addEventListener('click', function() {
                const ratingValue = this.getAttribute('data-value');
                ratingInput.value = ratingValue;

                // Update star colors
                stars.forEach(s => {
                    if (s.getAttribute('data-value') <= ratingValue) {
                        s.classList.remove('far'); // Unfilled star
                        s.classList.add('fas');    // Filled star
                        s.classList.add('text-yellow-500'); // Yellow color
                    } else {
                        s.classList.remove('fas'); // Filled star
                        s.classList.add('far');    // Unfilled star
                        s.classList.remove('text-yellow-500'); // Remove yellow color
                        s.classList.add('text-gray-300'); // Gray color
                    }
                });
            });
        });
    });
</script>
		<%@ include file="../common/foot.jspf"%>