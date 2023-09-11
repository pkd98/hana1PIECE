<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/manager.css">
    <link rel="stylesheet" href="/resources/style/font.css">
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

    <header>
        <!-- nav bar -->
        <div id="navBar">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light">
                <a class="navbar-brand" href="/manager"><img class="mainLogo" src="/resources/img/logo.png"></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </nav>
        </div>
    </header>

    <div class="titleBar">
        <h2>관리자 로그인</h2>
        <hr>
    </div>

    <div class="login-area">
        <div class="login-container">
            <form action="/manager/login" method="POST">
                <!-- Username input -->
                <div class="mb-3">
                    <label for="id" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="id" aria-describedby="usernameHelp" placeholder="아이디를 입력하세요">
                </div>
                
                <!-- Password input -->
                <div class="mb-3">
                    <label for="password" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="password" placeholder="비밀번호를 입력하세요">
                </div>
                
                <!-- Login button -->
                <div class="button-area">
                    <button type="button" class="btn btn-primary" onclick="requsetPost()">로그인하기</button>
                </div>
            </form>
        </div>    
    </div>

    <script>
        function requsetPost() {
            // 데이터 가져오기
            let id = $("#id").val();
            let password = $("#password").val();

            $.ajax({
                type: "POST",
                url: "/manager/login",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    id: id,
                    password: password
                }),
                success:function (response) {
                    console.log(window.location.origin + "/" + response.value);
                    window.location.href = window.location.origin + "/" + response;
                },
                error:function (error) {}
            })
        }

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