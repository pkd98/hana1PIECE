<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
    <!-- 로그인 표시 바 -->
    <div id="loginBar">
        <div id="loginBar">
            <!-- Varying modal -->
            <button type="button" class="btn btn-link no-underline-black" data-bs-toggle="modal"
                    data-bs-target="#loginModal" data-whatever="@mdo">로그인</button>

            <button type="button" class="btn btn-link no-underline-black" data-bs-toggle="modal"
                    data-bs-target="#signUpModal" data-whatever="@fat">회원가입</button>


            <div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalLabelOne" aria-hidden="true">
                <div class="modal-dialog" role="document">

                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="xButton">
                                <button type="button" class="btn-close bbtn" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>

                            <h3 class="modal-title" id="exampleModalLabelOne">로그인</h3>

                            <form>
                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label">아이디</label>
                                    <input type="text" class="form-control" id="recipient-name"
                                           placeholder="아이디를 입력하세요.">
                                </div>

                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">비밀번호</label>
                                    <input type="password" class="form-control" id="recipient-pwd"
                                           placeholder="비밀번호를 입력하세요.">
                                </div>

                                <div class="modalFooter">
                                    <button type="button" class="btn btn-primary"
                                            onclick="handleLogin()">로그인하기</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="signUpModal" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalLabelOne" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="xButton">
                                <button type="button" class="btn-close bbtn" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>

                            <h3 class="modal-title" id="exampleModalLabelOne">회원가입</h3>

                            <form>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">이름</label>
                                    <input type="text" class="form-control" id="recipient-name" placeholder="이름">
                                </div>
                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label">아이디</label>
                                    <input type="text" class="form-control" id="recipient-name"
                                           placeholder="아이디 (필수)">
                                </div>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">비밀번호</label>
                                    <input type="password" class="form-control" id="recipient-name"
                                           placeholder="비밀번호 (필수)">
                                </div>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">비밀번호 확인</label>
                                    <input type="password" class="form-control" id="recipient-name"
                                           placeholder="비밀번호 확인">
                                </div>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">전화번호</label>
                                    <input type="text" class="form-control" id="recipient-name"
                                           placeholder="휴대폰 번호 (필수)">
                                </div>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">이메일 주소</label>
                                    <input type="text" class="form-control" id="recipient-name"
                                           placeholder="이메일 주소 (필수)">
                                </div>
                                <div class="modalFooter">
                                    <button type="button" class="btn btn-primary">회원가입 하기</button>
                                </div>
                            </form>
                        </div>

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
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
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
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
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
</header>
