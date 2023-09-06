<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    /**
     * 비밀번호 확인 유효성 검사
     */
    function validatePassword() {
        var password = document.getElementById('password');
        var passwordCheck = document.getElementById('passwordCheck');
        if (password.value !== passwordCheck.value) {
            passwordCheck.setCustomValidity('비밀번호가 일치하지 않습니다.');
        } else {
            passwordCheck.setCustomValidity(''); // no error
        }
    }

    /**
     *  성공 모달 띄우는 함수
     */
    function showSuccessModal() {
        const successModal = new bootstrap.Modal(document.getElementById('successModal'));
        successModal.show();
    }

    /**
     * 실패 모달 띄우는 함수
     */
    function showErrorModal(error) {
        const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
        errorModal.show();
    }

    /**
     *  리다이렉트
     */
    function redirectToHome() {
        window.location.href = "/";
    }

    function redirectToMypage() {
        window.location.href = "/mypage";
    }

    function logout() {
        window.location.href = "/logout";
    }


</script>
<script>
    $(document).ready(function () {
        /**
         *  회원가입 비동기 처리
         */
        $('#signupForm').on('submit', function (event) {
            event.preventDefault(); // 기본 폼 제출 방법을 중지

            var formData = {
                'name': $('#name').val(),
                'id': $('#id').val(),
                'password': $('#password').val(),
                'passwordCheck': $('#passwordCheck').val(),
                'phone': $('#phone').val(),
                'email': $('#email').val()
            };

            $.ajax({
                type: 'POST',
                url: '/signup', // 실제 서버 URL로 변경해야 합니다.
                data: JSON.stringify(formData),
                contentType: 'application/json',
                success: function () {
                    showSuccessModal();
                },
                error: function (error) {
                    showErrorModal();
                    console.error('error:', error);
                }
            });
        });

        /**
         *  로그인 비동기 처리
         */
        $('#loginForm').on('submit', function (event) {
            event.preventDefault(); // 기본 폼 제출 방법을 중지

            var formData = {
                'id': $('#loginId').val(),
                'password': $('#loginPassword').val(),
            };

            $.ajax({
                type: 'POST',
                url: '/login', // 실제 서버 URL로 변경해야 합니다.
                data: JSON.stringify(formData),
                contentType: 'application/json',
                success: function () {
                    window.location.href = "/";
                },
                error: function (error) {
                    showErrorModal();
                    console.error('error:', error);
                }
            });
        });

    });
</script>

<header>
    <!-- 로그인 표시 바 -->
    <div id="loginBar">
        <c:choose>
            <c:when test="${empty sessionScope.member}">
                <button type="button" class="btn btn-link no-underline-black" data-bs-toggle="modal"
                        data-bs-target="#loginModal" data-whatever="@mdo">로그인
                </button>

                <button type="button" class="btn btn-link no-underline-black" data-bs-toggle="modal"
                        data-bs-target="#signUpModal" data-whatever="@fat">회원가입
                </button>

                <div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalLabelOne" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div class="xButton">
                                    <button type="button" class="btn-close bbtn" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>

                                <h3 class="modal-title" id="login">로그인</h3>
                                <form id="loginForm">
                                    <div class="mb-3">
                                        <label for="loginId" class="col-form-label">아이디</label>
                                        <input type="text" class="form-control" id="loginId"
                                               placeholder="아이디를 입력하세요." required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="loginPassword" class="col-form-label">비밀번호</label>
                                        <input type="password" class="form-control" id="loginPassword"
                                               placeholder="비밀번호를 입력하세요." required>
                                    </div>
                                    <div class="modalFooter">
                                        <button type="submit" class="btn btn-primary">로그인하기</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
                <c:otherwise>
                    <button id="memberNameButton" type="button" class="btn btn-link no-underline-black" onclick="redirectToMypage()">${sessionScope.member.name}님
                    </button>

                    <button id="logoutButton" type="button" class="btn btn-link no-underline-black" onclick="logout()">로그아웃
                    </button>
                </c:otherwise>
        </c:choose>

        <div class="modal fade" id="signUpModal" tabindex="-1" role="dialog"
             aria-labelledby="exampleModalLabelOne" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="xButton">
                            <button type="button" class="btn-close bbtn" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <h3 class="modal-title" id="signup">회원가입</h3>
                        <form id="signupForm">
                            <div class="mb-3">
                                <label for="name" class="col-form-label">성명 (필수)</label>
                                <input type="text" class="form-control" id="name" placeholder="성명" required>
                            </div>
                            <div class="mb-3">
                                <label for="id" class="col-form-label">아이디 (필수)</label>
                                <input type="text" class="form-control" id="id" placeholder="영문 숫자 혼합 6자리 이상"
                                       pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$"
                                       title="영문자와 숫자를 포함한 6자리 이상의 아이디를 입력해주세요." required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="col-form-label">비밀번호 (필수)</label>
                                <input type="password" class="form-control" id="password" placeholder="영문 숫자 혼합 6자리 이상"
                                       pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$"
                                       title="영문자와 숫자를 포함한 6자리 이상의 비밀번호를 입력해주세요." required>
                            </div>
                            <div class="mb-3">
                                <label for="passwordCheck" class="col-form-label">비밀번호 확인 (필수)</label>
                                <input type="password" class="form-control" id="passwordCheck" placeholder="비밀번호 확인"
                                       oninput="validatePassword()" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="col-form-label">전화번호 (필수)</label>
                                <input type="text" class="form-control" id="phone" placeholder="01012345678"
                                       pattern="^010\d{8}$" title="010으로 시작하는 11자리의 전화번호를 입력해주세요." required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="col-form-label">이메일 주소 (필수)</label>
                                <input type="email" class="form-control" id="email" placeholder="이메일 주소 (필수)" required>
                            </div>
                            <div class="modalFooter">
                                <button type="submit" class="btn btn-primary">회원가입 하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- nav bar -->
    <div id="navBar">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light">
            <a class="navbar-brand" href="/"><img class="mainLogo" src="/resources/img/logo.png"></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button"
                           data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            투자하기
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">부동산 거래 가능 종목</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">부동산 매각 완료 종목</a>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">청약</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/mypage">마이페이지</a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                           data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            고객지원
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="/announcement">공지사항</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">자주 묻는 질문</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">약관 및 정책</a>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
    </div>

    <!-- 성공 모달 -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="padding: 50px; justify-content: center; text-align: center;">
                    성공적으로 처리되었습니다.
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal"
                            onclick="redirectToHome()">닫기</strong>
                </div>
            </div>
        </div>
    </div>

    <!-- 실패 모달 -->
    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="padding: 50px; justify-content: center; text-align: center;">
                    처리 중 오류가 발생했습니다.
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal"
                            onclick="redirectToHome()">닫기</strong>
                </div>
            </div>
        </div>
    </div>
</header>
