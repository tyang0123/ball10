<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    response.setHeader("Expires", "일자");
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>10.0</title>
    <!-- 파비콘 -->
    <link rel=" shortcut icon" href="/resources/logo/icon.png">
    <link rel="icon" href="/resources/logo/icon.png">

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>


    <!-- Custom styles for this template -->
    <link href="/resources/css/custom.css" rel="stylesheet">
    <link href="./resources/css/carousel.css" rel="stylesheet">
</head>
<body>


<main>

    <div id="myCarousel" class="carousel slide" data-bs-ride="carousel" style="z-index: 1">
<%--        <div class="carousel-indicators">--%>
<%--            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>--%>
<%--            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>--%>
<%--            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>--%>
<%--            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>--%>
<%--        </div>--%>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <!-- 여기에 이미지를 바꾸면 되요 -->
                <img src="/resources/img/mainPC.jpg" class="img-fluid mainPC" alt="" >
                <img src="/resources/img/mainM.jpg" class="img-fluid mainM" alt="" >
            </div>
<%--            <div class="carousel-item">--%>
<%--                <!-- svg대신에 이미지를 넣으면 되요 -->--%>
<%--                <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">--%>
<%--                    <rect width="100%" height="100%" fill="#333"/>--%>
<%--                </svg>--%>
<%--            </div>--%>
<%--            <div class="carousel-item">--%>
<%--                <!-- svg대신에 이미지를 넣으면 되요 -->--%>
<%--                <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">--%>
<%--                    <rect width="100%" height="100%" fill="#555"/>--%>
<%--                </svg>--%>

<%--            </div>--%>
<%--            <div class="carousel-item">--%>
<%--                <!-- svg대신에 이미지를 넣으면 되요 -->--%>
<%--                <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">--%>
<%--                    <rect width="100%" height="100%" fill="#777"/>--%>
<%--                </svg>--%>
<%--            </div>--%>
        </div>
<%--        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">--%>
<%--            <span class="carousel-control-prev-icon" aria-hidden="true"></span>--%>
<%--            <span class="visually-hidden">Previous</span>--%>
<%--        </button>--%>
<%--        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">--%>
<%--            <span class="carousel-control-next-icon" aria-hidden="true"></span>--%>
<%--            <span class="visually-hidden">Next</span>--%>
<%--        </button>--%>
    </div>


    <div class="container-custom marketing">

        <div class="row">
            <div class="userMarker" style="text-align: center;margin-top:2.5vw;"><span>열공에서 공부해야 하는 이유!😃</span></div>
        </div>
        <div class="row text-highlight-wrap alignText">
            <div class="col-lg-7 home1Text">
                <span class="subtitle">날마다 타이머를 이용해</span><br>
                <span class="title">공부시간 기록</span><br>
                <span class=" yellow underline maintext">눈으로 바로 확인할 수 있는 타이머로<br>
                    얼마나 공부했는지 확인하고 다짐을 할 수 있습니다!</span>
            </div>
            <div class="col-lg-5">
                <img src="/resources/img/home1.png" class="img-fluid home1" alt="" >

            </div>
        </div>

        <hr class="featurette-divider">

        <div class="row text-highlight-wrap alignText">
            <div class="col-lg-7 order-lg-2">
                <span class="subtitle">캘린더를 통해</span><br>
                <span class="title">스케쥴과 통계확인</span><br>
                <span class=" yellow underline maintext">일별스케쥴 기록과 todo리스트로<br>
                    간편하게 일정을 관리하고 차트기능으로 일주일간의<br>
                    공부시간 데이터를 한눈에 확인이 가능합니다!</span>
            </div>
            <div class="col-lg-5 order-lg-1">
                <img src="/resources/img/home2.png" class="img-fluid home2" alt="" >

            </div>
        </div>

        <hr class="featurette-divider">

        <div class="row text-highlight-wrap alignText">
            <div class="col-lg-7">
                <span class="subtitle">함께 성장하는</span><br>
                <span class="title">스터디 그룹기능</span><br>
                <span class=" yellow underline maintext">같은 목표를 가진 사람들과 서로 소통하고<br>
                    공부상태를 확인하면서 경쟁과 동시에 함께<br>
                    목표를 이루기 위해 힘이되고 자극 받을 수 있습니다!</span>
            </div>
            <div class="col-lg-5">
                <img src="/resources/img/home3.png" class="img-fluid home3" alt="" >

            </div>
        </div>

        <hr style="margin: 5rem 0 2rem 0;">

    </div><!-- /.container -->

    <!-- FOOTER -->
    <footer class="container-custom">
        <p style="text-align: center;"><a href="#" style="text-decoration:none;color: black">Back to top</a></p>
    </footer>
</main>

<!--  -->
<div class="btn-fixed-right-bottom" style="z-index: 2;">
    <a href="/user/user">
        <img src="./resources/img/mainBtn.png" style="position: absolute; right: 5px;bottom: 10px;" class="mainBtn"/>
        <button type="button" class="btn btn-custom">공부하러 가기!</button>
    </a>
</div>

</body>
</html>