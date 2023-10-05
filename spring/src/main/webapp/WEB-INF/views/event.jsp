<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
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
<%@ include file="include/header.jsp" %>

    <div class="titleBar">
        <h2>친구초대 이벤트</h2>
        <hr>
    </div>

    <aside>
        <a href="#">
            <img src="/resources/img/banner2.png" alt="">
        </a>
    </aside>

    <div class="event">
        <h3>내 코드</h3>
        <div>
            <p id="myCode">${sessionScope.member.referralCode}</p>
        </div>
        <button type="button" class="btn btn-primary" onclick="kakaoShare()"><img src="/resources/img/kakao.svg"
                alt="">공유하기</button>
        <h6>나를 추천한 사람 수: ${sessionScope.member.referralCount}</h6>
    </div>


    <%@ include file="include/footer.jsp" %>


    <!-- kakao sdk 호출 -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

    <!-- 공유하기 기능 구현 -->
    <script type="text/javascript">
        // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('5082aba073eeee4dbd5606104fd17280');

        // SDK 초기화 여부를 판단합니다.
        console.log(Kakao.isInitialized());

        function kakaoShare() {
            var code = document.getElementById("myCode").textContent;

            Kakao.Link.sendDefault({
                objectType: 'feed',
                content: {
                    title: '하나1PIECE',
                    description: '지금바로 건물주가 되어보세요! \n' + '추천인 코드:' + code,
                    imageUrl: 'https://raw.githubusercontent.com/pkd98/hana1PIECE/a6f34790baf143f6cfc04afb534caa5a76e4df8d/spring/src/main/webapp/resources/img/event_share_img.jpeg?token=GHSAT0AAAAAACEYJYU7XCMW2BDIJZ7HYVUMZHOSLFQ',
                    link: {
                        mobileWebUrl: 'http://127.0.0.1:5501/WEB-INF/views/estate-list.html',
                        webUrl: 'http://127.0.0.1:5501/WEB-INF/views/estate-list.html',
                    },
                },
                buttons: [
                    {
                        title: '지금 건물주 되기!',
                        link: {
                            mobileWebUrl: 'http://127.0.0.1:5501/WEB-INF/views/estate-list.html',
                            webUrl: 'http://127.0.0.1:5501/WEB-INF/views/estate-list.html',
                        },
                    },
                ],
                // 카카오톡 미설치 시 카카오톡 설치 경로이동
                installTalk: true,
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