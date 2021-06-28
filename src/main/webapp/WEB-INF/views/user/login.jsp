<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../includes/header.jsp" %>




<div class="container">
    <div class="row">
        <div class="col-sm-12">
            <h1>LOGIN</h1>

            <form method="post" action="/user/login">
                <div class="form-group m-3">
                    <input type="text" class="form-control" id="user-id" name="user_id" placeholder="아이디">
                    <div id="id-help" class="form-text" style="display: none;">영문자+숫자, 40글자</div>
                </div>
                <div class="form-group m-3">
                    <input type="password" class="form-control" id="user-password" name="user_password" placeholder="비밀번호">
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="user-check" value="true" checked="checked" name="user_remember">
                    <label class="form-check-label" for="user-check">
                        로그인 상태 유지하기
                    </label>
                </div>
                <input type="submit" class="btn btn-primary" style="margin-top: 1rem;" value="로그인">
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


<!-- Modal -->
<div class="modal fade" id="createSuccess">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" style="margin-left: 30px;">회원가입 완료</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                열공의 회원이 되신것을 환영합니다. 🙌 🥳
            </div>
            <div class="modal-footer" style="border-color:black;">
                <button style="width: 150px;" type="button" class="button-add-custom" data-bs-dismiss="modal">확 인</button>
            </div>
        </div>
    </div>
</div>


<style>
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

        var successCreate = "${successCreate}"
        if( successCreate == "success"){
            $("#createSuccess").modal("show");
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