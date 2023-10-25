<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/transaction-scan.css">
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
    <h2>주문/체결 트랜잭션 스캔</h2>
    <hr>
</div>

<div class="container">
    <div class="scan-div">
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
                        <th style="background-color: #008485; color: white;">#주문번호</th>
                        <th style="background-color: #008485; color: white;">매물번호</th>
                        <th style="background-color: #008485; color: white;">지갑번호</th>
                        <th style="background-color: #008485; color: white;">유형</th>
                        <th style="background-color: #008485; color: white;">주문금액</th>
                        <th style="background-color: #008485; color: white;">주문수량</th>
                        <th style="background-color: #008485; color: white;">상태</th>
                        <th style="background-color: #008485; color: white;">주문일시</th>
                        <th style="background-color: #008485; color: white;">체결수량</th>
                        <th style="background-color: #008485; color: white;">체결평균가</th>
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

        <div class="container">
            <div class="mypage-title">
                <h2 id="execution-transaction-scan">체결 트랜잭션 스캔</h2>
            </div>
        </div>

        <div class="announcement">
            <div class="container mt-3">
                <table id="executions" class="table table-bordered table-hover">
                    <thead>
                    <tr class="table-light text-center">
                        <th style="background-color: #008485; color: white;">#체결번호</th>
                        <th style="background-color: #008485; color: white;">매수주문번호</th>
                        <th style="background-color: #008485; color: white;">매도주문번호</th>
                        <th style="background-color: #008485; color: white;">체결가</th>
                        <th style="background-color: #008485; color: white;">체결수량</th>
                        <th style="background-color: #008485; color: white;">체결일시</th>
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
    </div>
</div>




<%@ include file="include/footer.jsp" %>

<script>
    let ordersCurrentPage = 1;
    let ordersTotalPage = 1;
    let executionsCurrentPage = 1;
    let executionsTotalPage = 1;

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

    function loadOrders(pageNum) {
        $.ajax({
            url: "/manager/orders?page=" + pageNum,
            type: "GET",
            dataType: "json",
            success: function (response) {
                updateOrderTable(response.orders);

                // 페이지네이션 텍스트 업데이트
                ordersCurrentPage = response.currentPage;
                ordersTotalPage = response.totalPages;
                $('#ordersPaginationControls .page-item.disabled .page-link').text("Page " + ordersCurrentPage + " of " + ordersTotalPage);
            },
            error: function (xhr, status, error) {
                console.error("Failed to fetch orders:", error);
            }
        });
    }

    function loadExecutions(pageNum) {
        $.ajax({
            url: "/manager/executions?page=" + pageNum,
            type: "GET",
            dataType: "json",
            success: function (response) {
                updateExecutionTable(response.executions);

                // 페이지네이션 텍스트 업데이트
                executionsCurrentPage = response.currentPage;
                executionsTotalPage = response.totalPages;
                $('#executionsPaginationControls .page-item.disabled .page-link').text("Page " + executionsCurrentPage + " of " + executionsTotalPage);
            },
            error: function (xhr, status, error) {
                console.error("Failed to fetch orders:", error);
            }
        });
    }

    function updateOrderTable(orders) {
        let tbody = $("#orders tbody");
        tbody.empty();

        $.each(orders, function (index, order) {
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

        $.each(executions, function (index, execution) {
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

    function updateOrderTable(orders) {
        let tbody = $("#orders tbody");
        tbody.empty();

        $.each(orders, function (index, order) {
            let statusText = "";
            switch(order.status) {
                case "N":
                    statusText = "미체결";
                    break;
                case "P":
                    statusText = "부분 체결";
                    break;
                case "C":
                    statusText = "체결";
                    break;
                default:
                    statusText = "알 수 없음"; // 예상치 못한 상태 값에 대한 처리
            }
            let row = "<tr>" +
                "<td>" + order.orderId + "</td>" +
                "<td>" + order.listingNumber + "</td>" +
                "<td>" + order.walletNumber + "</td>" +
                "<td>" + order.orderType + "</td>" +
                "<td class='formatted-number'>" + order.amount + "</td>" + // 금액 포맷팅을 위해 클래스 추가
                "<td>" + order.quantity + "</td>" +
                "<td>" + statusText + "</td>" + // 상태 문자열 사용
                "<td>" + order.orderDate + "</td>" +
                "<td>" + order.executedQuantity + "</td>" +
                "<td>" + order.executedPriceAvg + "</td>" +
                "</tr>";
            tbody.append(row);
        });
        formatNumbers(); // 테이블이 갱신된 후에 숫자 포맷팅 적용
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

        /**
         *  페이지 네이션 버튼 클릭 이벤트
         */
        $(document).on('click', '#ordersPaginationControls > li', function (e) {
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

        $(document).on('click', '#executionsPaginationControls > li', function (e) {
            e.preventDefault();

            let clickedPageLink = $(this).find('.page-link');
            let clickedPage = clickedPageLink.data('page');

            if (clickedPage === 'next') {
                executionsCurrentPage += 1;
                if (executionsCurrentPage > executionsTotalPage) {
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
    });


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