<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../includes/header.jsp" %>



<div class="row" style="background-color: #efefef;">
    <div class="createForm" style="margin-top: 40px;margin-bottom: 40px;">
        <h1 style="margin-top: 40px;margin-bottom: 40px;">회 원 정 보&nbsp;&nbsp;수 정</h1>
        <form action="/user/modify" role="form" method="post">
            <div class="form-group">
                <input type="text" id="user_id" class="form-control form-custom" aria-describedby="idHelpInline" name="user_id" rel="popover" value="${userInfo.user_id}" style="color:#6e757c;" readonly/>
            </div>
            <p id="idHelpInline" class="form-text text-danger" style="text-align: left;margin-left: 50px;">
                &nbsp;
            </p>
            <div class="form-group">
                <input type="password" id="inputPassword1" maxlength='20' minlength="4" class="form-control form-custom" aria-describedby="passwordHelpInline1" placeholder="비밀번호" value="${userInfo.user_password}"/>
            </div>
            <p id="passwordHelpInline1" class="form-text text-danger" style="text-align: left;margin-left: 50px;">&nbsp;</p>
            <div class="form-group">
                <input type="password" id="inputPassword2" maxlength='20' class="form-control form-custom" aria-describedby="passwordHelpInline2" name="user_password" placeholder="비밀번호 재확인" value="${userInfo.user_password}"/>
            </div>
            <p id="passwordHelpInline2" class="form-text text-danger" style="text-align: left;margin-left: 50px;">&nbsp;</p>
            <div class="form-group">
                <input type="text" class="form-control form-custom" maxlength='20' name="user_nickname" id="user_nickname" placeholder="닉네임" value="${userInfo.user_nickname}"/>
            </div>
            <p>&nbsp;</p>
            <div class="form-group">
                <input type="email" id="user_email" maxlength='45' class="form-control form-custom" aria-describedby="emailHelpInline" name="user_email" placeholder="이메일" value="${userInfo.user_email}"/>
            </div>
            <p id="emailHelpInline" class="form-text text-danger" style="text-align: left;margin-left: 50px;">&nbsp;</p>
            <div style="margin-top: 30px;margin-bottom: 35px;">
                <button type="submit" id="submit" class="btn button-create-customY">수 정 하 기</button>
                <button type="button" class="btn button-create-customO" onclick="location.href='user'">취 소</button>
            </div>
        </form>
    </div>

</div>

<script>
    $(document).ready(function() {
        //input popover처리
        $('#inputPassword1').popover({content:"4~20자 사이의 영문자,숫자 입력 🤫",placement:'right',trigger:'focus'});
        $('#inputPassword2').popover({content:"비밀번호 재입력 🙋",placement:'right',trigger:'focus'});
        $('#user_nickname').popover({content:"홈페이지내에서 사용될 닉네임 😋",placement:'right',trigger:'focus'});
        $('#user_email').popover({content:"실제 사용중인 이메일 입력 📧",placement:'right',trigger:'focus'});

        //비밀번호 체크할 정규식 표현
        var re = /^[a-zA-z0-9]{4,20}$/;

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
            if($('#inputPassword1').val().length==0 || $('#passwordHelpInline1').text().length!=1) {$('#inputPassword1').focus(); return false;}
            if($('#inputPassword2').val().length==0 || $('#passwordHelpInline2').text().length!=1) {$('#inputPassword2').focus(); return false;}
            if($('#user_nickname').val().length==0) {$('#user_nickname').focus(); return false;}
            if($('#user_email').val().length==0 || $('#emailHelpInline').text().length!=1) {$('#user_email').focus(); return false;}
        });

        //중복 이메일 오류 문구
        var emailCheck = "${emailFail}";
        if(emailCheck === "fail"){
            $('#emailHelpInline').text("이미 사용중인 이메일입니다.");
        }

    })
</script>



<%@ include file="../includes/footer.jsp" %>