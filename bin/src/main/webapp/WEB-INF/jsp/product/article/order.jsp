<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mx-auto my-10">
        <h1 class="text-2xl font-bold mb-5">Order History</h1>

        <c:if test="${not empty orders}">
            <table class="table-auto w-full mb-5">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="px-4 py-2">Order ID</th>
                        <th class="px-4 py-2">Total Amount</th>
                        <th class="px-4 py-2">Order Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr class="bg-gray-100">
                            <td class="border px-4 py-2">${order.orderId}</td>
                            <td class="border px-4 py-2">${order.totalAmount}</td>
                            <td class="border px-4 py-2">${order.orderDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty orders}">
            <p>You have no order history.</p>
        </c:if>
    </div>
</body>
</html>