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
    <!-- 파비콘 -->
    <link rel=" shortcut icon" href="/resources/logo/icon.png">
    <link rel="icon" href="/resources/logo/icon.png">

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
            border: black 2px solid;
            border-radius: 0.3rem;
            background-color: #ffffff;
            margin-right: auto;
            margin-left: auto;
            width: 82vw;
        }
        /* end  content 수직 정렬 과련 css */

        .form-control{
            border: 2px solid black;
        }

        /* bootstrap form focus shadow 기능 reset */
        .form-control:focus{
            border-color: #ff9000;
            box-shadow: unset;
        }
        .h1-custom{
            margin-top: 6vw;
            margin-bottom: 6vw;
        }

        .btn-email-custom {
            display: inline-block;
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
            margin-top:2vw;
            margin-bottom:2rem;
            width:50vw;
        }
        .button-email{
            background-color: #ffc107;
        }
        .button-email:hover {
            background-color: #ff9000;
            border-color: black;
            color: black;
        }
        @media (min-width: 520px) {
            .content{
                margin: 0 auto;
                width: 500px;
            }
            form{
                margin: 0 auto;
                width: 80%;
            }
            .h1-custom{
                margin-top: 40px;
                margin-bottom: 30px;
            }
            .btn-email-custom {
                margin-top:1rem;
                width:55%;
            }
        }

        #email-result {
            display:block;
            height:8px;
            margin-left: 10px;
        }



        /* a tag reset */
        a {color: #fff; text-decoration: none; outline: none}
        a:hover, a:active {text-decoration: none; color:#fff;}
    </style>

    <script>
        $(document).ready(function(){
            let sendID = "${sendID}";
            if(sendID!=''){
                //alert(sendID);
                $("#password-result").html(sendID);
            }

            let send = false;
            $("form").submit(function (e) {
                if(send){ // 한번이상 클릭시 중복 메일 보내기 방지
                    e.preventDefault();
                    console.log("click")
                }
                send = true;
            });
        })//end document.ready
    </script>
</head>

<body>
    <div class="wrapper">
        <div class="container">
            <div class="content">
                <div>
                    <figure class="text-center"><h1 class="h1-custom">비번&nbsp;&nbsp;찾기</h1></figure>

                    <form method="post" action="/user/findPassword">
                        <div class="form-group m-3">
                            <input type="text" class="form-control" id="user-id" name="user_id" placeholder="아이디">
                        </div>
                        <div class="form-group m-3">
                            <input type="text" class="form-control" id="user-email" name="user_email" placeholder="이메일@example.com">
                            <small id="password-result" class="form-text text-danger"></small>
                        </div>
                        <div class="form-group text-center">
                            <button type="submit" class="btn-email-custom button-email">이메일로 Password보내기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div><!--end div container -->
    </div><!-- /#wrapper -->
</body>
</html>