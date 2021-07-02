<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp" %>

<html>
<head>
    <i class="bi bi-lock-fill"></i>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>그룹</title>
</head>
<body>
<link href="/resources/css/group.css" rel="stylesheet">
<div class="row">
    <div class="col-sm-12">
        <div style="text-align: center">
            <h2>스터디 그룹
                <button id="createBtn" type="submit" class="btn pull-right btn-warning">그룹 생성</button>
            </h2>
        </div>
        <table width="100%" class="table table-striped table-bordered table-hover"
               id="dataTables-example">
            <div class="row">
                <div class="col-lg-12">
                    <form id="listForm" action="/group/list" method="get">
                        <select name="category">
                            <option value="" <c:out value="${cri.category ==null?'selected':''}"/>>---</option>
                            <option value="토익"
                                    <c:out value="${cri.category eq '토익'?'selected':''}"/>>토익</option>
                            <option value="취업"
                                    <c:out value="${cri.category eq '취업'?'selected':''}"/>>취업</option>
                            <option value="자격증"
                                    <c:out value="${cri.category eq '자격증'?'selected':''}"/>>자격증</option>
                            <option value="이직"
                                    <c:out value="${cri.category eq '이직'?'selected':''}"/>>이직</option>
                        </select>
                        <input type="text" id="listSearch" name="keyword"/>
                        <button id="searchBtn" class='btn btn-default'>검색</button>
                    </form>
                </div>  <!-- col-lg-12 -->
                    <div class="row">
                        <div style="background-color: #efefef; margin-top: 20px; padding-top:20px; padding-bottom: 40px;" class="center-block;">
                            <c:forEach var="list" items="${list}" >
                                <div class="card user-card-group" style="cursor: pointer;" value="${list.group_is_secret}">
                                    <input type="hidden" name="group_id" value="${list.group_id}"/>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-10 group-category">${list.group_category}</div>
                                            <div class="col-2 text-end groupSecret">
                                                <c:if test="${list.group_is_secret==1}">
                                                    <div style="text-align: center; margin-top: 7px;">
                                                        <img src='/resources/img/lock.png' id='lockImg'/>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="group-list-margin">
                                            <span class="group-title">${list.group_name}</span>
                                        </div>
                                        <div>
                                            <span class="group-list-title">목표시간 : </span><span class="group-list-content">${list.group_target_hour} ${list.group_target_minute}</span><span class="group-list-title"> 그룹인원 : </span><span class="group-list-content">${list.group_join_person_number}/${list.group_person_count}명</span><span class="group-list-title">  그룹장 : </span><span class="group-list-content">${list.user_nickname_group_header}</span>
                                        </div>
                                        <div>
                                            <span class="group-list-title">공부량 : </span><span class="group-list-content">6시간 50분</span>
                                            <span class="group-list-title">  시작일 : </span><span class="group-list-content">
                        <fmt:parseDate var="date" value="${list.group_reg_date}" pattern="yyyy-MM-dd"/>
                            <fmt:formatDate value="${date}" type="DATE" pattern="yyyy-MM-dd"/></span>
                                        </div>
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item group-content">${list.group_content}</li>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
<%--            </div>--%>
        </table>
    </div>
</div>
<div class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">비밀번호 입력</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
    <form method='post'>
            <div class="modal-body">
                <input id="inputPass" type="text" placeholder="비밀번호를 입력하세요">
                <button type="button" class="btn btn-primary" >입력</button>
                <button class="btn btn-secondary" onclick="reset()" data-bs-dismiss="modal">취소</button>
            </div>
    </form>
        </div>
    </div>
</div>
</body>
</html>

