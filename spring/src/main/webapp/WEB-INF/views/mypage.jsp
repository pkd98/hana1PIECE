<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/mypage.css">
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
    <!-- char.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById('piechart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['현금', '건물1', '건물2'],
                    datasets: [{
                        label: '보유 자산',
                        backgroundColor: ['#008085', '#E90061', '#f3a505'],
                        data: [50000, 150000, 75000]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    title: {
                        display: true,
                        text: '사용자님의 자산 분포',
                        fontSize: 16
                    }
                }
            });
        });
    </script>

</head>

<body>

<%@ include file="include/header.jsp" %>

<div class="titleBar">
    <h2>마이페이지</h2>
    <hr>
</div>


<div class="container mt-2">
    <!-- 제목 -->
    <div class="mypage-title">
        <span class="username">${sessionScope.member.name}</span><span class="asset-title">님의 보유 자산</span>
    </div>

    <!-- 총 자산 & 파이 차트 영역 -->
    <div class="row equal-height-row">
        <div class="col-lg-6 col-md-6 col-sm-12 mb-3">
            <!-- 총 자산 -->
            <div class="card total-asset">
                <div class="card-header">총 자산</div>
                <div class="card-body flex1" id="total-asset-body">
                    <h3 class="formatted-number">123,456원 <span class="percentage">(+0.00%)</span></h3>
                    <hr>
                    <p class="formatted-number">예치금: 999,999원</p>
                    <p class="formatted-number">투자 금액: 10,000원</p>
                    <p class="formatted-number">투자 수익: 999,999,999,999원</p>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12 mb-3">
            <!-- 파이 차트 -->
            <div class="card total-asset">
                <div class="card-header">자산 분포</div>
                <div class="card-body flex1">
                    <!-- 차트 -->
                    <canvas id="piechart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <div class="my-wallet card" style="background-color: #008485; color: white; ">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p class="wallet-title">내 지갑</p>
                    <a data-bs-toggle="modal" data-bs-target="#bankHistory">
                        <img class="bank-logo" src="/resources/img/hanaLogo.svg" alt="Bank" class="bank-image">
                        <span>하나은행 연동 중</span>
                    </a>
                </div>
                <div class="col-md-6 button-right">
                    <p class="wallet-amount">총 <span class="formatted-number">${wallet.balance}</span> 원</p>
                    <button class="btn bank-btn" data-bs-toggle="modal" data-bs-target="#depositModal">입금</button>
                    <button class="btn bank-btn" data-bs-toggle="modal" data-bs-target="#withdrawModal">출금</button>
                    <button class="btn bank-transaction-btn" data-bs-toggle="modal"
                            data-bs-target="#transactionHistory">입출금 내역
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 입금 모달 -->
    <div class="modal fade" id="depositModal" tabindex="-1" aria-labelledby="depositModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100 font-weight-bold" id="depositModalLabel">입금 신청</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex justify-content-between">
                        <span>연동 계좌:</span>
                        <span>${wallet.accountNumber}</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span>계좌 잔액:</span>
                        <span class="formatted-number">${account.balance}원</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-2">
                        <span>계좌 비밀번호:</span>
                        <input id="account-password" type="password" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                               placeholder="비밀번호 4자리" required>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-2">
                        <span>입금 금액:</span>
                        <input id="deposit-amount" type="number" placeholder="금액 입력">
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-primary" id="deposit-button"
                            style="background-color: #008485; width: 50%;">입금신청
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 출금 모달 -->
    <div class="modal fade" id="withdrawModal" tabindex="-1" aria-labelledby="withdrawModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100" id="withdrawModalLabel">출금신청</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex justify-content-between">
                        <span>연동 계좌번호:</span>
                        <span>${wallet.accountNumber}</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span>출금 가능액:</span>
                        <span class="formatted-number">${wallet.balance}원</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-2">
                        <span>지갑 비밀번호:</span>
                        <input id="wallet-password" type="password" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                               placeholder="비밀번호 4자리" required>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-2">
                        <span>출금 금액:</span>
                        <input id="withdraw-amount" type="number" placeholder="금액 입력">
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <button id="withdraw-button" type="button" class="btn btn-primary"
                            style="background-color: #008485; width: 50%;">출금신청
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 지갑 거래내역 모달 -->
    <div class="modal fade" id="transactionHistory" tabindex="-1" aria-labelledby="transactionHistoryLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100 font-weight-bold">지갑 거래내역</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" style="max-height: 400px; overflow-y: auto;">
                    <div class="btn-group" role="group">
                        <button class="btn btn-default filter-btn1 active" data-filter="all">전체</button>
                        <button class="btn btn-default filter-btn1" data-filter="IN">입금</button>
                        <button class="btn btn-default filter-btn1" data-filter="OUT">출금</button>
                    </div>
                    <table class="table custom-table">
                        <thead>
                        <tr>
                            <th>#거래내역번호</th>
                            <th>구분</th>
                            <th>거래명</th>
                            <th>거래액</th>
                            <th>잔액</th>
                            <th>거래일시</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="walletTransaction" items="${walletTransactionList}">
                            <tr>
                                <td>${walletTransaction.transactionNumber}</td>
                                <td>${walletTransaction.classification}</td>
                                <td>${walletTransaction.name}</td>
                                <td class="formatted-number">${walletTransaction.amount}</td>
                                <td class="formatted-number">${walletTransaction.balance}</td>
                                <td>${walletTransaction.transactionDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">이전</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 은행 입출금 거래내역 모달 -->
    <div class="modal fade" id="bankHistory" tabindex="-1" aria-labelledby="bankHistoryLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100 font-weight-bold">은행 거래내역</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" style="max-height: 400px; overflow-y: auto;">
                    <div class="btn-group" role="group">
                        <button class="btn btn-default filter-btn2 active" data-filter="all">전체</button>
                        <button class="btn btn-default filter-btn2" data-filter="IN">입금</button>
                        <button class="btn btn-default filter-btn2" data-filter="OUT">출금</button>
                    </div>
                    <table class="table custom-table">
                        <thead>
                        <tr>
                            <th>#거래내역번호</th>
                            <th>구분</th>
                            <th>거래명</th>
                            <th>거래액</th>
                            <th>잔액</th>
                            <th>상대은행코드</th>
                            <th>상대계좌번호</th>
                            <th>거래일시</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 예제 데이터 -->
                        <c:forEach var="bankTransaction" items="${bankTransactionList}">
                            <tr>
                                <td>${bankTransaction.transactionNumber}</td>
                                <td>${bankTransaction.classification}</td>
                                <td>${bankTransaction.name}</td>
                                <td class="formatted-number">${bankTransaction.amount}</td>
                                <td class="formatted-number">${bankTransaction.balance}</td>
                                <td>${bankTransaction.bankCode}</td>
                                <td>${bankTransaction.recipientAccountNumber}</td>
                                <td>${bankTransaction.transactionDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">이전</button>
                </div>
            </div>
        </div>
    </div>


</div>

<div class="container mt-2">
    <!-- 제목 -->
    <div class="mypage-title">
        <span class="holding-title">보유 빌딩</span>
    </div>

    <!-- 청약중 -->
    <div class="public-offering">
        <c:forEach var="list" items="${membersOrderPublicOfferingDTOList}">
            <div class="my-wallet card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center flex-grow-1">
                        <img class="bank-logo" src="/resources/upload/${list.listingNumber}/${list.image1}" alt="image1" class="bank-image">
                        <span class="card-title building-name ml-2 text-center mb-0">${list.buildingName} (${list.quantity} STO)</span>
                    </div>
                    <div class="text-center">
                        <p class="building-name mb-0 expirationDate" data-date="${list.expirationDate}"></p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 보유 빌딩 -->
    <div class="row equal-height-row">
        <div class="col-lg-6 col-md-6 col-sm-12 mb-3">
            <div class="card total-asset">
                <div class="card-header">
                    롯데월드타워 1층 1호
                </div>
                <div class="card-body flex1">
                    <small>1STO가격</small>
                    <h3 class="formatted-number">5,100원 <span class="percentage">(+4.00%)</span></h3>
                    <hr>
                    <p>보유수량: <span>123STO</span></p>
                    <p>매수 평균가: <span class="formatted-number">4,400원</span></p>
                    <p>평가금액: <span class="formatted-number">1,111,111원</span></p>
                    <p>투자금액: <span class="formatted-number">1,000,000원</span></p>
                    <div class="dividend-button-section">
                        <button type="button" class="btn btn-primary" id="detailsTransaction" data-bs-toggle="modal"
                                data-bs-target="#transactionModal">거래내역
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="transactionModal" tabindex="-1" aria-labelledby="transactionModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center w-100 font-weight-bold">거래내역</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="max-height: 400px; overflow-y: auto;">
                        <table class="table custom-table">
                            <thead>
                            <tr>
                                <th>#주문번호</th>
                                <th>유형</th>
                                <th>주문금액</th>
                                <th>주문수량</th>
                                <th>주문상태</th>
                                <th>주문일시</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 예제 데이터; 필요에 따라 데이터를 추가하십시오. -->
                            <tr>
                                <td>12345678</td>
                                <td>매수</td>
                                <td>10,000</td>
                                <td>5</td>
                                <td>체결</td>
                                <td>2023-08-21 13:00:00</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">이전</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 배당금 지급 -->
    <div class="dividend">
        <div class="card">
            <div class="card-body">
                <div class="dividend-text">
                    <div class="dividend-title-container">
                        <span class="card-title dividend-title">최근 6개월 누적 배당금</span>
                    </div>
                    <div class="dividend-amount-container">
                        <span class="card-title dividend-amount">총 <span class="formatted-number">550원</span></span>
                    </div>
                </div>
                <div class="dividend-button-section">
                    <!-- 데이터 토글과 대상 설정 추가 -->
                    <button type="button" class="btn btn-primary" id="dividend-button" data-bs-toggle="modal"
                            data-bs-target="#dividendModal">상세 지급 내역
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- 모달 -->
    <div class="modal fade" id="dividendModal" tabindex="-1" role="dialog" aria-labelledby="dividendModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100 font-weight-bold">배당금 지급 내역</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table custom-table">
                        <thead>
                        <tr>
                            <th>지급번호</th>
                            <th>건물명</th>
                            <th>지급액</th>
                            <th>지급일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 예제 데이터 -->
                        <tr>
                            <td>12345678</td>
                            <td>롯데월드타워 1층</td>
                            <td>100원</td>
                            <td>2023-08-20</td>
                        </tr>
                        <!-- 추가 데이터를 여기에 삽입할 수 있습니다 -->
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">이전</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container mt-2">
        <!-- 제목 -->
        <div class="mypage-title">
            <span class="holding-title">티끌모아 건물주</span>
        </div>

        <div class="no-preorder">
            <p>진행 중인 예약 주문이 없습니다.</p>
        </div>

        <!-- 티끌모아 건물주 -->
        <div class="pre-order">
            <div class="my-wallet card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center flex-grow-1">
                        <img class="bank-logo" src="/resources/img/lotterTower.jpg" alt="Bank" class="bank-image">
                        <span class="card-title building-name ml-2 text-center mb-0">롯데월드 타워 1층 1호</span>
                    </div>
                    <div class="text-center">
                        <p class="building-name mb-0"><span>0</span>일 동안 모았어요!</p>
                    </div>
                </div>
                <div class="preorder-button-section">
                    <button type="button" class="btn btn-primary" id="preorder-button1">취소하기</button>
                </div>
            </div>

            <div class="my-wallet card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center flex-grow-1">
                        <img class="bank-logo" src="/resources/img/lotterTower.jpg" alt="Bank" class="bank-image">
                        <span class="card-title building-name ml-2 text-center mb-0">롯데월드 타워 1층 1호</span>
                    </div>
                    <div class="text-center">
                        <p class="building-name mb-0"><span>0</span>일 동안 모았어요!</p>
                    </div>
                </div>
                <div class="preorder-button-section">
                    <button type="button" class="btn btn-primary" id="preorder-button2">취소하기</button>
                </div>
            </div>

        </div>
    </div>


    <div class="container mt-2">
        <!-- 제목 -->
        <div class="mypage-title">
            <span class="sold-title">매각 투표</span>
        </div>
        <div class="no-sold">
            <p>진행 중인 매각 투표가 없습니다.</p>
        </div>

        <div class="row equal-height-row">

            <div class="col-lg-6 col-md-6 col-sm-12 mb-3">
                <div class="card total-asset">
                    <div class="card-header">롯데월드타워 1층 1호</div>
                    <div class="card-body flex1">
                        <p>투표기간: <span>2023-01-01</span> ~ <span>2023-01-01</span></p>
                        <p>공모금액: <span>1,000,000,000원</span></p>
                        <p>매각금액: <span>1,300,000,000원</span></p>
                        <p>1STO당 매각 배당금: <span>6,500원</span></p>
                        <hr>
                        <P style="font-weight: bold;">투표진행률(20%)</P>

                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 20%;" aria-valuenow="20"
                                 aria-valuemin="0" aria-valuemax="100"></div>
                        </div>

                        <div class="dividend-button-section">
                            <button type="button" class="btn btn-primary" id="voteButton" data-bs-toggle="modal"
                                    data-bs-target="#votingModal">투표하기
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 투표하기 버튼 모달 -->
            <div class="modal fade" id="votingModal" tabindex="-1" aria-labelledby="votingModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title text-center w-100 font-weight-bold">매각 투표</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" style="padding: 20px 40px;"> <!-- 양 끝쪽 여백 설정 -->
                            <div class="row">
                                <div class="col-md-6 text-left">건물명 :</div>
                                <div class="col-md-6 text-right" style="font-weight: bold;">롯데월드타워 1층 1호</div>
                                <!-- bold 처리 -->
                                <div class="col-md-6 text-left">공모가 :</div>
                                <div class="col-md-6 text-right formatted-number" style="font-weight: bold;">
                                    1,000,000,000원
                                </div>
                                <!-- bold 처리 -->
                                <div class="col-md-6 text-left">매각액 :</div>
                                <div class="col-md-6 text-right formatted-number" style="font-weight: bold;">
                                    1,300,000,000원
                                </div>
                                <!-- bold 처리 -->
                                <div class="col-md-6 text-left">보유 STO :</div>
                                <div class="col-md-6 text-right" style="font-weight: bold;">123STO</div>
                                <!-- bold 처리 -->
                                <div class="col-md-6 text-left">예상 매각 배당금 :</div>
                                <div class="col-md-6 text-right formatted-number" style="font-weight: bold;">6,500원
                                </div>
                                <!-- bold 처리 -->
                            </div>
                            <hr>
                            <div class="text-center">
                                <div class="custom-radio">
                                    <input type="radio" id="approve" name="vote" value="approve">
                                    <label for="approve">찬성</label>
                                </div>
                                <div class="custom-radio">
                                    <input type="radio" id="oppose" name="vote" value="oppose">
                                    <label for="oppose">반대</label>
                                </div>
                                <div>
                                    <button type="button" class="btn btn-primary mt-3"
                                            style="background-color: #008485; width: 50%;">투표하기
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 성공 모달 -->
    <div class="modal fade" id="myPageSuccessModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="padding: 50px; justify-content: center; text-align: center;">
                    성공적으로 처리되었습니다.
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal"
                            onclick="redirectToMyPage()">닫기</strong>
                </div>
            </div>
        </div>
    </div>

    <!-- 실패 모달 -->
    <div class="modal fade" id="myPageErrorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="padding: 50px; justify-content: center; text-align: center;">
                    처리 중 오류가 발생했습니다.
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal"
                            onclick="redirectToMyPage()">닫기</strong>
                </div>
            </div>
        </div>
    </div>

</div>

<%@ include file="include/footer.jsp" %>

<script>
    function redirectToMyPage() {
        window.location.href = "/mypage";
    }

    function formatNumbers() {
        $('.formatted-number').each(function() {
            var number = $(this).text();
            var formattedNumber = numberWithCommas(number);
            $(this).text(formattedNumber);
        });
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    $(document).ready(function() {
        /**
         *  금액 천단위 구분 쉼표 추가
         */
        formatNumbers();

        /**
         *  지갑 입금 PUT 비동기 요청
         */
        $("#deposit-button").on('click', function() {
            // 데이터 가져오기
            let accountPassword = $("#account-password").val();
            let depositAmount = $("#deposit-amount").val();
            // 스피너 시작
            $(this).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중...');
            $(this).prop('disabled', true);

            $.ajax({
                type: "PUT",
                url: "/deposit",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    accountPassword: accountPassword,
                    amount: depositAmount
                }),
                success: function(response) {
                    // 스피너 정지 및 초기화
                    $("#deposit-button").html('입금신청').prop('disabled', false);
                    // 성공 모달 표시
                    $("#myPageSuccessModal").modal('show');
                },
                error: function(error) {
                    // 스피너 정지 및 초기화
                    $("#deposit-button").html('입금신청').prop('disabled', false);
                    // 실패 모달 표시
                    $("#myPageErrorModal").modal('show');
                }
            });
        });

        /**
         *  지갑 출금 PUT 비동기 요청
         */
        $("#withdraw-button").on('click', function() {
            // 데이터 가져오기
            let walletPassword = $("#wallet-password").val();
            let withdrawAmount = $("#withdraw-amount").val();
            // 스피너 시작
            $(this).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중...');
            $(this).prop('disabled', true);

            $.ajax({
                type: "PUT",
                url: "/withdraw",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    walletPassword: walletPassword,
                    amount: withdrawAmount
                }),
                success: function(response) {
                    // 스피너 정지 및 초기화
                    $("#withdraw-button").html('출금신청').prop('disabled', false);
                    // 성공 모달 표시
                    $("#myPageSuccessModal").modal('show');
                },
                error: function(error) {
                    // 스피너 정지 및 초기화
                    $("#withdraw-button").html('출금신청').prop('disabled', false);
                    // 실패 모달 표시
                    $("#myPageErrorModal").modal('show');
                }
            });
        });

        /**
         *  입출금 내역 필터링
         */
        $('.filter-btn1').on('click', function() {
            $('.filter-btn1').removeClass('active');  // 모든 버튼의 active 클래스를 제거
            $(this).addClass('active');  // 현재 클릭된 버튼에 active 클래스를 추가

            var filterValue = $(this).data('filter');

            $('tbody tr').each(function() {
                var classification = $(this).find('td:nth-child(2)').text();

                if (filterValue === 'all') {
                    $(this).show();
                } else {
                    if (classification === filterValue) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                }
            });
        });
        /**
         *  은행 거래내역 필터링 구현
         */
        $('.filter-btn2').on('click', function() {
            $('.filter-btn2').removeClass('active');  // 모든 버튼의 active 클래스를 제거
            $(this).addClass('active');  // 현재 클릭된 버튼에 active 클래스를 추가

            var filterValue = $(this).data('filter');

            $('tbody tr').each(function() {
                var classification = $(this).find('td:nth-child(2)').text();

                if (filterValue === 'all') {
                    $(this).show();
                } else {
                    if (classification === filterValue) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                }
            });
        });
    });

    /**
     *  청약 마감일 (D-day 변환) 표기
     */
    window.onload = function() {
        // 모든 expirationDate 요소 선택
        let expirationDates = document.querySelectorAll('.expirationDate');

        // 현재 날짜 설정
        let today = new Date();
        today.setHours(0, 0, 0, 0);  // 시간, 분, 초, 밀리초 초기화

        expirationDates.forEach((element) => {
            let endDate = new Date(element.getAttribute('data-date'));
            let diffTime = endDate.getTime() - today.getTime();
            let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

            element.textContent = '결과 발표 D-' + diffDays;
        });
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