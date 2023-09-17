<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/estate-trading.css">
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
    <!-- Web Socket -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <title>하나1PIECE</title>
</head>

<body>

<%@ include file="include/header.jsp" %>

<div class="titleBar">
    <h2>투자하기</h2>
    <hr>
</div>

<div class="wrapper">
    <div class="wrapper2">
        <h2 class="estate-title">${realEstateInfo.buildingName}</h2>

        <table class="orderbook-table">
            <colgroup>
                <col style="width:33%;">
                <col style="width:33%;">
                <col style="width:33%;">
            </colgroup>
            <thead>
            <tr>
                <th scope="col">매도잔량</th>
                <th scope="col">호가</th>
                <th scope="col">매수잔량</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>

    <div class="wrapper2">
        <div class="trading">
            <div class="trading-items">
                <div class="buy-sell-change">
                    <!-- Bootstrap Button Group -->
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-secondary active">구매</button>
                        <button type="button" class="btn btn-secondary">판매</button>
                    </div>
                </div>
                <div class="wallet-pw">
                    <label for="wallet-password">지갑 비밀번호 </label>
                    <input type="password" id="wallet-password" pattern="\d{4}" placeholder="4자리 숫자"
                           maxlength="4"/>
                </div>
                <div class="able-amount">
                    <span id="ableAmountName">거래 가능 금액:</span> <span id="ableAmountValue">${wallet.balance} 원</span>
                </div>
                <div class="price">
                    <span>구매 희망 단가</span>
                    <button class="decrease">-</button>
                    <input type="number" placeholder="가격"/>
                    <button class="increase">+</button>
                </div>
                <div class="quantity">
                    <span>구매 희망 수량</span>
                    <button class="decrease">-</button>
                    <input type="number" placeholder="수량"/>
                    <button class="increase">+</button>
                </div>
                <div class="total-amount">
                    주문 총 액: <span>0원</span>
                </div>
                <div class="buy-sell">
                    <input class="btn btn-primary" type="button" value="매수">
                </div>
            </div>
        </div>
    </div>

    <!-- 주문확인 모달 -->
    <!-- 매수 모달 -->
    <div class="modal fade" id="buyModal" tabindex="-1" aria-labelledby="buyModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="buyModalLabel">매수주문 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><span>빌딩명:</span><span>${realEstateInfo.buildingName}</span></p>
                    <p><span>가격:</span><span id="buyModalPrice">원</span></p>
                    <p><span>수량:</span> <span id="buyModalQuantity">STOS</span></p>
                    <p><span>주문금액:</span><span id="buyModalTotal">원</span></p>
                    <p><span>거래 수수료 (0.015%):</span> <span id="buyModalFee">원</span></p>
                    <p><span>정산금액:</span><span id="buyModalNet">원</span></p>
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <button type="button" class="btn btn-danger" id="confirmBuy">매수하기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 매도 모달 -->
    <div class="modal fade" id="sellModal" tabindex="-1" aria-labelledby="sellModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="sellModalLabel">매도주문 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><span>빌딩명:</span><span>롯데타워시그니엘 1층 1호</span></p>
                    <p><span>가격:</span><span id="sellModalPrice">5,500원</span></p>
                    <p>수량: <span id="sellModalQuantity">10 STOS</span></p>
                    <p>주문금액: <span id="sellModalTotal">55,000원</span></p>
                    <p>거래 수수료 (0.015%): <span id="sellModalFee">원</span></p>
                    <p>정산금액: <span id="sellModalNet">원</span></p>
                </div>
                <div class="modal-footer" style="justify-content: center;">
                    <button type="button" class="btn btn-primary" id="confirmSell">매도하기</button>
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
    let walletBalance = ${wallet.balance} !== null ? ${wallet.balance} : "";
    let stosAmount = ${stos.amount} !== null ? ${stos.amount} : "";

    let stompClient;
    let LN = ${realEstateInfo.listingNumber};
    function connect() {
        let socket = new SockJS("/gs-guide-websocket"); // 웹소켓 엔드포인트 설정
        stompClient = Stomp.over(socket);

        stompClient.connect({},
            function(frame) { // Connection success callback
                stompClient.subscribe("/topic/orderBook/" + LN, function(message) {
                    try {
                        // console.log("Received message:", message.body);
                        updateOrderBookTable(JSON.parse(message.body));
                    } catch (error) {
                        console.error("Error processing the message:", error);
                    }
                });
                // Send an initial message to the server
                stompClient.send("/app/orderBook/" + LN);
            },
            function(error) { // Error callback
                console.error('STOMP error:', error);
            }
        );
    }

    function updateOrderBookTable(data) {
        let tbody = document.querySelector('.orderbook-table tbody');
        tbody.innerHTML = ''; // 기존 내용 삭제

        // 매도 호가 데이터 추가
        data.sellOrderBooks.forEach(order => {
            let tr = document.createElement('tr');
            tr.classList.add('sell');

            let tdSell = document.createElement('td');
            tdSell.classList.add('sell-quantity');
            let div = document.createElement('div');
            div.style.width = order.amount + '%'; // 비율
            div.innerText = order.amount;
            tdSell.appendChild(div);

            let tdPrice = document.createElement('td');
            tdPrice.classList.add('price-th');
            let span = document.createElement('span');
            span.classList.add('price-stockUp'); // 가격에 따라 클래스 조절 가능
            span.innerText = order.price;
            tdPrice.appendChild(span);

            tr.appendChild(tdSell);
            tr.appendChild(tdPrice);
            tr.appendChild(document.createElement('td')); // 매수 잔량 빈 칸

            tbody.appendChild(tr); // tbody 에 해당 값 추가
        });

        // 매수 호가 데이터 추가
        data.buyOrderBooks.forEach(order => {
            let tr = document.createElement('tr');
            tr.classList.add('buy');

            let tdBuy = document.createElement('td');
            tdBuy.classList.add('buy-quantity');
            let div = document.createElement('div');
            div.style.width = order.amount + '%';
            div.innerText = order.amount;
            tdBuy.appendChild(div);

            let tdPrice = document.createElement('td');
            tdPrice.classList.add('price-th');
            let span = document.createElement('span');
            span.classList.add('price-stockUp'); // 가격에 따라 클래스 조절 가능
            span.innerText = order.price;
            tdPrice.appendChild(span);

            tr.appendChild(document.createElement('td')); // 매도 잔량 빈 칸
            tr.appendChild(tdPrice);
            tr.appendChild(tdBuy);

            tbody.appendChild(tr); // 매수는 아래쪽에 추가
        });
    }