<script>
    function reset(){
        $('#inputPass').val("");
        $('.modal').modal('');
    }
    $("#createBtn").click(function(){
        console.log("버튼 눌리나")
        $("#listForm").attr("action", "/group/create").submit();
    })

    $(".user-card-group").on('click',function (){
        var groupID = $(this).find('input[name=group_id]').attr('value');
        console.log("move눌리나 값"+ $(this).attr('value'));
        let url = "/group/read?group_id="+groupID;

        if($(this).attr('value')==1){
            console.log("move 그룹 아이디 가져오기"+ groupID);
            $('.modal').modal('show');
            $(".btn-primary").click(function (){

                console.log("모달창의 입력 값은? : "+ $('#inputPass').val());
                $.ajax({
                    type:"POST",
                    url:"/ajax/list/"+groupID,
                    dataType:"json",
                    success: function (res){
                        let passwordAjax = res['password'];
                        let passInput = $('#inputPass').val();
                        if(passwordAjax === passInput){
                            location.href=url;
                        }else{
                            console.log("bye ajax");
                        }

                        console.log("아작스 안에 들어온 패스워드",passwordAjax);
                        console.log("아작스 안에 들어온 인풋 패스워드",passInput);
                    },error : ()=>{}
                })
            })
        }else{
            location.href=url;
        }
    })
</script>

<!-- 부속 타이머 -->
<!-- 부속 타이머 -->
<!-- 부속 타이머 -->
<div class="toast-container p-1" style="z-index: 11; ">
    <div class="toast" data-bs-autohide="false" >
        <div class="t-header text-center py-2">
            <span>지금은 열공시간✨</span>
        </div>
        <div class="div-line" ></div>
        <div class="toast-body">
            <div class="row">
                <div class="col-12 text-center userTimer">
                    <span class="timer-hours">00</span><span>:</span><span
                        class="timer-min">00</span><span>:</span><span class="timer-sec">00</span>
                </div>
            </div>
            <div class="row">
                <div class="text-center">
                    <svg id="time-play" xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-triangle" viewBox="0 0 16 16">
                        <path d="M7.938 2.016A.13.13 0 0 1 8.002 2a.13.13 0 0 1 .063.016.146.146 0 0 1 .054.057l6.857 11.667c.036.06.035.124.002.183a.163.163 0 0 1-.054.06.116.116 0 0 1-.066.017H1.146a.115.115 0 0 1-.066-.017.163.163 0 0 1-.054-.06.176.176 0 0 1 .002-.183L7.884 2.073a.147.147 0 0 1 .054-.057zm1.044-.45a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566z"/>
                    </svg>
                    <svg id="time-pause" xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-view-stacked" viewBox="0 0 16 16">
                        <path d="M3 0h10a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2zm0 1a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3zm0 8h10a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2zm0 1a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1H3z"/>
                    </svg>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    .toast{
        box-shadow: 0 0 2px 3px rgba(0, 0, 0, 0.07);
        width: 100%;
        border-radius: 10px;
        border-color: rgba(0, 0, 0, 0.07);
        background-color: white;
    }
    .t-header{
        background-color: #fff6f1;
        border-radius: 10px;
    }
    .t-header span{
        font-size: 1.2rem;
    }
    .toast-container{
        position: fixed !important;
        bottom: 0 !important;
        width: 90%;
        max-width: 350px;
        min-width: 300px;
        margin-left: 5%;
        margin-bottom: 10%;
    }
    .div-line{
        border-top: 1px solid #313131;
        width: 100%;
    }
    .toast-body {
        padding-top: 0;
    }
    .userTimer {
        text-align: center;
        font-size: 2rem;
    }
    .toast-body svg{
        transform: rotate(90deg);
    }

    /* 스마트폰 이상 크기일때 */
    @media (min-width:576px) {
        .toast-container{
            width:30%;
            left: 0 !important;
            margin-left: 2%;
            margin-bottom: 1.5%;
        }
    }
    @media (min-width: 768px) {
        .toast-body{
            padding: 0.75rem;
        }
    }
