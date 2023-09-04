<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/style/styles.css">
    <link rel="stylesheet" href="/resources/style/font.css">
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!-- animation cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <!-- fabicon -->
    <link rel="icon" href="/resources/img/favicon.png">
    <title>하나1PIECE</title>
    <!-- ajax -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>

<jsp:include page="./include/header.jsp"></jsp:include>

<div class="titleBar">
    <h2>공지사항</h2>
    <hr>
</div>

<div class="announcement">
    <div class="container mt-5">
        <table class="table table-bordered table-hover">
            <thead class="thead-light">
            <tr>
                <th style="background-color: #008485; color: white; text-align: center;">번호</th>
                <th style="background-color: #008485; color: white; text-align: center;">제목</th>
                <th style="background-color: #008485; color: white; text-align: center;">등록일</th>
                <th style="background-color: #008485; color: white; text-align: center;">조회수</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="announcement" items="${announcementList}">
                <tr>
                    <td>${announcement.id}</td>
                    <td>${announcement.title}</td>
                    <td>${announcement.writeDate}</td>
                    <td>${announcement.count}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <li class="page-item"><a class="page-link" href="?pageNo=${currentPage - 1}">Previous</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled"><span class="page-link">Previous</span></li>
                    </c:otherwise>
                </c:choose>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="page-item active"><span class="page-link">${i}</span></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="?pageNo=${i}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <li class="page-item"><a class="page-link" href="?pageNo=${currentPage + 1}">Next</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled"><span class="page-link">Next</span></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
</div>

<jsp:include page="include/footer.jsp"></jsp:include>

<script>
    /**
     *  공지사항 상세 페이지 이동
     */
    $(document).ready(function () {
        $(".table-hover tbody tr").click(function () {
            var recordId = $(this).find("td:first").text(); // 첫번째 열(공지사항 번호) 가져오기
            window.location.href = "announcement/" + recordId; // 해당 페이지로 이동
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