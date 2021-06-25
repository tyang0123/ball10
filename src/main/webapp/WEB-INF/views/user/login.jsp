<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../includes/header.jsp" %>




<div class="container">
    <div class="row">
        <div>
            <figure class="text-center"><h1>로그인</h1></figure>

            <form method="post" action="/user/login">
                <div class="form-group m-3">
                    <input type="text" class="form-control border border-dark border-2" id="user-id" name="user_id" placeholder="아이디">
                </div>
                <div class="form-group m-3">
                    <input type="password" class="form-control border border-dark border-2" id="user-password" name="user_password" placeholder="비밀번호">
                    <small id="result-login" class="form-text text-danger">asdf</small>
                </div>
                <div class="form-check text-center">
                    <input class="form-check-input" type="checkbox" id="user-check" value="true" checked="checked" name="user_remember">
                    <label class="form-check-label" for="user-check">
                        로그인 상태 유지하기
                    </label>
                </div>
                <div class="form-group text-center">
                    <button type="submit" class="button-timer-custom" style="width: 150px;margin-top: 1rem;">로그인</button>
                </div>
            </form>
        </div> <!-- end form div col-sm-12 -->
    </div>

    <!-- start 회원찾기 및 비번 찾기 -->
    <div class="row">
        <div style="text-align: center;">
            <button style="width: 150px;" type="button" class="button-timer-custom">회원가입</button>
        </div>
    </div>
    <div class="row">
        <div style="text-align: center;">
            <a href="/user/findID">
                <button style="width: 100px;" type="button" class="button-timer-custom">아이디 찾기</button>
            </a>
            <a href="/user/findPassword">
                <button style="width: 100px;" type="button" class="button-timer-custom">비번 찾기</button>
            </a>
        </div>
    </div>
    <!-- end 회원찾기 및 비번 찾기-->
</div><!--end div container -->

<style>
    body {
        height: 100%;
        background-color: #efefef;
    }
    form {
        margin: 0 auto;
    }
    @media (min-width: 768px) {
        form {
            margin: 0 auto;
            width:700px;
        }
    }

    #result-login {
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

        var errorMessage = "${errorMessage}";
        if(errorMessage === "fail"){
            console.log(errorMessage)
            alert("로그인이 실패했습니다.")
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





<%@ include file="../includes/footer.jsp" %>