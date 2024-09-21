<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />
<%@ include file="../common/body.jspf"%>

<!-- Hero Section with Promotional Overlay -->
<section style="width: 100%; height: 70vh; position: relative; background: url('${pageContext.request.contextPath}/image/image.jpg') no-repeat center center; background-size: cover;">
    <!-- Overlay with promotional message -->
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); display: flex; align-items: center; justify-content: center; text-align: center;">
        <div style="color: white;">
            <h1 style="font-size: 3rem; font-weight: bold; margin-bottom: 1rem;">MyShop에 오신 것을 환영합니다!</h1>
            <p style="font-size: 1.5rem; margin-bottom: 2rem;">최고의 제품을 최고의 가격에 만나보세요.</p>
            <a href="${pageContext.request.contextPath}/product/article/list" style="background-color: #ff9900; padding: 1rem 2rem; color: white; font-size: 1.25rem; text-decoration: none; border-radius: 5px; transition: background-color 0.3s ease;">
지금 쇼핑하세요</a>
        </div>
    </div>
</section>
 <%@ include file="../common/foot.jspf" %>


