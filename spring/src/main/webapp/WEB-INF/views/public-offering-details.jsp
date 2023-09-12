<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/public-offering-order.css">
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
    <h2>청약</h2>
    <hr>
</div>


<div class="estate-wrapper">

    <!-- <img src="/resources/img/lotterTower.jpg" alt="부동산 이미지" class="img-fluid"> -->
    <div class="imageCarousel">
        <div id="carouselExampleControls" class="carousel slide" data-ride="carousel" data-interval="0">
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
            <a class="carousel-control-prev" href="#carouselExampleControls" role="button"
               data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleControls" role="button"
               data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>

    <div class="card mt-3" style="max-width: 500px; width: 100%">

        <div class="card-header">
            <h5 class="card-title">${realEstateInfo.buildingName}</h5>
            <p class="address">${realEstateInfo.address}</p>
        </div>
        <div class="card-body">
            <div class="card-content">
                <p class="value-title">청약 마감</p>
                <h6 class="value" style="color: #E90061"><span id="d-day"></span></h6>
                <small>(${publicationInfo.expirationDate})</small>
            </div>
            <div class="card-content">
                <p class="value-title">공모 가격</p>
                <h6 class="value">5,000원</h6>
                <small>총 ${publicationInfo.totalAmount}원</small>
            </div>
            <div class="card-content">
                <p class="value-title">연 수익 배당</p>
                <h6 class="value">약 <span id="odds"></span>%</h6>
                <small>1토큰당 ${publicationInfo.dividend}원</small>
            </div>
        </div>
    </div>

    <div class="public-offering-wrapper">
        <div class="subscription-card">
            <div class="flex-row">
                <span class="rate-title">청약모집률</span>
                <span class="count-number">5,124명 청약 완료</span>
            </div>
            <div class="flex-row mt-2">
                <span class="rate-percentage">99%</span>
                <span class="count-time">청약 마감까지 <span id="d-day2"></span>일 전</span>
            </div>
            <div class="progress-bar mt-3">
                <div class="progress-fill" style="width: 99%; background-color: #008485;"></div>
            </div>
        </div>
        <!-- 청약 주문 -->
        <div class="trading">
            <div class="trading-items">
                <div class="wallet-pw">
                    <label for="wallet-password">지갑 비밀번호 </label>
                    <input type="password" id="wallet-password" pattern="\d{4}" placeholder="4자리 숫자" maxlength="4"/>
                </div>
                <div class="able-amount">
                    청약 가능 금액: <span id="orderAvailable">원</span>
                </div>
                <div class="price">
                    <span>공모가</span>
                    <input type="number" value="5000" readonly/>
                </div>
                <div class="quantity">
                    <span>청약 수량</span>
                    <div class="quantity-area">
                        <button class="decrease">-</button>
                        <input type="number" placeholder="수량"/>
                        <button class="increase">+</button>
                    </div>
                </div>
                <div class="total-amount">
                    청약 주문 총 액: <span>0원</span>
                </div>
                <div class="order">
                    <input class="btn btn-primary" type="button" value="청약 주문">
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
                <span class="info-label">층수</span>
                <span class="info-value">${realEstateInfo.floors}층</span>
            </div>
            <div class="info-item">
                <span class="info-label">주용도</span>
                <span class="info-value">${realEstateInfo.usage}</span>
            </div>
            <div class="info-item">
                <span class="info-label">대지면적</span>
                <span class="info-value">${realEstateInfo.landArea}m²</span>
            </div>
            <div class="info-item">
                <span class="info-label">연면적</span>
                <span class="info-value">${realEstateInfo.floorArea}m²</span>
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
                <span class="issue-value">${publicationInfo.volume}주</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">발행가액</span>
                <span class="issue-value">${publicationInfo.issuePrice}주</span>
            </div>
            <div class="issue-item">
                <span class="issue-label">총모집액</span>
                <span class="issue-value">${publicationInfo.totalAmount}원</span>
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
                <span class="tenant-name">${tenantInfo.lessee}</span> | <span class="tenant-business">${tenantInfo.sector}</span>
            </div>
            <div class="tenant-duration">
                계약기간 : <span>${tenantInfo.contractDate} ~ ${tenantInfo.expirationDate}</span>
            </div>
        </div>
    </div>

    <!-- 청약 주문 모달 -->
    <div class="modal fade" id="orderModal" tabindex="-1" aria-labelledby="orderModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderModalLabel">청약 주문 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><span>빌딩명:</span><span id="orderModalName">${realEstateInfo.buildingName}</span></p>
                    <p><span>공모가:</span><span id="orderModalPrice">5,000원</span></p>
                    <p><span>수량:</span> <span id="orderModalQuantity"></span></p>
                    <p><span>주문금액:</span><span id="orderModalTotal"></span></p>
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <button type="button" class="btn btn-danger" id="confirmOrder">청약신청</button>
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

