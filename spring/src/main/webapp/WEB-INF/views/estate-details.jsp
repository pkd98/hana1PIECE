<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/estate-details.css">
    <link rel="stylesheet" href="/resources/style/font.css">
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!-- animation cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <!-- fabicon -->
    <link rel="icon" href="/resources/img/favicon.png">
    <!-- kakao map api -->
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5082aba073eeee4dbd5606104fd17280"></script>
    <!-- ajax -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>하나1PIECE</title>
</head>
<%@ include file="include/header.jsp" %>

<div class="titleBar">
    <h2>투자하기</h2>
    <hr>
</div>

<div class="estate-wrapper">

    <div class="imageCarousel">
        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100"
                         src="/resources/upload/${realEstateInfo.listingNumber}/${realEstateInfo.image1}"
                         alt="image1">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100"
                         src="/resources/upload/${realEstateInfo.listingNumber}/${realEstateInfo.image2}"
                         alt="image2">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100"
                         src="/resources/upload/${realEstateInfo.listingNumber}/${realEstateInfo.image3}"
                         alt="image3">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls"
                    data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls"
                    data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <div class="card mt-3" style="max-width: 500px; width: 100%">

        <div class="card-header">
            <h5 class="card-title">${realEstateInfo.buildingName}</h5>
            <p class="address">${realEstateInfo.address}</p>
        </div>
        <div class="card-body">
            <div class="card-content">
                <div class="container">
                    <p class="value-title"><img id="info" src="/resources/img/info.png" alt="info" width="18"
                                                height="18"> 실제 건물 가치</p>
                </div>
                <div class="info-description" id="description"><b style="color: #E90061;">실건물의 평당가</b>를 환산한 가격
                    입니다. </br> * <i>네이버 부동산 제공</i></div>
                <h6 class="value"><span id="resonablePrice"
                                        class="formatted-number">${realEstateSale.reasonablePrice}</span>원</h6>
                <small id="yesterday"></small>
            </div>
            <div class="card-content">
                <p class="value-title">토큰 가격</p>
                <h6 class="value formatted-number" style="color: red; font-size: 2rem;"><span
                        id="realEstatePrice">${realEstateSale.price}</span>원</h6>
            </div>
            <div class="card-content">
                <p class="value-title">실제 건물 대비</p>
                <h6 class="value" id="percentageDifference"></h6>
                <small id="evaluationText"></small>
            </div>
        </div>
    </div>

    <!-- 거래하기, 티끌모아 건물주 버튼 추가 -->
    <div class="buttons">
        <div class="mt-3 btn-group">
            <button type="button" class="btn btn-primary" onclick="goToTrading()">거래하기</button>
            <button type="button" class="btn btn-primary" id="preOrderButton">티끌모아 건물주</button>
        </div>

        <!-- 친구에게 공유하기 버튼 추가 -->
        <div class="mt-1 kakao-share">
            <button type="button" class="btn btn-primary" onclick="javascript:kakaoShare()"><img
                    src="/resources/img/kakao.svg" al기t="">친구에게 공유하기
            </button>
        </div>
    </div>

    <div class="wrapper">
        <div class="profit-header">
            <h3 class="profit-title">수익 배당</h3>
        </div>

        <div class="card mt-2" style="max-width: 500px; width: 100%">
            <div class="card-body">
                <div class="card-content">
                    <p class="detail-title">배당 기준일</p>
                    <h6 class="detail-value" id="firstDividendDate">${publicationInfo.firstDividendDate}일</h6>
                </div>
                <div class="card-content">
                    <p class="detail-title">배당 주기</p>
                    <h6 class="detail-value">${publicationInfo.dividendCycle}개월</h6>
                </div>
                <div class="card-content">
                    <p class="detail-title">토큰 분배금(연)</p>
                    <h6 class="detail-value">${publicationInfo.dividend}원</h6>
                </div>
            </div>
        </div>
    </div>

    <div class="wrapper">
        <div class="profit-header">
            <h3 class="profit-title">주변 살펴보기</h3>
            <p class="address">서울시 송파구</p>
        </div>

        <div id="map"></div>
    </div>

    <div class="wrapper">
        <div class="profit-header">
            <h3 class="profit-title">건물 정보</h3>
        </div>

        <div class="info-card">
            <div class="info-item">
                <span class="info-label">건물명</span>
                <span class="info-value">${realEstateInfo.buildingName}</span>
            </div>
            <div class="info-item">
                <span class="info-label">상세 주소</span>
                <span class="info-value">${realEstateInfo.address}</span>
            </div>
            <div class="info-item">
                <span class="info-label">공급면적</span>
                <span class="info-value">${realEstateInfo.supplyArea}평형</span>
            </div>
            <div class="info-item">
                <span class="info-label">층수</span>
                <span class="info-value">${realEstateInfo.floors}층</span>
            </div>
            <div class="info-item">
                <span class="info-label">주용도</span>
                <span class="info-value">${realEstateInfo.usage}</span>
            </div>
            <div class="info-item">
                <span class="info-label">대지면적</span>
                <span class="info-value formatted-number">${realEstateInfo.landArea}m²</span>
            </div>
            <div class="info-item">
                <span class="info-label">연면적</span>
                <span class="info-value formatted-number">${realEstateInfo.floorArea}m²</span>
            </div>
            <div class="info-item">
                <span class="info-label">건폐율</span>
                <span class="info-value">${realEstateInfo.coverageRatio}%</span>
            </div>
            <div class="info-item">
                <span class="info-label">용적률</span>
                <span class="info-value">${realEstateInfo.floorAreaRatio}%</span>
            </div>
            <div class="info-item">
                <span class="info-label">준공일</span>
                <span class="info-value">${realEstateInfo.completionDate}</span>
            </div>
        </div>
    </div>

    <div class="wrapper">
        <div class="profit-header">
            <h3 class="profit-title">발행 정보</h3>
        </div>

        <div class="issue-card">
            <div class="issue-item">
                <span class="issue-label">공모대상</span>
                <span class="issue-value">${publicationInfo.subject}</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">증권 종류</span>
                <span class="issue-value">${publicationInfo.type}</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">발행인</span>
                <span class="issue-value">${publicationInfo.publisher}</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">발행 증권수</span>
                <span class="issue-value formatted-number">${publicationInfo.volume}주</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">발행가액</span>
                <span class="issue-value formatted-number">${publicationInfo.issuePrice}원</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">총모집액</span>
                <span class="issue-value formatted-number">${publicationInfo.totalAmount}원</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">청약일정</span>
                <span class="issue-value">${publicationInfo.startDate} ~ ${publicationInfo.expirationDate}</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">최초 배당 기준일</span>
                <span class="issue-value">${publicationInfo.firstDividendDate}</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">배당 주기</span>
                <span class="issue-value">${publicationInfo.dividendCycle}개월</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">연 배당액</span>
                <span class="issue-value">${publicationInfo.dividend}원</span>
            </div>
        </div>
    </div>

    <div class="wrapper">
        <div class="profit-header">
            <h3 class="profit-title">임차인 정보</h3>
        </div>

        <div class="tenant-card">
            <div class="tenant-header">
                <span class="tenant-name">${tenantInfo.lessee}</span> | <span
                    class="tenant-business">${tenantInfo.sector}</span>
            </div>
            <div class="tenant-duration">
                계약기간 : <span>${tenantInfo.contractDate} ~ ${tenantInfo.expirationDate}</span>
            </div>
        </div>
    </div>

    <!-- 예약 주문 모달 -->
    <div class="modal fade" id="pre-orderModal" tabindex="-1" aria-labelledby="orderModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="pre-orderModalLabel">티끌모아 건물주 주문</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="pre-orderModalName">
                        <p id="building-name">${realEstateInfo.buildingName}</p>
                        <p>몇개씩 모을까요?</p>
                    </div>
                    <div class="trading">
                        <div class="trading-items">
                            <div class="quantity">
                                <button class="decrease">-</button>
                                <input type="number" placeholder="수량"/>
                                <button class="increase">+</button>
                            </div>
                            <div class="explanation">
                                <p>* 매일 아침9시 시장가로 예약 주문됩니다.</p>
                                <p>* 시작일: <span class="today"></span> ~ 해지시까지</p>
                                <p>* 지갑 예치금이 부족할 경우 자동 해지됩니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <button type="button" class="btn btn-danger" id="confirmOrder">주문 확인</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 비밀번호 입력 모달 -->
    <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="height: 300px; justify-self: center;align-items: center;">
                    <div class="wallet-pw">
                        <label for="wallet-password">지갑 비밀번호</label>
                        <input type="password" id="wallet-password" pattern="\d{4}" placeholder="4자리 숫자"
                               maxlength="4"/>
                    </div>
                    <div class="modal-footer" style="justify-content: center;">
                        <button type="button" class="btn btn-primary" id="cancle">취소</button>
                        <button type="button" class="btn btn-danger" id="final-confirm">주문 확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 성공 모달 -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="height: 150px; justify-self: center;align-items: center;">
                    주문이 성공적으로 처리되었습니다.
                </div>
                <div class="modal-footer" style="padding: 50px">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal">닫기</strong>
                </div>
            </div>
        </div>
    </div>

    <!-- 실패 모달 -->
    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="padding: 50px">
                    주문 처리 중 오류가 발생했습니다.
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <strong style="cursor: pointer;" class="modal-close-text" data-bs-dismiss="modal">닫기</strong>
                </div>
            </div>
        </div>
    </div>

