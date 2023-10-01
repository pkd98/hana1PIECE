<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/style/styles.css">
    <link rel="stylesheet" href="resources/style/font.css">
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!-- animation cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <!-- fabicon -->
    <link rel="icon" href="/resources/img/favicon.png">
    <!-- ajax -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>하나1PIECE</title>
</head>

<body>
<%@ include file="include/header.jsp" %>
<main>
    <!-- jumbotron -->
    <div id="jumbotron">
        <div class="jumbotron">

            <div class="jumbotron_el">
                <h1 class="display-6">신뢰받는 부동산 조각투자</h1>
                <h1 class="display-5">이젠,<img class="animate__animated animate__pulse animate__repeat-3"
                                              src="/resources/img/hana1piece_letter.png">에서!</h1>
                <p>※ 원금 손실 가능 및 투자자 귀속</p>
                <p class="lead">
                    <a class="btn btn-primary btn-lg" href="/estate-list" role="button">투자하기!</a>
                </p>
            </div>
            <div class="jumbotron_el">
                <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3500">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="/resources/img/lotterTower.jpg" alt="">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="/resources/img/paju1.jpeg" alt="">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="/resources/img/xii1.jpeg" alt="">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</main>

<aside>
    <a href="/account-opening">
        <img src="/resources/img/banner1.png" alt="banner">

    </a>
    <a href="/event">
        <img src="/resources/img/banner2.png" alt="banner">
    </a>
</aside>

<%@ include file="include/footer.jsp" %>

<!-- jQuery and Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
        integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
        crossorigin="anonymous"></script>

</body>

</html>