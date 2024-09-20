<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>
<!DOCTYPE html>
<%@ include file="../common/body.jspf" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${category} - 상품 목록</title>
    <!-- Tailwind CSS for basic styling -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .category-link {
            @apply text-gray-700 hover:text-blue-600 font-semibold;
        }
        .category-link.selected {
            @apply text-blue-600;
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-6">
        <!-- Add your header content here -->
    </div>

    <main class="container mx-auto p-6">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">${category} 상품 목록</h1>

        <c:if test="${not empty searchKeyword}">
            <h2 class="text-2xl font-semibold text-gray-700 mb-4">${searchKeyword}에 대한 검색 결과입니다:</h2>
        </c:if>

        <c:if test="${not empty errorMsg}">
            <div class="bg-red-100 text-red-800 p-4 rounded-lg mb-6">
                ${errorMsg}
            </div>
        </c:if>

        <div class="mb-6">
            <div class="flex space-x-4">
                <c:forEach var="cat" items="${categories}">
                    <a href="<c:url value='/products?category=${cat}'/>" class="category-link ${category == cat ? 'selected' : ''}">
                        ${cat}
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="product" items="${productList}">
                <a href="<c:url value='/product/article/detail?id=${product.id}'/>" class="block bg-white p-4 rounded-lg shadow-lg hover:shadow-xl transition-shadow duration-300">
                    <img src="<c:url value='/images/${product.productId}.jpg'/>" alt="${product.name}" class="w-full h-48 object-cover rounded-t-lg mb-4">
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">${product.name}</h2>
                    <p class="text-gray-600 mb-4">${product.description}</p>
                    <p class="text-lg font-bold text-red-500 mb-4">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩" />
                    </p>
                </a>
            </c:forEach>
        </div>
    </main>

    <footer class="bg-white shadow mt-6">
        <div class="container mx-auto p-6">
            <!-- Add your footer content here -->
        </div>
    </footer>
    <%@ include file="../common/foot.jspf" %>
</body>
</html>