</script>
<script>
    window.onload = function () {
        connect();

        /**
         *  구매 - 판매 토글 버튼 관련 로직
         */
        const buyButton = document.querySelector('.btn-group .btn:nth-child(1)');
        const sellButton = document.querySelector('.btn-group .btn:nth-child(2)');
        const priceLabel = document.querySelector('.price span');
        const quantityLabel = document.querySelector('.quantity span');
        const submitButton = document.querySelector('.buy-sell input');
        const ableAmountName = document.getElementById("ableAmountName");
        const ableAmountValue = document.getElementById("ableAmountValue");

        buyButton.addEventListener('click', function () {
            activateButton(buyButton, sellButton);
            setTradingMode('구매');
            submitButton.style.backgroundColor = '#E90061';
        });

        sellButton.addEventListener('click', function () {
            activateButton(sellButton, buyButton);
            setTradingMode('판매');
            submitButton.style.backgroundColor = '#0074D9';
        });

        function activateButton(activeBtn, inactiveBtn) {
            activeBtn.classList.add('active');
            inactiveBtn.classList.remove('active');

            if (activeBtn === sellButton) {
                activeBtn.classList.add('sell-active');
            } else {
                sellButton.classList.remove('sell-active');
            }
        }

        function setTradingMode(mode) {
            priceLabel.textContent = mode + ' 희망 단가';
            quantityLabel.textContent = mode + ' 희망 수량';
            if (mode === '구매') {
                ableAmountName.innerText = "거래 가능 금액: ";
                ableAmountValue.innerText = walletBalance;
                submitButton.value = '매수';
            } else {
                ableAmountName.innerText = "매도 가능 수량: ";
                ableAmountValue.innerText = stosAmount;
                submitButton.value = '매도';
            }
        }

        /**
         *  가격 및 수량 조절 관련 로직
         */
        const priceInput = document.querySelector('.price input');
        const quantityInput = document.querySelector('.quantity input');
        const totalAmountSpan = document.querySelector('.total-amount span');

        document.querySelector('.price .decrease').addEventListener('click', function () {
            adjustValue(priceInput, -100);
        });

        document.querySelector('.price .increase').addEventListener('click', function () {
            adjustValue(priceInput, 100);
        });

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
            const price = parseInt(priceInput.value) || 0;
            const quantity = parseInt(quantityInput.value) || 0;
            const totalAmount = price * quantity;
            totalAmountSpan.textContent = totalAmount.toLocaleString('ko-KR') + ' 원';
        }

        priceInput.addEventListener('input', updateTotalAmount);
        quantityInput.addEventListener('input', updateTotalAmount);

        /**
         *  매수 - 매도 비동기 모달 처리
         */
        const buyModalPrice = document.getElementById('buyModalPrice');
        const buyModalQuantity = document.getElementById('buyModalQuantity');
        const buyModalTotal = document.getElementById('buyModalTotal');
        const buyModalFee = document.getElementById('buyModalFee');
        const buyModalNet = document.getElementById('buyModalNet');

        const sellModalPrice = document.getElementById('sellModalPrice');
        const sellModalQuantity = document.getElementById('sellModalQuantity');
        const sellModalTotal = document.getElementById('sellModalTotal');
        const sellModalFee = document.getElementById('sellModalFee');
        const sellModalNet = document.getElementById('sellModalNet');


        submitButton.addEventListener('click', function () {
            const price = parseInt(priceInput.value) || 0;
            const quantity = parseInt(quantityInput.value) || 0;
            const total = price * quantity;
            const fee = total * 0.015 / 100;

            if (submitButton.value === "매수") {
                const net = Math.ceil(total + fee);  // 소수점 올림 처리
                buyModalPrice.textContent = price.toLocaleString('ko-KR') + ' 원';
                buyModalQuantity.textContent = quantity + ' STOS';
                buyModalTotal.textContent = total.toLocaleString('ko-KR') + ' 원';
                buyModalFee.textContent = fee.toLocaleString('ko-KR') + ' 원';
                buyModalNet.textContent = net.toLocaleString('ko-KR') + ' 원';

                new bootstrap.Modal(document.getElementById('buyModal')).show();
            } else if (submitButton.value === "매도") {
                const net = Math.ceil(total - fee);  // 소수점 올림 처리
                sellModalPrice.textContent = price.toLocaleString('ko-KR') + ' 원';
                sellModalQuantity.textContent = quantity + ' STOS';
                sellModalTotal.textContent = total.toLocaleString('ko-KR') + ' 원';
                sellModalFee.textContent = fee.toLocaleString('ko-KR') + ' 원';
                sellModalNet.textContent = net.toLocaleString('ko-KR') + ' 원';

                new bootstrap.Modal(document.getElementById('sellModal')).show();
            }
        });

        // 매수 및 매도 확인 버튼 클릭 시 AJAX 요청
        document.getElementById('confirmBuy').addEventListener('click', function () {
            handleOrder('BUY', this);
        });

        document.getElementById('confirmSell').addEventListener('click', function () {
            handleOrder('SELL', this);
        });

        function handleOrder(orderType, btnElement) {
            // Spinner 추가 및 버튼 텍스트 숨김
            btnElement.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';
            btnElement.disabled = true;  // 버튼을 비활성화

            sendOrder(orderType, priceInput.value, quantityInput.value, btnElement);
        }

        function sendOrder(orderType, price, quantity, btnElement) {
            var password = document.getElementById("wallet-password").value;

            $.ajax({
                url: '/order',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    stoOrdersVO: {
                        // StoOrdersVO 객체의 필드들을 여기에 포함해야 합니다.
                        listingNumber: LN,
                        orderType: orderType,
                        amount: price,
                        quantity: quantity
                    },
                    walletPassword: password
                }),
                success: function () {
                    new bootstrap.Modal(document.getElementById('successModal')).show();

                    // 원래 버튼 상태로 복원
                    if (orderType === "BUY") {
                        btnElement.innerHTML = '매수하기';
                    } else {
                        btnElement.innerHTML = '매도하기';
                    }

                    btnElement.disabled = false;  // 버튼을 활성화
                },
                error: function () {
                    new bootstrap.Modal(document.getElementById('errorModal')).show();

                    // 원래 버튼 상태로 복원
                    if (orderType === "BUY") {
                        btnElement.innerHTML = '매수하기';
                    } else {
                        btnElement.innerHTML = '매도하기';
                    }

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

</body>

</html>