<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/public-offering-list.css">
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
    <h2>청약</h2>
    <hr>
</div>

<c:forEach items="${publicOfferingList}" var="item">
    <div class="public-offering-wrapper mt-5">
        <img src="/resources/upload/${item.listingNumber}/${item.image1}" alt="부동산 이미지" class="img-fluid">
        <div class="card clickable-card" data-listing="${item.listingNumber}">
            <div class="card-body">
                <h5 class="card-title">${item.buildingName}</h5>
                <p class="text-danger mb-2">${item.introduction}</p>
                <div class="text-right">
                    <p class="small text-muted mb-1">1 STO 공모가</p>
                    <p>5,000원</p>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<%@ include file="include/footer.jsp" %>

<script>
    /**
     *  카드 요소 누르면 상세 페이지 이동
     */
    $(document).ready(function () {
        $(".clickable-card").click(function () {
            var listingNumber = $(this).data("listing");
            window.location.href = "/public-offering/" + listingNumber;
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