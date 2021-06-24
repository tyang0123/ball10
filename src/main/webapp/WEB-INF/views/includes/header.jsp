<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>10.0</title>

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="/resources/js/bootstrap.min.js"></script>

    <!--Custom CSS-->
    <link href="/resources/css/custom.css" rel="stylesheet">
    <script>
        $(document).click(function (event) {
            if (!$(event.target).closest('#navbarNavDropdown').length) {
                $('.navbar-collapse').collapse('hide');
            }
        });
    </script>


    <nav class="navbar navbar-expand-lg navbar-custom fixed-top" style="border-bottom: black solid 1px;">
        <div class="container" >

            <a class="navbar-brand" href="#"><img src="/resources/logo/pc_logo.jpg" alt="" id="custom-img"></a>
            <button type="button" class="navbar-toggle navbar-toggle-custom"
                    data-bs-toggle="collapse" aria-label="Toggle navigation" data-bs-target="#navbarNavDropdown" aria-expanded="false">
                <!-- 햄버거 내부에 들어갈 줄들 -->
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav navbar-collapse-custom">
                    <li class="nav-item" >
                        <a class="nav-link" href="page.html">열공 하기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">스터디 그룹 찾기</a>
                    </li>

                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">로그아웃</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">회원정보수정</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">공지사항</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

</head>
<body id="margin">
<div class="wrapper"/>