</div>

<%@ include file="include/footer.jsp" %>

<script>

    /**
     * mounse over info 구현
     */
    const valueTitle = document.getElementById('info');
    const description = document.getElementById('description');

    // 마우스가 요소에 들어갈 때
    valueTitle.addEventListener('mouseenter', () => {
        // 추가 설명 내용을 보이도록 스타일 변경
        description.style.display = 'block';
    });

    // 마우스가 요소에서 나갈 때
    valueTitle.addEventListener('mouseleave', () => {
        // 추가 설명 내용을 숨기도록 스타일 변경
        description.style.display = 'none';
    });


    /**
     *  배당 기준일 문자 포멧 변경
     */
    var fullDate = "${publicationInfo.firstDividendDate}";
    var dateParts = fullDate.split('.');
    if (dateParts.length === 3) {
        document.getElementById("firstDividendDate").textContent = dateParts[2] + "일";
    }

    /**
     * 어제 일자 구하기
     */
    function getYesterday() {
        let date = new Date();
        date.setDate(date.getDate() - 1); // 어제 날짜 설정

        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1을 해주고, 두 자리 수를 유지하기 위해 padStart 사용
        const day = String(date.getDate()).padStart(2, '0'); // 일자 두 자리 유지

        return '(' + year + '.' + month + '.' + day + ')';
    }


    /**
     * 천단위 구분
     */
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

    var listingNumber = ${publicationInfo.listingNumber};
    var walletNumber = ${wallet.walletNumber};

    /**
     * 거래하기 이동
     */
    function goToTrading() {
        window.location.href = "/estate-trading/" + listingNumber;
    }

    var latitude = ${realEstateInfo.latitude};
    var longitude = ${realEstateInfo.longitude};

    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(latitude, longitude),
        level: 3
    };
    // 지도 생성
    var map = new kakao.maps.Map(container, options);
    // 
    var markerPosition = new kakao.maps.LatLng(latitude, longitude);

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
</script>
<script>
    // '티끌모아 건물주' 버튼 클릭시, 모달 표시
    document.getElementById('preOrderButton').addEventListener('click', function () {
        var preorderModal = new bootstrap.Modal(document.getElementById('pre-orderModal'));
        preorderModal.show();
    });

    document.getElementById('confirmOrder').addEventListener('click', function () {
        // 현재 모달을 숨깁니다
        var preorderModal = bootstrap.Modal.getInstance(document.getElementById('pre-orderModal'));
        preorderModal.hide();

        // passwordModal을 표시합니다.
        var passwordModal = new bootstrap.Modal(document.getElementById('passwordModal'));
        passwordModal.show();
    });

    document.getElementById('cancle').addEventListener('click', function () {
        var passwordModal = bootstrap.Modal.getInstance(document.getElementById('passwordModal'));
        passwordModal.hide();
    });

    window.onload = function () {
        /**
         *  매물 평가 표기
         */
        const reasonablePrice = parseFloat(document.getElementById("resonablePrice").innerText);
        const tokenPrice = parseFloat(document.getElementById("realEstatePrice").innerText);
        const differencePercentage = ((tokenPrice - reasonablePrice) / reasonablePrice) * 100;
        document.getElementById("percentageDifference").innerText = differencePercentage.toFixed(2) + '%';
        console.log(differencePercentage);
        let evaluationText = '';
        if (differencePercentage <= -10) {
            evaluationText = '매우 저평가';
        } else if (-10 < differencePercentage && differencePercentage <= -5) {
            evaluationText = '저평가';
        } else if (-5 <= differencePercentage && differencePercentage < 5) {
            evaluationText = '적정가';
        } else if (5 <= differencePercentage && differencePercentage < 10) {
            evaluationText = '고평가';
        } else if (differencePercentage >= 10) {
            evaluationText = '매우 고평가';
        }
        document.getElementById("evaluationText").innerText = evaluationText;

        /**
         *  금액 천단위 구분 쉼표 추가
         */
        formatNumbers();
        /**
         * 어제 날짜 표기
         */
        document.getElementById("yesterday").innerText = getYesterday();

        /**
         *  수량 조절 관련 로직
         */
        const quantityInput = document.querySelector('.quantity input');

        document.querySelector('.quantity .decrease').addEventListener('click', function () {
            adjustValue(quantityInput, -1);
        });

        document.querySelector('.quantity .increase').addEventListener('click', function () {
            adjustValue(quantityInput, 1);
        });

        function adjustValue(input, amount) {
            const currentValue = parseInt(input.value) || 0;
            input.value = currentValue + amount;
            const quantity = parseInt(quantityInput.value) || 0;
        }

        /**
         *  예약 주문 최종 전송
         */
        document.getElementById('final-confirm').addEventListener('click', function () {
            handleOrder(this);
        });

        function handleOrder(btnElement) {
            // Spinner 추가 및 버튼텍스트 숨김
            btnElement.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';
            btnElement.disabled = true;  // 버튼을 비활성화

            sendOrder(quantityInput.value, btnElement);
        }

        function sendOrder(quantity, btnElement) {
            const password = document.getElementById('wallet-password').value;
            var passwordModal = bootstrap.Modal.getInstance(document.getElementById('passwordModal'));

            $.ajax({
                url: '/reservation-order',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    reservationOrdersVO: {
                        listingNumber: listingNumber,
                        walletNumber: walletNumber,
                        quantity: quantity
                    },
                    walletPassword: password
                }),
                success: function (data) {
                    passwordModal.hide();

                    // 성공적으로 처리된 경우
                    new bootstrap.Modal(document.getElementById('successModal')).show();
                    btnElement.disabled = false;  // 버튼을 활성화
                },
                error: function () {
                    passwordModal.hide();

                    // 오류 발생한 경우
                    new bootstrap.Modal(document.getElementById('errorModal')).show();
                    btnElement.disabled = false;  // 버튼을 활성화
                }
            });
        }

        // 처리 후 모달 닫기 버튼 누르면 페이지 초기화
        document.querySelectorAll('.modal-close-text').forEach(closeText => {
            closeText.addEventListener('click', function () {
                location.reload();
            });
        });
    }


</script>

<!-- kakao sdk 호출 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!-- 공유하기 기능 구현 -->
<script type="text/javascript">
    // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('5082aba073eeee4dbd5606104fd17280');

    // SDK 초기화 여부를 판단합니다.
    console.log(Kakao.isInitialized());

    function kakaoShare() {
        Kakao.Link.sendDefault({
            objectType: 'feed',
            content: {
                title: '하나1PIECE',
                description: '지금 바로 [${realEstateInfo.buildingName}] 건물주가 되어보세요!',
                imageUrl: 'https://hana1piece.store/resources/upload/${realEstateInfo.listingNumber}/${realEstateInfo.image1}',
                link: {
                    mobileWebUrl: 'https://naver.me/5zlH0iWG',
                    webUrl: 'https://hana1piece.store',
                },
            },
            buttons: [
                {
                    title: '지금 건물주 되기!',
                    link: {
                        mobileWebUrl: 'https://naver.me/5zlH0iWG',
                        webUrl: 'https://hana1piece.store',
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