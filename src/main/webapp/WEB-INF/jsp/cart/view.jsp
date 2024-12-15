<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <!-- 메인 컨테이너 -->
    <div class="container mx-auto my-10 p-6 bg-white shadow-lg rounded-lg">
        <!-- 헤더 -->
        <h1 class="text-4xl font-bold text-gray-800 mb-8 text-center">🛒 장바구니</h1>

        <!-- 장바구니 항목 -->
        <c:if test="${not empty cartItems}">
            <div class="overflow-x-auto">
                <table class="table-auto w-full border-collapse border border-gray-300 rounded-lg">
                    <!-- 테이블 헤더 -->
                    <thead class="bg-gray-100">
                        <tr class="text-left text-gray-600">
                            <th class="px-6 py-4 font-semibold">상품명</th>
                            <th class="px-6 py-4 font-semibold">수량</th>
                            <th class="px-6 py-4 font-semibold">가격</th>
                            <th class="px-6 py-4 font-semibold text-center">작업</th>
                        </tr>
                    </thead>
                    <!-- 테이블 본문 -->
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr class="hover:bg-gray-50 border-b border-gray-200">
                                <td class="px-6 py-4 text-gray-800 font-medium">${item.productName}</td>
                                <td class="px-6 py-4 text-gray-700">${item.quantity}</td>
                                <td class="px-6 py-4 text-gray-700">₩ ${item.productPrice}</td>
                                <td class="px-6 py-4 text-center">
                                    <form action="cart/remove" method="post" class="inline-block">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <input type="hidden" name="memberId" value="${item.memberId}">
                                        <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded-full hover:bg-red-600 transition duration-200">
                                            삭제
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 결제 버튼 -->
            <div class="mt-8 flex justify-end items-center space-x-4">
                <form action="order/checkout" method="post" class="inline-block">
                    <input type="hidden" name="memberId" value="${cartItems[0].memberId}">
                    <input type="hidden" name="totalAmount" value="${TotalPrice}">
                    <button type="submit" class="bg-green-500 text-white px-8 py-3 rounded-full shadow-lg hover:bg-green-600 transition duration-200">
                        결제하기
                    </button>
                </form>
            </div>
        </c:if>

        <!-- 빈 장바구니 메시지 -->
        <c:if test="${empty cartItems}">
            <div class="text-center py-20">
                <p class="text-2xl text-gray-600 mb-6">장바구니가 비어 있습니다. 😔</p>
                <a href="/product/article/list" class="bg-blue-500 text-white px-6 py-3 rounded-full hover:bg-blue-600 transition duration-200">
                    상품 보러가기
                </a>
            </div>
        </c:if>
    </div>
</body>
</html>

