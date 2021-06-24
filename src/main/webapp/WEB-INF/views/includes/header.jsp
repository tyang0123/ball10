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
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- 부트스트랩 테마스타일 파일 연결 -->
    <link href="/resources/css/bootstrap-theme.min.css" rel="stylesheet">

    <!--Custom CSS-->
    <link href="/resources/css/custom.css" rel="stylesheet">

    <nav class="navbar navbar-custom navbar-fixed-top">
        <div class="container">
            <div class="navbar-header" style="margin-bottom:9px;">
                <!-- 사이즈 축소시 햄버거가 속할 태그 내부에 아래 코드 생성 -->
                <!-- data-target을 'collapse navbar-collapse' 클래스의 id로 맞춰야 -->
                <!-- 숨긴 데이터들이 햄버거 안으로 들어가게 된다 -->
                <button type="button" class="navbar-toggle collapsed navbar-toggle-custom"
                        data-toggle="collapse" data-target="#bs-nav-demo" aria-expanded="false">
                    <!-- 햄버거 내부에 들어갈 줄들 -->
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
                    <img src="/resources/logo/pc_logo.jpg" alt="" id="custom-img">
                </a>
            </div>
            <div class="collapse navbar-collapse" id="bs-nav-demo">
                <ul class="nav navbar-nav navbar-nav-custom">
                    <li><a href="page.html">열공 하기</a></li>
                    <li><a href="#">스터디 그룹 찾기</a></li>
                </ul>

                <ul class="nav navbar-nav navbar-right navbar-nav-custom">
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">정보수정</a></li>
                    <li><a href="#">공지사항</a></li>
                </ul>
            </div> <!-- collapse navbar-collapse (햄버거 감싸는 div 태그) -->
        </div> <!-- container -->
    </nav>
</head>
<body id="margin">
<div class="wrapper">


