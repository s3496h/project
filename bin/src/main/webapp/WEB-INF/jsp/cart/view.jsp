<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- ì¶ê°: JSTL íê·¸ ë¼ì´ë¸ë¬ë¦¬ í¬í¨ -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mx-auto my-10">
        <h1 class="text-2xl font-bold mb-5">Your Cart</h1>

        <c:if test="${not empty cartItems}">
            <table class="table-auto w-full mb-5">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="px-4 py-2">Product Name</th>
                        <th class="px-4 py-2">Quantity</th>
                        <th class="px-4 py-2">Price</th>
                        <th class="px-4 py-2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr class="bg-gray-100">
                            <td class="border px-4 py-2">${item.productName}</td>
                            <td class="border px-4 py-2">${item.quantity}</td>
                            <td class="border px-4 py-2">${item.productPrice}</td>
                            <td class="border px-4 py-2">
                                <form action="cart/remove" method="post">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <input type="hidden" name="memberId" value="${item.memberId}">
                                    <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded">Remove</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <form action="order/checkout" method="post">
                <input type="hidden" name="memberId" value="${cartItems[0].memberId}">
                <input type="hidden" name="totalAmount" value="${TotalPrice}"> <!-- totalAmount íì¸ -->
                <button type="submit" class="bg-green-500 text-white px-3 py-2 rounded">Checkout</button>
            </form>
        </c:if>

        <c:if test="${empty cartItems}">
            <p>Your cart is empty.</p>
        </c:if>
    </div>
</body>
</html>