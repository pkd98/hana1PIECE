<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/estate-list.css">
    <link rel="stylesheet" href="/resources/style/font.css">
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!-- animation cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <!-- fabicon -->
    <link rel="icon" href="/resources/img/favicon.png">
    <!-- ajax -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>하나1PIECE</title>
</head>

<body>

<%@ include file="include/header.jsp" %>

<div class="titleBar">
    <h2>부동산 매물</h2>
    <hr>
</div>

<div class="container mt-5">
    <div class="row">
        <c:forEach var="item" items="${listedEstateList}">
            <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                <img src="/resources/upload/${item.listingNumber}/${item.image1}" alt="부동산 이미지" class="img-fluid">
                <div class="card clickable-card" data-listing="${item.listingNumber}">
                    <div class="card-body">
                        <h5 class="card-title">${item.buildingName}</h5>

                        <c:set var="percentageDifference"
                               value="${((item.price - item.reasonablePrice) / item.reasonablePrice) * 100}"/>

                        <p class="text-danger small mb-2">
                            <c:choose>
                                <c:when test="${percentageDifference <= -10}">매우 저평가</c:when>
                                <c:when test="${percentageDifference > -10 && percentageDifference <= -5}">저평가</c:when>
                                <c:when test="${percentageDifference > -5 && percentageDifference <= 5}">적정가</c:when>
                                <c:when test="${percentageDifference > 5 && percentageDifference <= 10}">고평가</c:when>
                                <c:otherwise>매우 고평가</c:otherwise>
                            </c:choose>
                        </p>
                        <div class="text-right">
                            <p class="small text-muted mb-1">1 STO 가격</p>
                            <p>${item.price}원</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
<script>
    /**
     *  카드 요소 누르면 상세 페이지 이동
     */
    $(document).ready(function () {
        $(".clickable-card").click(function () {
            var listingNumber = $(this).data("listing");
            window.location.href = "/estate-list/" + listingNumber;
        });
    });
</script>

<!-- jQuery and Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
        integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
        crossorigin="anonymous"></script>
</body>

</html>