</style>
<script src="/resources/js/swiped_up.js"></script>
<script src="/resources/js/timer.js"></script>
<script>
    var timerCookieStr = document.cookie
        .split('; ')
        .find(row => row.startsWith('timerCookie'))
        .split('=')[1];

    function alarmTimerResetWhen3AM(){
        // $("#modifySuccess .modal-title").html("공부기록 새로 시작")
        // $("#modifySuccess .modal-body").html("새벽 3시가 넘었어요. <br> 어제부터 시작한 공부시간이 저장되고 새로운 공부시간이 시작됩니다. :)");
        // $("#modifySuccess .button-add-custom").on("click", function (e){
        //     location.reload();
        // });
        // $("#modifySuccess").modal("show");
    }
    $(document).ready(function () {
        $('.toast').toast('show');
        $("#time-pause").hide();

        console.log(window.innerWidth)
        if(window.innerWidth<=500){
            var timerHide = true;
            var a1 = Swiped.init({
                query: '.toast-container',
                right: window.innerWidth*0.85,
                duration: 0,
                tolerance:100,
                onOpen :function (){
                    timerHide = true;
                },
                onClose: function (){
                    timerHide = false;
                }
            });
            a1.clickOpen();
            a1.duration = 500
            
            $('.toast').click(function (e) {
                if(timerHide){
                    a1.clickClose();
                }else {
                    a1.clickOpen();
                }
            });
        }


        var startIntervalToSaveTimerStatuesForAppleUserPerOneMinute;
        var clearIntervalToSaveTimerStatuesForAppleUser;
        var timerPlayFlag = false;
        $("#time-pause").click(function(e){
            e.stopPropagation();
            $(this).hide();
            $('#time-play').show();
            timerPlayFlag = false;
            timerStop(function(resultCookieTimer){
                //타이머정보가 db에 저장되면 타이머의 정보를 쿠키에 저장
                document.cookie = "timerCookie="+resultCookieTimer+";path=/; expires="+getDateStringToNextMorning3AM()+";";
            });
            if(clearIntervalToSaveTimerStatuesForAppleUser != null){
                clearIntervalToSaveTimerStatuesForAppleUser();
            }
        }) // end time-play

        $("#time-play").click(function(e){
            e.stopPropagation();
            $(this).hide();
            $('#time-pause').show();
            timerPlayFlag = true;
            timerStart(function(resultCookieTimer){
                //타이머정보가 db에 저장되면 타이머의 정보를 쿠키에 저장
                document.cookie = "timerCookie="+resultCookieTimer+";path=/; expires="+getDateStringToNextMorning3AM()+";";
            });
            // console.log("startInterval before : ", startIntervalToSaveTimerStatuesForAppleUserPerOneMinute);
            if(startIntervalToSaveTimerStatuesForAppleUserPerOneMinute != null){
                // console.log("startInterval")
                startIntervalToSaveTimerStatuesForAppleUserPerOneMinute();
            }
        });//end time-pause


        //beforeunload는 ios, mac os에서 안돌아감
        window.addEventListener('beforeunload', (e) =>{
            timerSaveBeforeUnloadPage()
            document.cookie = "timerCookie="+getPresentTimerStatus()+";path=/; expires="+getDateStringToNextMorning3AM()+";";
            //타이머정보를 쿠키에
        });

        //ios, mac os에서는 1분마다 한번씩 타이머 시간을 저장
        var isIOS = /Mac|iPad|iPhone|iPod/.test(navigator.userAgent);
        if (isIOS) {
            $(window).bind("pagehide", function (e){
                timerPlayFlag = false;
                document.cookie = "timerCookie="+getPresentTimerStatus()+";path=/; expires="+getDateStringToNextMorning3AM()+";";
            })

            $(window).bind("pageshow", function (e){
                if ( e.persisted || (window.performance && window.performance.navigation.type == 2) ){
                    location.reload();
                }
            })
            let intervalIdToSaveStatusforAppleUser;
            startIntervalToSaveTimerStatuesForAppleUserPerOneMinute = function (){
                intervalIdToSaveStatusforAppleUser = setInterval(function () {
                    timerSaveForAppleUserPeriodically();
                }, 50000);
            }
            clearIntervalToSaveTimerStatuesForAppleUser = function () {
                clearInterval(intervalIdToSaveStatusforAppleUser);
            }

            timerNumberInit($(".userTimer"), $("#time-play"), timerCookieStr, 1, alarmTimerResetWhen3AM) //새벽3시 알림 함수
        }else{
            console.log(timerCookieStr);
            //타이머 셋팅
            timerNumberInit($(".userTimer"), $("#time-play"), timerCookieStr, 0, alarmTimerResetWhen3AM);
        }
    })
</script>
<!-- end 부속 타이머 -->

<%@ include file="../includes/footer.jsp" %>