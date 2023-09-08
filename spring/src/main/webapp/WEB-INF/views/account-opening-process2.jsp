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

<div class="account-opening-process2">
    <!-- 부트스트랩 페이지네이션 -->
    <ul class="pagination justify-content-center">
        <li class="page-item"><a class="page-link" href="#">1</a></li>
        <li class="page-item active"><a class="page-link" href="#">2</a></li>
    </ul>

    <div class="account-opening-form">
        <!-- 계정 정보 확인 -->
        <div class="section">
            <h3 class="sub-title"><strong>계정 정보 확인</strong></h3>
            <label for="name">이름</label>
            <input type="text" id="name" class="form-control" value="${sessionScope.member.name}" readonly>
            <label for="userid">아이디</label>
            <input type="text" id="userid" class="form-control" value="${sessionScope.member.id}" readonly>
            <label for="email">이메일</label>
            <input type="email" id="email" class="form-control" value="${sessionScope.member.email}" readonly>
        </div>

        <div id="authentication">

            <!-- 휴대폰 인증 -->
            <div class="section">
                <h3 class="sub-title"><strong>휴대폰 인증</strong></h3>
                <input type="text" id="phoneInput" class="form-control" placeholder="01012345678 (-) 제외"
                       style="margin-bottom: 5px;">
                <input type="text" id="phoneCodeInput" class="form-control" placeholder="인증 번호" style="margin-bottom: 10px;"
                       hidden>
                <small id="InvalidPhoneNumber" class="verification-status text-danger" hidden>유효하지 않은 전화번호입니다.</small>
                <small id="InvalidCode" class="verification-status text-danger" hidden>인증실패. 다시 시도해주세요.</small>
                <small id="validCode" class="verification-status text-success" hidden>인증되었습니다.</small>
                <button id="requestCodeButton" class="btn btn-secondary"
                        style="background-color: #008485; margin-bottom: 5px; margin-top: 5px;">인증번호요청
                </button>
                <button id="phoneCodeSubmitButton" class="btn btn-primary" style="background-color: #E90061;" hidden>확인
                </button>
            </div>

            <!-- 본인 인증 -->
            <div class="section">
                <h3 class="sub-title"><strong>본인 인증</strong></h3>
                <div class="mb-3">
                    <label for="formFile" class="form-label">신분증 파일을 업로드 해주세요.</label>
                    <input class="form-control" type="file" id="formFile">
                    <button id="ocrButton" class="btn btn-secondary"
                            style="width:100%; background-color: #008485; margin-bottom: 1px; margin-top: 5px;">업로드
                    </button>
                </div>
                <div class="RRNContainer" hidden>
                    <input id="registrationNumber1" type="text" class="form-control" placeholder="생년월일"> <span>-</span>
                    <input id="registrationNumber2" type="text" class="form-control" placeholder="주민등록번호 뒷자리">
                </div>
                <small id="InvalidRecognize" class="verification-status text-danger" hidden>인증실패. 다시 시도해주세요.</small>
                <small id="validRecognize" class="verification-status text-success" hidden>인증되었습니다.</small>
            </div>


        </div>

        <div id="account-wallet-container" hidden>

            <!-- 계좌 정보 -->
            <div class="section">
                <h3 class="sub-title"><strong>계좌 정보</strong></h3>
                <label for="account">신청계좌</label>
                <input type="text" id="account" class="form-control" value="하나1PIECE 종합매매 계좌" readonly>
                <br>
                <label for="accountPw1">계좌 비밀번호 설정(숫자 4자리)</label>
                <input id="accountPw1" type="password" class="form-control" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                <label for="accountPw2">계좌 비밀번호 확인</label>
                <input id="accountPw2" type="password" class="form-control" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                <small id="accountPwMismatch" class="password-status text-danger" hidden>비밀번호가 다릅니다.</small>
                <small id="accountPwMatch" class="password-status text-success" hidden>비밀번호가 일치합니다.</small>
            </div>

            <!-- 지갑 연동 -->
            <div class="section">
                <h3 class="sub-title"><strong>지갑 연동</strong></h3>

                <label for="walletPw1">지갑 비밀번호 설정 (숫자 4자리)</label>
                <input type="password" id="walletPw1" class="form-control" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                <label for="walletPw2">지갑 비밀번호 확인</label>
                <input type="password" id="walletPw2" class="form-control" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                <small id="walletPwMismatch" class="password-status text-danger" hidden>비밀번호가 다릅니다.</small>
                <small id="walletPwMatch" class="password-status text-success" hidden>비밀번호가 일치합니다.</small>
                <br>
                <label for="referral">추천인 이벤트 코드</label>
                <input type="text" id="referral" class="form-control">
            </div>
        </div>

    </div>


    <!-- 다음 버튼 -->
    <div class="button-wrapper">
        <button id="beforeBtn" class="btn btn-primary" style="margin-right: 10px;" onclick="goToBefore()">이전</button>
        <button id="completeAccountOpening" class="btn btn-primary" disabled onclick="">계좌개설</button>
    </div>
</div>


<%@ include file="include/footer.jsp" %>

