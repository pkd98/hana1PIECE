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
    <!-- Bootstrap Datepicker CSS -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <!-- jQuery (Standard Version) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- kakao map api -->
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5082aba073eeee4dbd5606104fd17280&libraries=services"></script>
    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true
            });
        });
    </script>
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
        <h2>관리자 대시보드</h2>
        <hr>
    </div>

    <div class="container">
        <div class="row g-4">
            <div class="col-lg-3">
                <!-- Advanced filter responsive toggler START -->
                <div class="d-flex align-items-center d-lg-none">
                    <button class="border-0 bg-transparent" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSideNavbar" aria-controls="offcanvasSideNavbar">
                        <span class="btn btn-primary"><i class="fa-solid fa-sliders-h"></i></span>
                        <span class="h6 mb-0 fw-bold d-lg-none ms-2">My profile</span>
                    </button>
                </div>
                <!-- Advanced filter responsive toggler END -->

                <!-- Navbar START-->
                <nav class="navbar navbar-expand-lg mx-0">
                    <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasSideNavbar">
                        <!-- Offcanvas header -->
                        <div class="offcanvas-header">
                            <button type="button" class="btn-close text-reset ms-auto" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>

                        <!-- Offcanvas body -->
                        <div class="offcanvas-body d-block px-2 px-lg-0">
                            <!-- Card START -->
                            <div class="card overflow-hidden">
                                <!-- Cover image -->
                                <div class="h-50px">
                                    <!-- Avatar -->
                                    <div class="avatar">
                                        <img class="avatar-img rounded border border-white border-3" src="/resources/img/manager/${sessionScope.manager.image}" alt="">
                                    </div>
                                </div>
                                <!-- Card body START -->
                                <div class="card-body pt-0">
                                    <div class="text-center mb-3">
                                        <!-- Info -->
                                        <h5 class="mb-0">${sessionScope.manager.name}(관리자)</h5>
                                        <small>${sessionScope.manager.position}</small>
                                        <p class="mt-3 mb-3">${sessionScope.manager.introduction}</p>
                                        <hr>
                                    </div>

                                    <!-- Side Nav START -->
                                    <ul class="nav nav-link-secondary flex-column fw-bold gap-2">
                                        <li class="nav-item">
                                            <a class="nav-link" href="#register"><span>배당금 | 공모/청약 | 매각 등록</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#transaction-analysis"><span>거래 분석</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#order-transaction-scan"><span>주문 트랜잭션 스캔</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#dividend-scan"><span>배당금 지급 내역</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href=""><span>회원 관리</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href=""><span>시스템 에러 로그</span></a>
                                        </li>
                                        <hr>
                                        <li class="nav-item">
                                            <a class="nav-link" href=""><span>하나은행 거래내역</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href=""><span>하나은행 에러 로그</span></a>
                                        </li>
                                    </ul>
                                    <!-- Side Nav END -->
                                </div>
                                <!-- Card body END -->
                                <!-- Card footer -->
                                <div class="card-footer text-center py-2">
                                    <a class="btn btn-link btn-sm" href="/manager/logout"><img style="width: 200px;" src="/resources/img/logo.png"></a>
                                </div>
                            </div>
                            <!-- Card END -->
                        </div>
                    </div>
                </nav>
                <!-- Navbar END-->
            </div>

            <div class="col-lg-9">

                <div class="container mt-3">
                    <div class="mypage-title">
                        <h2 id="register">등록 처리</h2>
                    </div>

                    <div id="button-area" class="row">
                        <!-- First Card -->
                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">배당금 지급</h5>
                                    <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                            data-bs-target="#dividendModal">배당금 지급</button>
                                </div>
                            </div>
                        </div>
                        <!-- Second Card -->
                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">공모/청약 등록</h5>
                                    <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                            data-bs-target="#publicOfferModal">공모/청약 등록</button>
                                </div>
                            </div>
                        </div>
                        <!-- Third Card -->
                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">매각 투표</h5>
                                    <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                            data-bs-target="#saleVoteModal">매각투표 등록</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 배당금 지급 모달 -->
                    <div class="modal fade" id="dividendModal" tabindex="-1" aria-labelledby="dividendModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="dividendModalLabel">배당금 지급</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-6 text-left">
                                            <label for="buildingInput">빌딩</label>
                                        </div>
                                        <div class="col-6 text-right">
                                            <select class="form-control" id="buildingInput">
                                                <!-- 여기에 선택 항목을 추가할 수 있습니다. -->
                                                <option>예시 빌딩 1</option>
                                                <option>예시 빌딩 2</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-6 text-left">
                                            <label for="amountInput">토큰당 지급액</label>
                                        </div>
                                        <div class="col-6 text-right">
                                            <input type="number" class="form-control" id="amountInput" placeholder="금액을 입력하세요">
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="justify-content: center;">
                                    <button type="button" class="btn" style="background-color: #008485; color: white;">지급
                                        확인</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 공모/청약 등록 모달 -->
                    <div class="modal fade" id="publicOfferModal" tabindex="-1" aria-labelledby="publicOfferModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="publicOfferModalLabel">공모/청약 등록</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="modal-padding">
                                        <!-- 매물 상세 정보 -->
                                        <h6 class="mb-3">매물 상세 정보</h6>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">건물명:</div>
                                            <div class="col-8 text-right"><input id="building_name" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">건물상세주소:</div>
                                            <div class="col-8 text-right">
                                                <input id="address" type="text" class="form-control d-inline-block"
                                                       style="width: 80%;">
                                                <button onclick="sample3_execDaumPostcode()"
                                                        class="btn btn-secondary d-inline-block"
                                                        style="width: 18%; background-color: #008485;">검색</button>
                                            </div>
                                        </div>

                                        <!-- 카카오 주소 api-->
                                        <div id="wrap"
                                             style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
                                            <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap"
                                                 style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1"
                                                 onclick="foldDaumPostcode()" alt="접기 버튼">
                                        </div>

                                        <div class="row mb-2">
                                            <div class="col-4 text-left">층 수:</div>
                                            <div class="col-8 text-right"><input id="floors" type="number" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">주용도:</div>
                                            <div class="col-8 text-right"><input id="usage" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">대지면적:</div>
                                            <div class="col-8 text-right"><input id="land_area" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">연면적:</div>
                                            <div class="col-8 text-right"><input id="floor_area" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">건폐율:</div>
                                            <div class="col-8 text-right"><input id="coverage_ratio" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">용적률:</div>
                                            <div class="col-8 text-right"><input id="floor_area_ratio" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">위도:</div>
                                            <div class="col-8 text-right"><input id="latitude-input" type="number" stem="any" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">경도:</div>
                                            <div class="col-8 text-right"><input id="longitude-input" type="number" stem="any" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">준공일:</div>
                                            <div class="col-8 text-right"><input id="completion_date" type="text" class="form-control datepicker"
                                                                                 placeholder="준공일"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">이미지1:</div>
                                            <div class="col-8 text-right"><input id="image1" type="file" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">이미지2:</div>
                                            <div class="col-8 text-right"><input id="image2" type="file" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">이미지3:</div>
                                            <div class="col-8 text-right"><input id="image3" type="file" class="form-control"></div>
                                        </div>
                                        <hr>
                                        <!-- 발행 정보 -->
                                        <h6 class="mt-3 mb-3">발행 정보</h6>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">발행인:</div>
                                            <div class="col-8 text-right"><input id="publisher" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">발행 증권 수:</div>
                                            <div class="col-8 text-right"><input id="volume" type="number" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">발행가액:</div>
                                            <div class="col-8 text-right"><input id="issue_price" type="number" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">모집액:</div>
                                            <div class="col-8 text-right"><input id="total_amount" type="number" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">청약 기간:</div>
                                            <div class="col-8 text-right">
                                                <input id="start_date" type="text" class="form-control datepicker d-inline-block"
                                                       style="width: 45%;" placeholder="시작일">
                                                <span class="d-inline-block mx-1">~</span>
                                                <input id="expiration_date" type="text" class="form-control datepicker d-inline-block"
                                                       style="width: 45%;" placeholder="종료일">
                                            </div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">최초 배당 기준일:</div>
                                            <div class="col-8 text-right"><input id="first_dividend_date" type="text" class="form-control datepicker"
                                                                                 placeholder="기준일"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">배당 주기:</div>
                                            <div class="col-8 text-right"><input id="dividend_cycle" type="number" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">배당액:</div>
                                            <div class="col-8 text-right"><input id="dividend" type="number" class="form-control"></div>
                                        </div>
                                        <hr>
                                        <!-- 임차인 정보 -->
                                        <h6 class="mt-3 mb-3">임차인 정보</h6>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">임차인명:</div>
                                            <div class="col-8 text-right"><input id="lessee" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-4 text-left">업종:</div>
                                            <div class="col-8 text-right"><input id="sector" type="text" class="form-control"></div>
                                        </div>
                                        <div class="row mb-4">
                                            <div class="col-4 text-left">계약기간:</div>
                                            <div class="col-8 text-right">
                                                <input id="contract_date" type="text" class="form-control datepicker d-inline-block"
                                                       style="width: 45%;" placeholder="시작일">
                                                <span class="d-inline-block mx-1">~</span>
                                                <input id="lessee_expiration_date" type="text" class="form-control datepicker d-inline-block"
                                                       style="width: 45%;" placeholder="종료일">
                                            </div>
                                        </div>
                                        <hr>
                                        <h6 class="mt-3 mb-3">건물 소개</h6>
                                        <div class="row mb-2">
                                            <div class="col-12 text-right"><input id="introduction" type="text" class="form-control"></div>
                                        </div>
                                    </div>
                                    <div class="modal-footer" style="justify-content: center;">
                                        <button id="publicOfferingButton" type="button" class="btn" style="background-color: #008485; color: white;">등록
                                            확인</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 매각투표 등록 모달 -->
                    <div class="modal fade" id="saleVoteModal" tabindex="-1" aria-labelledby="saleVoteModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="saleVoteModalLabel">매각투표 등록</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="buildingName">빌딩명</label>
                                        <select class="form-control" id="buildingName">
                                            <!-- 여기에 선택 항목을 추가할 수 있습니다. -->
                                            <option>예시 빌딩 1</option>
                                            <option>예시 빌딩 2</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="voteStartDate">투표기간</label>
                                        <div>
                                            <input type="text" class="form-control datepicker d-inline-block" style="width: 47%;"
                                                   placeholder="시작일">
                                            <span class="d-inline-block mx-1">~</span>
                                            <input type="text" class="form-control datepicker d-inline-block" style="width: 47%;"
                                                   placeholder="종료일">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="saleAmount">매각 금액</label>
                                        <input type="number" class="form-control" id="saleAmount" placeholder="금액을 입력하세요">
                                    </div>
                                    <div class="mb-3">
                                        <label for="saleDividend">매각 배당금</label>
                                        <input type="number" class="form-control" id="saleDividend" placeholder="배당금을 입력하세요">
                                    </div>
                                </div>
                                <div class="modal-footer" style="justify-content: center;">
                                    <button type="button" class="btn" style="background-color: #008485; color: white;">등록
                                        확인</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="container mt-5">
                    <div class="mypage-title">
                        <h2 id="transaction-analysis">거래 분석</h2>
                    </div>
                </div>

                <div class="container mt-5">
                    <div class="mypage-title">
                        <h2 id="order-transaction-scan">주문 트랜잭션 스캔</h2>
                    </div>
                </div>

                <div class="announcement">
                    <div class="container mt-3">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-light">
                            <tr>
                                <th>주문번호</th>
                                <th>거래대상</th>
                                <th>지갑번호</th>
                                <th>유형</th>
                                <th>거래상태</th>
                                <th>거래수량</th>
                                <th>거래금액</th>
                                <th>주문일시</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1001</td>
                                <td>롯데타워</td>
                                <td>xyz12345abc</td>
                                <td>매수</td>
                                <td>완료</td>
                                <td>10</td>
                                <td>1,000,000원</td>
                                <td>2023-08-25 10:00</td>
                            </tr>
                            <tr>
                                <td>1002</td>
                                <td>삼성타워</td>
                                <td>abc78901xyz</td>
                                <td>매도</td>
                                <td>대기중</td>
                                <td>20</td>
                                <td>2,000,000원</td>
                                <td>2023-08-25 11:00</td>
                            </tr>
                            <tr>
                                <td>1003</td>
                                <td>하나타워</td>
                                <td>uvw45678rst</td>
                                <td>매수</td>
                                <td>완료</td>
                                <td>30</td>
                                <td>3,000,000원</td>
                                <td>2023-08-26 10:00</td>
                            </tr>
                            <tr>
                                <td>1004</td>
                                <td>우리타워</td>
                                <td>lmn23456opq</td>
                                <td>매도</td>
                                <td>대기중</td>
                                <td>40</td>
                                <td>4,000,000원</td>
                                <td>2023-08-26 11:00</td>
                            </tr>
                            <tr>
                                <td>1005</td>
                                <td>KB타워</td>
                                <td>ijk90123lmn</td>
                                <td>매수</td>
                                <td>완료</td>
                                <td>50</td>
                                <td>5,000,000원</td>
                                <td>2023-08-27 10:00</td>
                            </tr>
                            </tbody>
                        </table>

                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">4</a></li>
                                <li class="page-item"><a class="page-link" href="#">5</a></li>
                                <li class="page-item"><a class="page-link" href="#">Next</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>

                <div class="container mt-5">
                    <div class="mypage-title">
                        <h2 id="dividend-scan">배당금 지급 내역</h2>
                    </div>
                </div>

                <div class="announcement">
                    <div class="container mt-3">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-light">
                            <tr>
                                <th>주문번호</th>
                                <th>거래대상</th>
                                <th>지갑번호</th>
                                <th>유형</th>
                                <th>거래상태</th>
                                <th>거래수량</th>
                                <th>거래금액</th>
                                <th>주문일시</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1001</td>
                                <td>롯데타워</td>
                                <td>xyz12345abc</td>
                                <td>매수</td>
                                <td>완료</td>
                                <td>10</td>
                                <td>1,000,000원</td>
                                <td>2023-08-25 10:00</td>
                            </tr>
                            <tr>
                                <td>1002</td>
                                <td>삼성타워</td>
                                <td>abc78901xyz</td>
                                <td>매도</td>
                                <td>대기중</td>
                                <td>20</td>
                                <td>2,000,000원</td>
                                <td>2023-08-25 11:00</td>
                            </tr>
                            <tr>
                                <td>1003</td>
                                <td>하나타워</td>
                                <td>uvw45678rst</td>
                                <td>매수</td>
                                <td>완료</td>
                                <td>30</td>
                                <td>3,000,000원</td>
                                <td>2023-08-26 10:00</td>
                            </tr>
                            <tr>
                                <td>1004</td>
                                <td>우리타워</td>
                                <td>lmn23456opq</td>
                                <td>매도</td>
                                <td>대기중</td>
                                <td>40</td>
                                <td>4,000,000원</td>
                                <td>2023-08-26 11:00</td>
                            </tr>
                            <tr>
                                <td>1005</td>
                                <td>KB타워</td>
                                <td>ijk90123lmn</td>
                                <td>매수</td>
                                <td>완료</td>
                                <td>50</td>
                                <td>5,000,000원</td>
                                <td>2023-08-27 10:00</td>
                            </tr>
                            </tbody>
                        </table>

                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">4</a></li>
                                <li class="page-item"><a class="page-link" href="#">5</a></li>
                                <li class="page-item"><a class="page-link" href="#">Next</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- 성공 모달 -->
    <div class="modal fade" id="managerSuccessModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="padding: 50px; justify-content: center; text-align: center;">
                    성공적으로 처리되었습니다.
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal"
                            onclick="redirectToManager()">닫기</strong>
                </div>
            </div>
        </div>
    </div>

    <!-- 실패 모달 -->
    <div class="modal fade" id="managerErrorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="padding: 50px; justify-content: center; text-align: center;">
                    처리 중 오류가 발생했습니다.
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal">닫기</strong>
                </div>
            </div>
        </div>
    </div>

    <script>
        function redirectToManager() {
            window.location.href = "/manager";
        }

        $(document).ready(function () {
            /**
             *  공모/청약 등록
             */
            $("#publicOfferingButton").click(function () {
                // FormData 객체 생성
                var formData = new FormData();

                // 스피너 시작
                $(this).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중...');
                $(this).prop('disabled', true);

                // input 요소들의 값을 객체에 담기
                formData.append('buildingName', $("#building_name").val());
                formData.append('address', $("#address").val());
                formData.append('floors', $("#floors").val());
                formData.append('usage', $("#usage").val());
                formData.append('landArea', $("#land_area").val());
                formData.append('floorArea', $("#floor_area").val());
                formData.append('coverageRatio', $("#coverage_ratio").val());
                formData.append('floorAreaRatio', $("#floor_area_ratio").val());
                formData.append('latitude', $("#latitude-input").val());
                formData.append('longitude', $("#longitude-input").val());
                formData.append('completionDate', $("#completion_date").val());

                // 파일 추가
                formData.append('image1', $('#image1')[0].files[0]);
                formData.append('image2', $('#image2')[0].files[0]);
                formData.append('image3', $('#image3')[0].files[0]);

                formData.append('publisher', $("#publisher").val());
                formData.append('volume', $("#volume").val());
                formData.append('issuePrice', $("#issue_price").val());
                formData.append('totalAmount', $("#total_amount").val());
                formData.append('startDate', $("#start_date").val());
                formData.append('expirationDate', $("#expiration_date").val());
                formData.append('firstDividendDate', $("#first_dividend_date").val());
                formData.append('dividendCycle', $("#dividend_cycle").val());
                formData.append('dividend', $("#dividend").val());

                formData.append('lessee', $("#lessee").val());
                formData.append('sector', $("#sector").val());
                formData.append('contractDate', $("#contract_date").val());
                formData.append('lesseeExpirationDate', $("#lessee_expiration_date").val());

                formData.append('introduction', $("#introduction").val());
                // AJAX를 사용하여 POST 요청 수행
                $.ajax({
                    url: '/manager/public-offering/registration',
                    type: 'POST',
                    data: formData,
                    contentType: false, // contentType을 false로 설정해야 FormData가 올바른 contentType을 설정
                    processData: false, // processData를 false로 설정해야 jQuery가 data를 문자열로 변환하지 않음
                    success: function (response) {
                        // 스피너 정지 및 초기화
                        $("#publicOfferingButton").html('등록 확인').prop('disabled', false);
                        // 성공 모달 표시
                        $("#managerSuccessModal").modal('show');
                    },
                    error: function (error) {
                        // 스피너 정지 및 초기화
                        $("#publicOfferingButton").html('등록 확인').prop('disabled', false);
                        // 실패 모달 표시
                        $("#managerErrorModal").modal('show');
                    }
                });
            });
        });
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        // 우편번호 찾기 찾기 화면을 넣을 element
        var element_wrap = document.getElementById('wrap');
        // 위도 경도 좌표 저장 변수
        var geocoder = new daum.maps.services.Geocoder();

        function foldDaumPostcode() {
            // iframe을 넣은 element를 안보이게 한다.
            element_wrap.style.display = 'none';
        }

        function sample3_execDaumPostcode() {
            // 현재 scroll 위치를 저장해놓는다.
            var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            new daum.Postcode({
                oncomplete: function (data) {
                    // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    var addr = ''; // 주소 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("address").value = addr;

                    // iframe을 넣은 element를 안보이게 한다.
                    // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                    element_wrap.style.display = 'none';

                    // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                    document.body.scrollTop = currentScroll;


                    // 주소로 상세 정보를 검색
                    geocoder.addressSearch(data.address, function (results, status) {
                        // 정상적으로 검색이 완료됐으면
                        if (status === daum.maps.services.Status.OK) {

                            var result = results[0]; //첫번째 결과의 값을 활용

                            // 해당 주소에 대한 좌표 인풋창 반영
                            document.getElementById("latitude-input").value = result.y;
                            document.getElementById("longitude-input").value = result.x;
                        }
                    });
                },
                // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
                onresize: function (size) {
                    element_wrap.style.height = size.height + 'px';
                },
                width: '100%',
                height: '100%'
            }).embed(element_wrap);

            // iframe을 넣은 element를 보이게 한다.
            element_wrap.style.display = 'block';
        }
    </script>
    <!-- Bootstrap Datepicker JS -->
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <!-- Popper.js and Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"></script>
</body>
</html>