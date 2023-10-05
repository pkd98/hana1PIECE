<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/account-opening.css">
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
    <h2>계좌 개설</h2>
    <hr>
</div>

<div class="account-opening">
    <div class="account-opening-title">
        <h2>새로운 계좌 만들기</h2>
    </div>

    <div class="custom-div">
        <div class="imgContainer">
            <img src="/resources/img/account02.png" alt="계좌 이미지">
        </div>
        <div class="text-content">
            <h4>종합 계좌 개설</h4>
            <p>하나은행 계좌 개설 후 지갑과 연동하여 서비스를 이용할 수 있습니다.</p>
        </div>
    </div>

    <div class="account-opening-title">
        <h2>기존 하나은행 계좌 연동</h2>
    </div>
    <div class="custom-div" style="background-color: #DEE2E6;">
        <div class="imgContainer">
            <img src="/resources/img/account01.png" alt="계좌 이미지">
        </div>
        <div class="text-content" style="color: black;">
            <h4>기존 계좌 연동</h4>
            <p>소유하고 계신 기존 하나은행 계좌를 지갑과 연동합니다.</p>
        </div>
    </div>
</div>


<%@ include file="include/footer.jsp" %>

<script>
    var customDiv = document.querySelector(".custom-div");

    customDiv.addEventListener("click", function () {
        // 페이지 이동
        window.location.href = "/accountOpeningProcess1";
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