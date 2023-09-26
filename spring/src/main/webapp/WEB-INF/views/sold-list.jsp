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
        <h2>매각된 매물</h2>
        <hr>
    </div>

    <div class="container mt-5">
        <div class="row">

            <c:forEach var="item" items="${soldEstateListDTO}">

            <!-- 매물 1 -->
            <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                <img src="/resources/upload/${item.listingNumber}/${item.image1}" alt="부동산 이미지" class="img-fluid">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${item.buildingName}</h5>
                        <div class="text-right">
                            <p class="small text-muted mb-1">매각일</p>
                            <p>${item.soldDate}</p>
                        </div>
                        <div class="text-right">
                            <p class="small text-muted mb-1">청약 모집액</p>
                            <p class="formatted-number">${item.publicationAmount}원</p>
                        </div>
                        <div class="text-right">
                            <p class="small text-muted mb-1">매각액</p>
                            <p class="formatted-number">${item.amount}원</p>
                        </div>
                        <div class="text-right">
                            <p class="small text-muted mb-1">1STO 당 매각 배당금</p>
                            <p class="formatted-number">${item.dividend}원</p>
                        </div>
                    </div>
                </div>
            </div>

            </c:forEach>

        </div>
    </div>



<%@ include file="include/footer.jsp" %>

<script>
    function formatNumbers() {
        $('.formatted-number').each(function () {
            var number = $(this).text();
            var formattedNumber = numberWithCommas(number);
            $(this).text(formattedNumber);
        });
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    $(document).ready(function () {
        /**
         *  금액 천단위 구분 쉼표 추가
         */
        formatNumbers();
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