<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

    <style>
        body {
            height: 100%;
            background-color: #efefef;
        }
        form {
            margin: 0 auto;
        }
        /* content 수직 정렬 과련 css*/
        .wrapper {
            display: table;
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
        }
        .container{
            display: table-cell;
            vertical-align: middle;
        }
        .content{
            margin-left: auto;
            margin-right: auto;
        }
        /* end  content 수직 정렬 과련 css */

        .form-control{
            border: 2px solid black;
        }

        /* bootstrap form focus shadow 기능 reset */
        .form-control:focus,
        .form-check-input:focus {
            border-color: #ff9000;
            box-shadow: unset;
        }

        .form-check-input:checked {
            outline: #333333;
            border-color: #FF8800;
            background-color: #FF8800;
        }
        .div-line{
            border-bottom: 1px solid #313131;
        }
        @media (min-width: 520px) {
            form, .div-btn-container, .div-line{
                margin: 0 auto;
                width:500px;
            }
        }

        #result-login {
            display:block;
            height:8px;
            margin-left: 10px;
        }

        .btn-loginpage-custom {
            display: inline-block;
            font-weight: 400;
            line-height: 1.5;
            color: #000000;
            text-align: center;
            text-decoration: none;
            vertical-align: middle;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            border: 2px solid black;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.2rem;
            margin-top:1rem;
            margin-bottom:1rem;
            width:94%;
        }
        .button-login{
            background-color: #ffc107;
        }
        .button-join {
            background-color: #ff9000;
        }
        .button-login:hover {
            background-color: #ff9000;
            border-color: black;
            color: black;
        }
        .button-join:hover {
            background-color: #ffc107;
            border-color: black;
            color: black;
        }
        span{
            font-size: 1rem;
            color : black;
        }
        /* a tag reset */
        a {color: #fff; text-decoration: none; outline: none}
        a:hover, a:active {text-decoration: none; color:#fff;}
    </style>

    <script>
        $(document).ready(function(){

            var errorMessage = "${errorMessage}";
            if(errorMessage === "fail"){
                console.log(errorMessage)
                $("#result-login").html("가입하지 않는 아이디이거나, 잘못된 비밀번호 입니다.");
            }

            var successLogin = "${successLogin}";
            if( successLogin == "success"){
                var formObj = $("form");
                formObj.find("input").remove();
                formObj.attr("method", "GET")
                formObj.attr("action", "/user/user");
                formObj.submit();
            }

            $("form div input").on('input', function(e){
                var regex = new RegExp("^[A-Za-z0-9]+$"); // alphabet and number
                if(!regex.test(e.target.value)){
                    console.log("tick");
                    var str = e.target.value;
                    e.target.value= str.substring(0, str.length-1);
                }
            })

            $("#user-check").click(function(e){
                $(this).val($(this).is(':checked'));
            })

        })//end document.ready
    </script>
</head>

<body>
    <div class="wrapper"/>
        <div class="container">
            <div class="content">
                <div>
                    <figure class="text-center"><h1>로그인</h1></figure>

                    <form method="post" action="/user/login">
                        <div class="form-group m-3">
                            <input type="text" class="form-control" id="user-id" name="user_id" placeholder="아이디">
                        </div>
                        <div class="form-group m-3">
                            <input type="password" class="form-control" id="user-password" name="user_password" placeholder="비밀번호">
                            <small id="result-login" class="form-text text-danger"></small>
                        </div>
                        <div class="form-check text-center">
                            <label class="form-check-label" for="user-check">
                                <input type="checkbox" class="form-check-input" id="user-check" value="true" checked="checked" name="user_remember">
                                로그인 상태 유지하기
                            </label>
                        </div>
                        <div class="form-group text-center">
                            <button type="submit" class="btn-loginpage-custom button-login" style=" ">로그인</button>

                            <div class="div-line" ></div>
                        </div>
                    </form>
                </div> <!-- end form div col-sm-12 -->
                <!-- start 회원찾기 및 비번 찾기 -->
                <div class="div-btn-container" style="text-align: center;">
                    <button style="margin:1rem 2px" type="button" class="btn-loginpage-custom button-join">회원가입</button>
                </div>
                <div class="div-btn-container" style="text-align: center; margin-top:1rem;">
                    <a href="/user/findID"><span>아이디 찾기</span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="/user/findPassword"><span>비번 찾기</span></a>
                </div>
                <!-- end 회원찾기 및 비번 찾기-->
            </div>
        </div><!--end div container -->
    </div>
<!-- /#wrapper -->
</body>
</html>