<%@ include file="include/footer.jsp" %>


<script>
    var listingNumber = ${publicationInfo.listingNumber};
    var walletNumber = ${wallet.walletNumber};

    /**
     *  청약 마감일 D-day 계산 후 띄우기
     */
    var expirationDate = new Date("${publicationInfo.expirationDate}");
    // 오늘 날짜를 가져오기
    var today = new Date();
    // D-day 계산
    var timeDiff = expirationDate - today;
    var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
    // D-day 값을 HTML에 출력
    document.getElementById("d-day").textContent = "D-" + daysDiff;
    document.getElementById("d-day2").textContent = daysDiff;


    /**
     *  수익 배당율 계산 후 띄우기
     */
    var dividend = ${publicationInfo.dividend};
    var yearDividendRatio = (dividend * 100) / 5000;
    document.getElementById("odds").textContent = yearDividendRatio;

    /**
     *  청약 가능 금액 구하기
     */
    var balance = ${wallet.balance};
    var price = 5000;
    var avail = Math.trunc(balance / price) * 5000;
    document.getElementById("orderAvailable").textContent = avail;

    /**
     *  지도 띄우기
     */
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
    window.onload = function () {
        /**
         *  가격 및 수량 조절 관련 로직
         */
        const quantityInput = document.querySelector('.quantity input');
        const totalAmountSpan = document.querySelector('.total-amount span');
        const submitButton = document.querySelector('.order input');

        document.querySelector('.quantity .decrease').addEventListener('click', function () {
            adjustValue(quantityInput, -1);
        });

        document.querySelector('.quantity .increase').addEventListener('click', function () {
            adjustValue(quantityInput, 1);
        });

        function adjustValue(input, amount) {
            const currentValue = parseInt(input.value) || 0;
            input.value = currentValue + amount;
            updateTotalAmount();
        }

        function updateTotalAmount() {
            const price = 5000;
            const quantity = parseInt(quantityInput.value) || 0;
            const totalAmount = price * quantity;
            totalAmountSpan.textContent = totalAmount.toLocaleString('ko-KR') + ' 원';
        }

        quantityInput.addEventListener('input', updateTotalAmount);

        /**
         *  비동기 주문 모달 처리
         */
        const orderModalPrice = document.getElementById('orderModalPrice');
        const orderModalQuantity = document.getElementById('orderModalQuantity');
        const orderModalTotal = document.getElementById('orderModalTotal');

        // 모달 띄우기
        submitButton.addEventListener('click', function () {
            const quantity = parseInt(quantityInput.value) || 0;
            const total = price * quantity;

            orderModalPrice.textContent = price.toLocaleString('ko-KR') + ' 원';
            orderModalQuantity.textContent = quantity + ' STOS';
            orderModalTotal.textContent = total.toLocaleString('ko-KR') + ' 원';

            new bootstrap.Modal(document.getElementById('orderModal')).show();
        });

        // 매수 및 매도 확인 버튼 클릭 시 AJAX 요청
        document.getElementById('confirmOrder').addEventListener('click', function () {
            handleOrder(this);
        });

        function handleOrder(btnElement) {
            // Spinner 추가 및 버튼 텍스트 숨김
            btnElement.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';
            btnElement.disabled = true;  // 버튼을 비활성화
            var walletPassword = document.getElementById("wallet-password").value;
            sendOrder(walletPassword, quantityInput.value, btnElement);
        }

        /**
         * 청약 신청
         */
        function sendOrder(password, quantity, btnElement) {
            $.ajax({
                type: "POST",
                url: "/public-offering",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    listingNumber: listingNumber,
                    walletNumber: walletNumber,
                    quantity: quantity,
                    password: password
                }),
                success: function(response) {
                    new bootstrap.Modal(document.getElementById('successModal')).show();
                    btnElement.disabled = false;  // 버튼을 활성화
                },
                error: function(error) {
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

<!-- jQuery and Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
        integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
        crossorigin="anonymous"></script>

<!-- carousel 용도 bootstrap4 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>