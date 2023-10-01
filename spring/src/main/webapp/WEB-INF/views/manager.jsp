<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
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
                <button class="border-0 bg-transparent" type="button" data-bs-toggle="offcanvas"
                        data-bs-target="#offcanvasSideNavbar" aria-controls="offcanvasSideNavbar">
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
                        <button type="button" class="btn-close text-reset ms-auto" data-bs-dismiss="offcanvas"
                                aria-label="Close"></button>
                    </div>

                    <!-- Offcanvas body -->
                    <div class="offcanvas-body d-block px-2 px-lg-0">
                        <!-- Card START -->
                        <div class="card overflow-hidden">
                            <!-- Cover image -->
                            <div class="h-50px">
                                <!-- Avatar -->
                                <div class="avatar">
                                    <img class="avatar-img rounded border border-white border-3"
                                         src="/resources/img/manager/${sessionScope.manager.image}" alt="">
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
                                        <a class="nav-link" href="#register"><span>공모/청약 | 배당금 | 매각 등록</span></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#transaction-analysis"><span>거래 현황</span></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#order-transaction-scan"><span>주문 트랜잭션 스캔</span></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#order-transaction-scan"><span>체결 트랜잭션 스캔</span></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#dividend-scan"><span>배당금 지급 내역</span></a>
                                    </li>
                                </ul>
                            </div>

                            <div class="card-footer text-center py-2">
                                <a class="btn btn-link btn-sm" href="/manager/logout"><img style="width: 200px;"
                                                                                           src="/resources/img/logo.png"></a>
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
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">공모/청약 등록</h5>
                                <img src="/resources/img/free-icon-contract-4631631.png" width="50px"/>
                                <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                        data-bs-target="#publicOfferModal">공모/청약 등록
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">매물 상장</h5>
                                <img src="/resources/img/free-icon-stockbroker-8991253.png" width="50px"/>
                                <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                        data-bs-target="#listingModal">매물 상장
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">매각 투표</h5>
                                <img src="/resources/img/free-icon-manual-voting-3179299.png" width="50px"/>
                                <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                        data-bs-target="#saleVoteModal">매각투표 등록
                                </button>
                            </div>
                        </div>
                    </div>
                </div>


                <div id="button-area2" class="row mt-3">

                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">배당금 지급</h5>
                                <img src="/resources/img/free-icon-dividends-3529115.png" width="50px"/>
                                <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                        data-bs-target="#dividendModal">배당금 지급
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">공지사항</h5>
                                <img src="/resources/img/free-icon-announcement-4048821.png" width="50px"/>
                                <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                        data-bs-target="#announcementModal">공지 등록
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">앱푸시 알림</h5>
                                <img src="/resources/img/free-icon-alarm-1347881.png" width="50px"/>
                                <button class="btn btn-custom-color btn-block" data-bs-toggle="modal"
                                        data-bs-target="#appNotificationModal">알림 보내기
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 매물 상장 모달 -->
                <div class="modal fade" id="listingModal" tabindex="-1" aria-labelledby="listingModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="listingModalLabel">매물 상장</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-6 text-left">
                                        <label for="listingBuildingInput">빌딩명</label>
                                    </div>
                                    <div class="col-6 text-right">
                                        <select class="form-control" id="listingBuildingInput">
                                            <c:forEach var="item" items="${findPublicOfferingList}">
                                                <option value="${item.listingNumber}">
                                                    (${item.listingNumber}) ${item.buildingName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" style="justify-content: center;">
                                <button id="listingButton" type="button" class="btn"
                                        style="background-color: #008485; color: white;">
                                    상장 확인
                                </button>
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
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-6 text-left">
                                        <label for="targetBuilding">빌딩</label>
                                    </div>
                                    <div class="col-6 text-right">
                                        <select class="form-control" id="targetBuilding">
                                            <c:forEach var="item" items="${listedEstateList}">
                                                <option value="${item.listingNumber}">
                                                    (${item.listingNumber}) ${item.buildingName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-6 text-left">
                                        <label for="dividendAmount">토큰당 지급액</label>
                                    </div>
                                    <div class="col-6 text-right">
                                        <input type="number" class="form-control" id="dividendAmount"
                                               placeholder="금액을 입력하세요">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" style="justify-content: center;">
                                <button id="dividendPaymentSubmit" type="button" class="btn" style="background-color: #008485; color: white;">지급
                                    확인
                                </button>
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
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="modal-padding">
                                    <!-- 매물 상세 정보 -->
                                    <h6 class="mb-3">매물 상세 정보</h6>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">건물명:</div>
                                        <div class="col-8 text-right"><input id="building_name" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">건물상세주소:</div>
                                        <div class="col-8 text-right">
                                            <input id="address" type="text" class="form-control d-inline-block"
                                                   style="width: 80%;">
                                            <button onclick="sample3_execDaumPostcode()"
                                                    class="btn btn-secondary d-inline-block"
                                                    style="width: 18%; background-color: #008485;">검색
                                            </button>
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
                                        <div class="col-4 text-left">공급면적:</div>
                                        <div class="col-8 text-right"><input id="supplyArea" type="number"
                                                                             class="form-control"></div>
                                    </div>

                                    <div class="row mb-2">
                                        <div class="col-4 text-left">층 수:</div>
                                        <div class="col-8 text-right"><input id="floors" type="number"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">주용도:</div>
                                        <div class="col-8 text-right"><input id="usage" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">대지면적:</div>
                                        <div class="col-8 text-right"><input id="land_area" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">연면적:</div>
                                        <div class="col-8 text-right"><input id="floor_area" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">건폐율:</div>
                                        <div class="col-8 text-right"><input id="coverage_ratio" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">용적률:</div>
                                        <div class="col-8 text-right"><input id="floor_area_ratio" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">위도:</div>
                                        <div class="col-8 text-right"><input id="latitude-input" type="number"
                                                                             stem="any" class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">경도:</div>
                                        <div class="col-8 text-right"><input id="longitude-input" type="number"
                                                                             stem="any" class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">준공일:</div>
                                        <div class="col-8 text-right"><input id="completion_date" type="text"
                                                                             class="form-control datepicker"
                                                                             placeholder="준공일"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">이미지1:</div>
                                        <div class="col-8 text-right"><input id="image1" type="file"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">이미지2:</div>
                                        <div class="col-8 text-right"><input id="image2" type="file"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">이미지3:</div>
                                        <div class="col-8 text-right"><input id="image3" type="file"
                                                                             class="form-control"></div>
                                    </div>
                                    <hr>
                                    <!-- 발행 정보 -->
                                    <h6 class="mt-3 mb-3">발행 정보</h6>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">발행인:</div>
                                        <div class="col-8 text-right"><input id="publisher" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">발행 증권 수:</div>
                                        <div class="col-8 text-right"><input id="volume" type="number"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">발행가액:</div>
                                        <div class="col-8 text-right"><input id="issue_price" type="number"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">모집액:</div>
                                        <div class="col-8 text-right"><input id="total_amount" type="number"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">청약 기간:</div>
                                        <div class="col-8 text-right">
                                            <input id="start_date" type="text"
                                                   class="form-control datepicker d-inline-block"
                                                   style="width: 45%;" placeholder="시작일">
                                            <span class="d-inline-block mx-1">~</span>
                                            <input id="expiration_date" type="text"
                                                   class="form-control datepicker d-inline-block"
                                                   style="width: 45%;" placeholder="종료일">
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">최초 배당 기준일:</div>
                                        <div class="col-8 text-right"><input id="first_dividend_date" type="text"
                                                                             class="form-control datepicker"
                                                                             placeholder="기준일"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">배당 주기:</div>
                                        <div class="col-8 text-right"><input id="dividend_cycle" type="number"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">배당액:</div>
                                        <div class="col-8 text-right"><input id="dividend" type="number"
                                                                             class="form-control"></div>
                                    </div>
                                    <hr>
                                    <!-- 임차인 정보 -->
                                    <h6 class="mt-3 mb-3">임차인 정보</h6>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">임차인명:</div>
                                        <div class="col-8 text-right"><input id="lessee" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4 text-left">업종:</div>
                                        <div class="col-8 text-right"><input id="sector" type="text"
                                                                             class="form-control"></div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-4 text-left">계약기간:</div>
                                        <div class="col-8 text-right">
                                            <input id="contract_date" type="text"
                                                   class="form-control datepicker d-inline-block"
                                                   style="width: 45%;" placeholder="시작일">
                                            <span class="d-inline-block mx-1">~</span>
                                            <input id="lessee_expiration_date" type="text"
                                                   class="form-control datepicker d-inline-block"
                                                   style="width: 45%;" placeholder="종료일">
                                        </div>
                                    </div>
                                    <hr>
                                    <h6 class="mt-3 mb-3">건물 소개</h6>
                                    <div class="row mb-2">
                                        <div class="col-12 text-right"><input id="introduction" type="text"
                                                                              class="form-control"></div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="justify-content: center;">
                                    <button id="publicOfferingButton" type="button" class="btn"
                                            style="background-color: #008485; color: white;">등록
                                        확인
                                    </button>
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
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="saleVoteListingNumber">매각 대상</label>
                                    <select class="form-control" id="saleVoteListingNumber">
                                        <c:forEach var="item" items="${listedEstateList}">
                                            <option value="${item.listingNumber}">
                                                (${item.listingNumber}) ${item.buildingName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="voteStartDate">투표기간</label>
                                    <div>
                                        <input id="voteStartDate" type="text"
                                               class="form-control datepicker d-inline-block"
                                               style="width: 47%;"
                                               placeholder="시작일">
                                        <span class="d-inline-block mx-1">~</span>
                                        <input id="voteExpirationDate" type="text"
                                               class="form-control datepicker d-inline-block"
                                               style="width: 47%;"
                                               placeholder="종료일">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="saleAmount">매각 금액</label>
                                    <input type="number" class="form-control" id="saleAmount" placeholder="금액을 입력하세요">
                                </div>
                                <div class="mb-3">
                                    <label for="saleDividend">매각 배당금</label>
                                    <input type="number" class="form-control" id="saleDividend"
                                           placeholder="배당금을 입력하세요">
                                </div>
                            </div>
                            <div class="modal-footer" style="justify-content: center;">
                                <button id="saleVoteConfirmBtn" type="button" class="btn"
                                        style="background-color: #008485; color: white;">등록
                                    확인
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 공지사항 등록 모달 -->
            <div class="modal fade" id="announcementModal" tabindex="-1" aria-labelledby="announcementModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="announcementModalLabel">공지사항 등록</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <!-- 제목 입력창 -->
                                <div class="mb-3">
                                    <label for="announcementTitle" class="form-label">제목</label>
                                    <input type="text" class="form-control" id="announcementTitle"
                                           placeholder="공지사항 제목을 입력하세요">
                                </div>
                                <!-- 내용 입력창 -->
                                <div class="mb-3">
                                    <label for="announcementContent" class="form-label">내용</label>
                                    <textarea class="form-control" id="announcementContent" rows="4"
                                              placeholder="공지사항 내용을 입력하세요"></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer" style="justify-content: center;">
                            <button id="writeAnnouncement" type="button" class="btn"
                                    style="background-color: #008485; color: white;">등록
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 앱 푸시 알림 등록 모달 -->
            <div class="modal fade" id="appNotificationModal" tabindex="-1" aria-labelledby="announcementModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="appNotificationModalLabel">앱 알림 보내기</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <!-- 제목 입력창 -->
                                <div class="mb-3">
                                    <label for="announcementTitle" class="form-label">제목</label>
                                    <input type="text" class="form-control" id="appNotificationTitle"
                                           placeholder="알림 제목을 입력하세요">
                                </div>
                                <!-- 내용 입력창 -->
                                <div class="mb-3">
                                    <label for="announcementContent" class="form-label">내용</label>
                                    <textarea class="form-control" id="appNotificationContent" rows="4"
                                              placeholder="알림 내용을 입력하세요"></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer" style="justify-content: center;">
                            <button id="appNotificationTransmit" type="button" class="btn"
                                    style="background-color: #008485; color: white;">등록
                            </button>
                        </div>
                    </div>
                </div>
            </div>



            <div class="container mt-5">
                <div class="mypage-title">
                    <h2 id="transaction-analysis">거래 현황</h2>
                </div>
            </div>
            <!-- 총 자산 & 파이 차트 영역 -->
            <div class="row equal-height-row">
                <div class="col-lg-6 col-md-6 col-sm-12 mb-3">
                    <!-- 총 자산 -->
                    <div class="card total-asset">
                        <div class="card-header">총 고객 예수금</div>
                        <div class="card-body flex1" id="total-asset-body">
                            <div class="asset-container">
                                <h3 class="formatted-number">${transactionStatus.deposit}원</h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 mb-3">
                    <!-- 파이 차트 -->
                    <div class="card total-asset">
                        <div class="card-header">총 거래 대금</div>
                        <div class="card-body flex1">
                            <div class="asset-container">
                                <h3 class="formatted-number">${transactionStatus.transactionAmount}원</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container mt-5">
                <div class="mypage-title">
                    <h2 id="order-transaction-scan">주문 트랜잭션 스캔</h2>
                </div>
            </div>

            <div class="announcement">
                <div class="container mt-3">
                    <table id="orders" class="table table-bordered table-hover">
                        <thead>
                        <tr class="table-light text-center">
                            <th>#주문번호</th>
                            <th>매물번호</th>
                            <th>지갑번호</th>
                            <th>유형</th>
                            <th>주문금액</th>
                            <th>주문수량</th>
                            <th>주문상태</th>
                            <th>주문일시</th>
                            <th>체결수량</th>
                            <th>체결평균가</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                    <ul class="pagination justify-content-center" id="ordersPaginationControls">
                        <li class="page-item"><a class="page-link" href="#" data-page="1">First</a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="prev"><</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#">Page 1 of 100</a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="next">></a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="last">Last</a></li>
                    </ul>
                </div>
            </div>

            <div class="container mt-5">
                <div class="mypage-title">
                    <h2 id="execution-transaction-scan">체결 트랜잭션 스캔</h2>
                </div>
            </div>

            <div class="announcement">
                <div class="container mt-3">
                    <table id="executions" class="table table-bordered table-hover">
                        <thead>
                        <tr class="table-light text-center">
                            <th>#체결번호</th>
                            <th>매수주문번호</th>
                            <th>매도주문번호</th>
                            <th>체결가</th>
                            <th>체결수량</th>
                            <th>체결일시</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                    <ul class="pagination justify-content-center" id="executionsPaginationControls">
                        <li class="page-item"><a class="page-link" href="#" data-page="1">First</a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="prev"><</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#">Page 1 of 100</a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="next">></a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="last">Last</a></li>
                    </ul>
                </div>
            </div>


            <div class="container mt-5">
                <div class="mypage-title">
                    <h2 id="dividend-scan">배당금 지급 내역</h2>
                </div>
            </div>

            <div class="announcement">
                <div class="container mt-3">
                    <table id="payments" class="table table-bordered table-hover">
                        <thead>
                        <tr class="table-light text-center">
                            <th>#지급번호</th>
                            <th>지갑번호</th>
                            <th>매물번호</th>
                            <th>지급액</th>
                            <th>지급일</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                    <ul class="pagination justify-content-center" id="paymentsPaginationControls">
                        <li class="page-item"><a class="page-link" href="#" data-page="1">First</a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="prev"><</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#">Page 1 of 100</a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="next">></a></li>
                        <li class="page-item"><a class="page-link" href="#" data-page="last">Last</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 성공 모달 -->
<div class="modal fade" id="managerSuccessModal" tabindex="-1" aria-labelledby="successModalLabel"
     aria-hidden="true">
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
    let ordersCurrentPage = 1;
    let ordersTotalPage = 1;
    let executionsCurrentPage = 1;
    let executionsTotalPage = 1;
    let paymentsCurrentPage = 1;
    let paymentsTotalPage = 1;

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


    function redirectToManager() {
        window.location.href = "/manager";
    }

    function loadOrders(pageNum) {
        $.ajax({
            url: "/manager/orders?page=" + pageNum,
            type: "GET",
            dataType: "json",
            success: function(response) {
                updateOrderTable(response.orders);

                // 페이지네이션 텍스트 업데이트
                ordersCurrentPage = response.currentPage;
                ordersTotalPage = response.totalPages;
                $('#ordersPaginationControls .page-item.disabled .page-link').text("Page "+ ordersCurrentPage +" of " + ordersTotalPage);
            },
            error: function(xhr, status, error) {
                console.error("Failed to fetch orders:", error);
            }
        });
    }

    function loadExecutions(pageNum) {
        $.ajax({
            url: "/manager/executions?page=" + pageNum,
            type: "GET",
            dataType: "json",
            success: function(response) {
                updateExecutionTable(response.executions);

                // 페이지네이션 텍스트 업데이트
                executionsCurrentPage = response.currentPage;
                executionsTotalPage = response.totalPages;
                $('#executionsPaginationControls .page-item.disabled .page-link').text("Page "+ executionsCurrentPage +" of " + executionsTotalPage);
            },
            error: function(xhr, status, error) {
                console.error("Failed to fetch orders:", error);
            }
        });
    }

    function loadPayments(pageNum) {
        $.ajax({
            url: "/manager/payments?page=" + pageNum,
            type: "GET",
            dataType: "json",
            success: function(response) {
                updatePaymentTable(response.payments);

                // 페이지네이션 텍스트 업데이트
                paymentsCurrentPage = response.currentPage;
                paymentsTotalPage = response.totalPages;
                $('#paymentsPaginationControls .page-item.disabled .page-link').text("Page "+ paymentsCurrentPage +" of " + paymentsTotalPage);
            },
            error: function(xhr, status, error) {
                console.error("Failed to fetch orders:", error);
            }
        });

    }


    function updateOrderTable(orders) {
        let tbody = $("#orders tbody");
        tbody.empty();

        $.each(orders, function(index, order) {
            let row = "<tr>" +
                "<td>" + order.orderId + "</td>" +
                "<td>" + order.listingNumber + "</td>" +
                "<td>" + order.walletNumber + "</td>" +
                "<td>" + order.orderType + "</td>" +
                "<td>" + order.amount + "</td>" +
                "<td>" + order.quantity + "</td>" +
                "<td>" + order.status + "</td>" +
                "<td>" + order.orderDate + "</td>" +
                "<td>" + order.executedQuantity + "</td>" +
                "<td>" + order.executedPriceAvg + "</td>" +
                "</tr>";
            tbody.append(row);
        });
    }

    function updateExecutionTable(executions) {
        let tbody = $("#executions tbody");
        tbody.empty();

        $.each(executions, function(index, execution) {
            let row = "<tr>" +
                "<td>" + execution.executionId + "</td>" +
                "<td>" + execution.buyOrderId + "</td>" +
                "<td>" + execution.sellOrderId + "</td>" +
                "<td>" + execution.executedPrice + "</td>" +
                "<td>" + execution.executedQuantity + "</td>" +
                "<td>" + execution.executionDate + "</td>" +
                "</tr>";
            tbody.append(row);
        });
    }

    function updatePaymentTable(payments) {
        let tbody = $("#payments tbody");
        tbody.empty();

        $.each(payments, function(index, payment) {
            let row = "<tr>" +
                "<td>" + payment.payoutNumber + "</td>" +
                "<td>" + payment.walletNumber + "</td>" +
                "<td>" + payment.listingNumber + "</td>" +
                "<td>" + payment.payout + "</td>" +
                "<td>" + payment.payoutDate + "</td>" +
                "</tr>";
            tbody.append(row);
        });
    }


    $(document).ready(function () {
        /**
         *  금액 천단위 구분 쉼표 추가
         */
        formatNumbers();
        /**
         * 페이지 로딩 시 첫 번째 페이지 데이터 로드
          */
        loadOrders(1);
        loadExecutions(1);
        loadPayments(1);

        /**
         *  페이지 네이션 버튼 클릭 이벤트
         */
        $(document).on('click', '#ordersPaginationControls > li', function(e) {
            e.preventDefault();

            let clickedPageLink = $(this).find('.page-link');
            let clickedPage = clickedPageLink.data('page');

            if (clickedPage === 'next') {
                ordersCurrentPage += 1;
                if (ordersCurrentPage > ordersTotalPage) {
                    ordersCurrentPage = ordersTotalPage;
                }
            } else if (clickedPage === 'prev') {
                ordersCurrentPage = Math.max(1, ordersCurrentPage - 1);  // 페이지 번호가 1 미만으로 내려가지 않게 함
            } else if (clickedPage === 'last') {
                ordersCurrentPage = ordersTotalPage;
            } else if (clickedPage == 1) {
                ordersCurrentPage = 1;
            }

            if (clickedPage) {
                loadOrders(ordersCurrentPage);
            }
        });

        $(document).on('click', '#executionsPaginationControls > li', function(e) {
            e.preventDefault();

            let clickedPageLink = $(this).find('.page-link');
            let clickedPage = clickedPageLink.data('page');

            if (clickedPage === 'next') {
                executionsCurrentPage += 1;
                if(executionsCurrentPage > executionsTotalPage) {
                    executionsCurrentPage = executionsTotalPage;
                }
            } else if (clickedPage === 'prev') {
                executionsCurrentPage = Math.max(1, executionsCurrentPage - 1);  // 페이지 번호가 1 미만으로 내려가지 않게 함
            } else if (clickedPage === 'last') {
                executionsCurrentPage = executionsTotalPage;
            } else if (clickedPage == 1) {
                executionsCurrentPage = 1;
            }

            if (clickedPage) {
                loadExecutions(executionsCurrentPage);
            }
        });

        $(document).on('click', '#paymentsPaginationControls > li', function(e) {
            e.preventDefault();

            let clickedPageLink = $(this).find('.page-link');
            let clickedPage = clickedPageLink.data('page');

            if (clickedPage === 'next') {
                paymentsCurrentPage += 1;
                if (paymentsCurrentPage > paymentsTotalPage) {
                    paymentsCurrentPage = paymentsTotalPage;
                }
            } else if (clickedPage === 'prev') {
                paymentsCurrentPage = Math.max(1, paymentsCurrentPage - 1);  // 페이지 번호가 1 미만으로 내려가지 않게 함
            } else if (clickedPage === 'last') {
                paymentsCurrentPage = paymentsTotalPage;
            } else if (clickedPage == 1) {
                paymentsCurrentPage = 1;
            }
            if (clickedPage) {
                loadPayments(paymentsCurrentPage);
            }
        });


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
            formData.append('supplyArea', $("#supplyArea").val());
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

            var modal = bootstrap.Modal.getInstance(document.getElementById('publicOfferModal'));
            // AJAX를 사용하여 POST 요청 수행
            $.ajax({
                url: '/manager/public-offering/registration',
                type: 'POST',
                data: formData,
                contentType: false, // contentType을 false로 설정해야 FormData가 올바른 contentType을 설정
                processData: false, // processData를 false로 설정해야 jQuery가 data를 문자열로 변환하지 않음
                success: function (response) {
                    // 기존 모달 닫기
                    modal.hide();
                    // 스피너 정지 및 초기화
                    $("#publicOfferingButton").html('등록 확인').prop('disabled', false);
                    // 성공 모달 표시
                    $("#managerSuccessModal").modal('show');
                },
                error: function (error) {
                    // 기존 모달 닫기
                    modal.hide();
                    // 스피너 정지 및 초기화
                    $("#publicOfferingButton").html('등록 확인').prop('disabled', false);
                    // 실패 모달 표시
                    $("#managerErrorModal").modal('show');
                }
            });
        });

        /**
         *  매물 상장
         */
        $("#listingButton").click(function () {
            // 스피너 시작
            $(this).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중...');
            $(this).prop('disabled', true);

            // 선택된 listingNumber 가져오기
            const selectedListingNumber = $("#listingBuildingInput").val();

            // 기존 모달
            var modal = bootstrap.Modal.getInstance(document.getElementById('listingModal'));

            $.ajax({
                url: '/manager/estate-listing',
                type: 'PUT',
                data: {
                    listingNumber: selectedListingNumber
                },
                success: function (response) {
                    // 기존 모달 닫기
                    modal.hide();
                    // 스피너 정지 및 초기화
                    $("#listingButton").html('상장 확인').prop('disabled', false);
                    // 성공 모달 표시
                    $("#managerSuccessModal").modal('show');
                },
                error: function (error) {
                    // 기존 모달 닫기
                    modal.hide();
                    // 스피너 정지 및 초기화
                    $("#listingButton").html('상장 확인').prop('disabled', false);
                    // 실패 모달 표시
                    $("#managerErrorModal").modal('show');
                }
            });
        });

        /**
         *  매각 투표 등록
         */
        $("#saleVoteConfirmBtn").click(function () {
            // 매각 대상 건물
            const listingNumber = $("#saleVoteListingNumber").val();
            // 매각 투표 시작일
            const voteStartDate = $("#voteStartDate").val();
            // 투표 마감일
            const voteExpirationDate = $("#voteExpirationDate").val();
            // 매각액
            const saleAmount = $("#saleAmount").val();
            // 매각 배당금
            const saleDividend = $("#saleDividend").val();

            $.ajax({
                url: '/manager/sale-vote',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    "listingNumber": listingNumber,
                    "startDate": voteStartDate,
                    "expirationDate": voteExpirationDate,
                    "amount": saleAmount,
                    "dividend": saleDividend
                }),
                success: function (response) {
                    // 기존 모달 닫기
                    $("#saleVoteModal").modal('hide');
                    // 성공 모달 표시
                    $("#managerSuccessModal").modal('show');
                },
                error: function (error) {
                    // 기존 모달 닫기
                    $("#saleVoteModal").modal('hide');
                    // 실패 모달 표시
                    $("#managerErrorModal").modal('show');
                }
            })
        });

        /**
         *  배당금 지급
         */
        $("#dividendPaymentSubmit").click(function () {
            // 매각 대상 건물
            const listingNumber = $("#targetBuilding").val();
            // 매각 배당금
            const payout = $("#dividendAmount").val();

            // 스피너 시작
            $(this).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중...');
            $(this).prop('disabled', true);

            $.ajax({
                url: '/manager/dividend-payment',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    "listingNumber": listingNumber,
                    "payout": payout
                }),
                success: function (response) {
                    // 스피너 정지 및 초기화
                    $("#dividendPaymentSubmit").html('지급 확인').prop('disabled', false);
                    // 기존 모달 닫기
                    $("#dividendModal").modal('hide');
                    // 성공 모달 표시
                    $("#managerSuccessModal").modal('show');
                },
                error: function (error) {
                    // 기존 모달 닫기
                    $("#dividendModal").modal('hide');
                    // 실패 모달 표시
                    $("#managerErrorModal").modal('show');
                }
            })
        });

        /**
         *  공지 등록
         */
        $('#writeAnnouncement').click(function () {
            var title = $('#announcementTitle').val();
            var content = $('#announcementContent').val();

            $.ajax({
                url: '/announcement',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    "title": title,
                    "content": content
                }),
                success: function (response) {
                    // 모달 창 닫기
                    $('#announcementModal').modal('hide');
                    // 성공 모달 표시
                    $("#managerSuccessModal").modal('show');
                },
                error: function (error) {
                    console.log(error);
                    // 모달 창 닫기
                    $('#announcementModal').modal('hide');
                    // 실패 모달 표시
                    $("#managerErrorModal").modal('show');
                }
            });
        });
        /**
         *  앱 알림 보내기
         */
        $('#appNotificationTransmit').click(function () {
            var title = $('#appNotificationTitle').val();
            var body = $('#appNotificationContent').val();

            $.ajax({
                url: '/manager/app-notification',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    "title": title,
                    "body": body
                }),
                success: function (response) {
                    // 모달 창 닫기
                    $('#appNotificationModal').modal('hide');
                    // 성공 모달 표시
                    $("#managerSuccessModal").modal('show');
                },
                error: function (error) {
                    console.log(error);
                    // 모달 창 닫기
                    $('#appNotificationModal').modal('hide');
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