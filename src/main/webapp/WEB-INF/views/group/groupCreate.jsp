<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../includes/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="/resources/css/group.css" rel="stylesheet">
<style>
    .form-check-input:checked {
        border-color: #ff9000;
        background-color: #ff9000;
    }
    .form-check-input:focus {
        box-shadow: unset;
    }
</style>
<div class="wrapper">
    <div class="row" style="background-color: #efefef;">
        <div class="createForm" style="margin-top: 8vh;margin-bottom: 12vh;">
            <h1 style="margin-top: 40px;margin-bottom: 40px;">그룹 생성</h1>
            <form id="formBtn" role="form" action="/group/create" method="post">
            <div class="form-group">
                <label for="group_name">
                    <input class="form-control form-custom" name="group_name" id="group_name" placeholder="그룹이름" value="${group.group_name}"> </label>
                </label>
            </div>
            <div class="form-group" hidden>
                <label for="user_id_group_header">방장
                    <input class="form-control" name="user_id_group_header" id="user_id_group_header" value="${user_id}" readonly="readonly">
                </label>
            </div>
            <div class="form-group"> <!-- select-group -->
                <select name="group_category" class="form-custom form-select form-select-custom" style="border: black 2px solid;"  required>
                    <option value="" selected>그룹 카테고리</option>
                    <option value="취업">취업</option>
                    <option value="토익">토익</option>
                    <option value="이직">이직</option>
                    <option value="자격증">자격증</option>
                </select>
            </div>
            <div class="form-check secret">
                <label for="group_is_secret">비밀방
                    <input type="checkbox" name="group_is_secret" id="group_is_secret" class="form-check-input" onclick="checkClick()" />
                </label>
            </div>
            <div class="form-group">
                <label for="group_password">
                    <input class="form-control form-custom" name="group_password" id="group_password" placeholder=" 비밀번호" value="${group.group_password}" readonly="readonly"/>
                </label>
            </div>
            <div class="form-group ">
                <select name="group_person_count" class="form-custom form-select form-select-custom" style="border: black 2px solid;"   required>
                    <option value="" selected>그룹 인원</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="15">15</option>
                    <option value="20">20</option>
                </select>
            </div>
            <div class="form-group">
                <label for="group_content"/>
                <textarea class="form-control form-custom" rows="3" name="group_content"
                          id="group_content" placeholder="그룹 공지">${group.group_content}</textarea>
            </div>
            <div class="form-check selectTime">
                <span>
                <label for="group_target_hour">목표시간</label>
                <select name="group_target_hour" id="group_target_hour">
                    <option value="1시간">1시간</option>
                    <option value="2시간">2시간</option>
                    <option value="3시간">3시간</option>
                    <option value="4시간">4시간</option>
                    <option value="5시간">5시간</option>
                    <option value="6시간">6시간</option>
                    <option value="7시간">7시간</option>
                    <option value="8시간">8시간</option>
                    <option value="9시간">9시간</option>
                    <option value="10시간">10시간</option>
                    <option value="11시간">11시간</option>
                    <option value="12시간">12시간</option>
                    <option value="13시간">13시간</option>
                    <option value="14시간">14시간</option>
                    <option value="15시간">15시간</option>
                </select>
                <select name="group_target_minute" id="group_target_minute">
                    <option value="00분">00분</option>
                    <option value="10분">10분</option>
                    <option value="20분">20분</option>
                    <option value="30분">30분</option>
                    <option value="40분">40분</option>
                    <option value="50분">50분</option>
                </select>
                </span>
            </div>
            <div style="margin-top: 30px;margin-bottom: 35px;">
                <button type="submit" class="btn button-create-customY">그룹 생성</button>
                <button type="button" class="btn button-create-customO" onclick="location.href='list'">취소 버튼</button>
            </div>
        </form>
        </div> <!-- end panel -->
    </div> <!-- col-lg-12 -->
</div> <!-- row -->

<%@ include file="../includes/footer.jsp" %>

<script>
    function checkClick(){
        var valueClick =0;
        if($("#group_is_secret").is(':checked')){
            valueClick=1;
            $("#group_is_secret").val(valueClick)
            console.log("여기가 들어오나",valueClick)
        }else{
            valueClick=0;
            $("#group_is_secret").val(valueClick)
            console.log("클릭 풀면 여기가 들어오나",valueClick)
        }
    }
    $(".createCancel").click(function (){
        $("#formBtn").attr("action", "/group/list").submit();
    })

    $("#group_is_secret").click(function (){
        if($("#group_is_secret").is(':checked')){
            $("#group_password").attr('readonly',false)
        }else{
            $("#group_password").attr('readonly',true)
        }
    })
    $(".button-create-customY").click(function (){

        if($("#group_is_secret").is(':checked')){
            if($("#group_password").val() === ""){
                $("#group_password").attr('required', true)
            }
        }
        if($("#group_name").val()===""){
            $("#group_name").attr('required', true)
        }
    })
    $("#group_password").on('input', function(e){
        var regex = new RegExp("^[A-Za-z0-9]+$"); // 비밀번호 설정
        if(!regex.test(e.target.value)){
            console.log("tick");
            var str = e.target.value;
            e.target.value= str.substring(0, str.length-1);
        }
    })

</script>
