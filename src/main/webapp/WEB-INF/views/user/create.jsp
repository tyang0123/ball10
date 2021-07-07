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
        .popover{
            border: 1px black solid;
        }
        .bs-popover-end > .popover-arrow::before {
            border-right-color: black;
        }
        .bs-popover-top > .popover-arrow::before {
            border-top-color: black;
        }
    </style>
</head>


<body id="margin" style="background-color: #efefef;">
<div class="wrapper">

    <div class="row">
        <div class="createForm">
            <h1 style="margin-top: 40px;margin-bottom: 40px;">회 원 가 입</h1>
            <form action="/user/create" role="form" method="post">
            <div class="form-group">
                <input type="text" id="user_id" maxlength='20' minlength="4" class="form-control form-custom" aria-describedby="idHelpInline" name="user_id" placeholder="아이디" rel="popover" value="${writing.user_id}"/>
            </div>
                <p id="idHelpInline" class="form-text text-danger" style="text-align: left;margin-left: 50px;">
                    &nbsp;
                </p>
            <div class="form-group">
                <input type="password" id="inputPassword1" maxlength='20' minlength="4" class="form-control form-custom" aria-describedby="passwordHelpInline1" placeholder="비밀번호"/>
            </div>
                <p id="passwordHelpInline1" class="form-text text-danger" style="text-align: left;margin-left: 50px;">
                    &nbsp;
                </p>
            <div class="form-group">
                <input type="password" id="inputPassword2" maxlength='20' class="form-control form-custom" aria-describedby="passwordHelpInline2" name="user_password" placeholder="비밀번호 재확인"/>
            </div>
                <p id="passwordHelpInline2" class="form-text text-danger" style="text-align: left;margin-left: 50px;">
                    &nbsp;
                </p>
            <div class="form-group">
                <input type="text" class="form-control form-custom" maxlength='20' name="user_nickname" id="user_nickname" placeholder="닉네임" value="${writing.user_nickname}"/>
            </div>
            <p>&nbsp;</p>
            <div class="form-group">
                <input type="email" id="user_email" maxlength='45' class="form-control form-custom" aria-describedby="emailHelpInline" name="user_email" placeholder="이메일" value="${writing.user_email}"/>
            </div>
                <p id="emailHelpInline" class="form-text text-danger" style="text-align: left;margin-left: 50px;">&nbsp;</p>
            <div style="margin-top: 30px;margin-bottom: 35px;">
                <button type="submit" id="submit" class="btn button-create-customY">가 입 하 기</button>
                <button type="button" class="btn button-create-customO" onclick="location.href='login'">취 소</button>
            </div>
            </form>
        </div>
    </div>


</div>
<!-- /#wrapper -->


<script>
    $(document).ready(function() {
        //input popover처리
        $('#user_id').popover({content:"4~20자 사이의 영문자,숫자 입력 👩‍💻",placement:'right',trigger:'focus'});
        $('#inputPassword1').popover({content:"4~20자 사이의 영문자,숫자 입력 🤫",placement:'right',trigger:'focus'});
        $('#inputPassword2').popover({content:"비밀번호 재입력 🙋",placement:'right',trigger:'focus'});
        $('#user_nickname').popover({content:"홈페이지내에서 사용될 닉네임 😋",placement:'right',trigger:'focus'});
        $('#user_email').popover({content:"실제 사용중인 이메일 입력 📧",placement:'right',trigger:'focus'});

        //아이디,비밀번호 체크할 정규식 표현
        let re = /^[a-zA-z0-9]{4,20}$/;

        $('#user_id').keyup(function (){
            $('#user_id').val($('#user_id').val().replace(/\s/gi, ""));
            if(!re.test($('#user_id').val())) {
                $('#idHelpInline').text("유효하지 않은 형식입니다.");
            }
            else{
                $('#idHelpInline').html("&nbsp;");
            }
        });

        $('#inputPassword1').keyup(function (){
            $('#inputPassword1').val($('#inputPassword1').val().replace(/\s/gi, ""));
            if(!re.test($('#inputPassword1').val())) {
                $('#passwordHelpInline1').text("유효하지 않은 형식입니다.");
            }
            else{
                $('#passwordHelpInline1').html("&nbsp;");
            }
        });

        $('#user_email').keyup(function (){
            $('#emailHelpInline').html("&nbsp;");
        });


        //비밀번호 일치 확인 함수 실행
        $('#inputPassword2').keyup(function (){
            pwCheck();
        });

        //비밀번호 일치 확인 함수
        const pwCheck = ()=> {
            if($('#inputPassword2').val() != $('#inputPassword1').val()) {
                $('#passwordHelpInline2').text("비밀번호가 일치하지 않습니다.");
            }
            else{
                $('#passwordHelpInline2').html("&nbsp;");
            }
        }

        //오류,null값 체크 후 컨트롤러 전송
        $('#submit').click(function (){
            pwCheck();
            if($('#user_id').val().length==0 || $('#idHelpInline').text().length!=1) {$('#user_id').focus(); return false;}
            if($('#inputPassword1').val().length==0 || $('#passwordHelpInline1').text().length!=1) {$('#inputPassword1').focus(); return false;}
            if($('#inputPassword2').val().length==0 || $('#passwordHelpInline2').text().length!=1) {$('#inputPassword2').focus(); return false;}
            if($('#user_nickname').val().length==0) {$('#user_nickname').focus(); return false;}
            if($('#user_email').val().length==0 || $('#emailHelpInline').text().length!=1) {$('#user_email').focus(); return false;}
        });

        //중복 아이디 오류 문구
        let idCheck = "${idFail}";
        if(idCheck === "fail"){
            $('#idHelpInline').text("이미 사용중인 아이디입니다.");
        }

        //중복 이메일 오류 문구
        let emailCheck = "${emailFail}";
        if(emailCheck === "fail"){
            $('#emailHelpInline').text("이미 사용중인 이메일입니다.");
        }
    });
</script>
</body>
</html>