<script>
    // 유효성 통화 체크용 변수
    let authenticationCheck = 0;
    let accountCheck = 0;
    let walletCheck = 0;

    $(document).ready(function () {
        /**
         * 휴대폰 인증번호 요청 버튼 클릭
         */
        $("#requestCodeButton").click(function () {
            let phone = $("#phoneInput").val();

            if (phone) {
                $.ajax({
                    type: 'GET',
                    url: '/sms',
                    data: {
                        phone: phone
                    },
                    success: function () {
                        // 인증번호 입력창 띄우기
                        $("#phoneCodeInput").removeAttr("hidden");
                        document.getElementById("requestCodeButton").disabled = true;
                        document.getElementById("phoneCodeSubmitButton").hidden = false;
                    },
                    error: function (error) {
                        // 유효하지 않은 휴대전화
                        $("#InvalidPhoneNumber").removeAttr("hidden");
                    }
                });

            } else {
                alert("휴대폰 번호를 입력해주세요.");
            }
        });

        /**
         *  휴대폰 인증번호 확인 버튼 클릭
         */
        $("#phoneCodeSubmitButton").click(function () {
            let code = $("#phoneCodeInput").val();

            if (code) {
                $.ajax({
                    type: 'POST',
                    url: '/sms',
                    data: {
                        phoneCodeInput: code
                    },
                    success: function () {
                        // 인증번호 입력창 띄우기
                        $("#validCode").removeAttr("hidden");
                        document.getElementById("InvalidCode").hidden = true;
                        document.getElementById("phoneCodeSubmitButton").disabled = true;
                        authenticationCheck++;
                        if(authenticationCheck == 2) {
                            document.getElementById("account-wallet-container").hidden = false;
                        }
                    },
                    error: function (error) {
                        // 유효하지 않은 휴대전화
                        $("#InvalidCode").removeAttr("hidden");
                    }
                });
            } else {
                alert("인증번호를 입력해주세요.");
            }
        });

        /**
         *  신분증 이미지 업로드 및 OCR 처리
         */
        $("#ocrButton").click(function () {
            var fileInput = $("#formFile")[0].files[0];
            document.getElementById("ocrButton").disabled = true;

            if (fileInput) {
                var formData = new FormData();
                formData.append("file", fileInput);

                $.ajax({
                    url: "/upload/ocr",
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        // 업로드 및 OCR 처리 성공
                        console.log("OCR 결과: " + response.registrationNumber1);
                        document.getElementById("registrationNumber1").value = response.registrationNumber1;
                        document.getElementById("registrationNumber2").value = response.registrationNumber2;
                        $(".RRNContainer").removeAttr("hidden");
                        $("#validRecognize").removeAttr("hidden");
                        document.getElementById("InvalidRecognize").hidden = true;
                        authenticationCheck++;
                        if(authenticationCheck == 2) {
                            document.getElementById("account-wallet-container").hidden = false;
                        }
                    },
                    error: function () {
                        // 업로드 또는 OCR 처리 중 오류
                        console.log("OCR 실패");
                        document.getElementById("ocrButton").disabled = false;
                        $("#InvalidRecognize").removeAttr("hidden");
                        document.getElementById("#validRecognize").hidden = true;
                    }
                });
            } else {
                // 파일을 선택하지 않은 경우
                document.getElementById("ocrButton").disabled = false;
                alert("파일을 선택하세요.");
            }
        });

        /**
         *  최종 계좌 개설 및 지갑 연동 요청
         */
        $("#completeAccountOpening").click(function() {
            // 사용자로부터 입력된 데이터 가져오기
            const registrationNumber1 = $("#registrationNumber1").val();
            const registrationNumber2 = $("#registrationNumber2").val();
            const accountPassword = $("#accountPw1").val();
            const walletPassword = $("#walletPw1").val();
            const referral = $("#referral").val();

            $.ajax({
                type: "POST",
                url: "/account-opening",
                data: {
                    registrationNumber1: registrationNumber1,
                    registrationNumber2: registrationNumber2,
                    accountPassword: accountPassword,
                    walletPassword: walletPassword,
                    referralCode: referral
                },
                success: function(response) {
                    // 성공시 서버단에서 완료페이지로 리다이렉트
                    window.location.href = "/account-opening-complete?event=" + response.event;
                },
                error: function(error) {
                    // 에러 처리
                    console.error(error);
                    alert("예기치 못한 에러");
                }
            });
        });
    });
</script>
<script>
    document.getElementById("accountPw2").addEventListener("input", function () {
        checkAccountPasswordMatch("accountPw1", "accountPw2");
    });
    document.getElementById("walletPw2").addEventListener("input", function () {
        checkWalletPasswordMatch("walletPw1", "walletPw2");
    });

    function checkAccountPasswordMatch() {
        var pw1 = document.getElementById("accountPw1").value;
        var pw2 = document.getElementById("accountPw2").value;

        if (pw1 === pw2) {
            accountCheck = 1;
            document.getElementById("accountPwMatch").hidden = false;
            document.getElementById("accountPwMismatch").hidden = true;
        } else {
            accountCheck = 0;
            document.getElementById("accountPwMismatch").hidden = false;
            document.getElementById("accountPwMatch").hidden = true;
        }
    }

    function checkWalletPasswordMatch() {
        var pw1 = document.getElementById("walletPw1").value;
        var pw2 = document.getElementById("walletPw2").value;
        const button = document.getElementById("completeAccountOpening");

        if (pw1 === pw2) {
            walletCheck = 1;
            document.getElementById("walletPwMatch").hidden = false;
            document.getElementById("walletPwMismatch").hidden = true;
        } else {
            walletCheck = 0;
            document.getElementById("walletPwMismatch").hidden = false;
            document.getElementById("walletPwMatch").hidden = true;
        }
        if (authenticationCheck === 2 && accountCheck === 1 && walletCheck === 1) {
            button.removeAttribute("disabled");
        }
    }

    function goToBefore() {
        window.location.href = "/accountOpeningProcess1";
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