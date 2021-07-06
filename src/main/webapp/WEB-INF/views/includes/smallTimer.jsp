<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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

<!-- 타이머 리셋 Modal -->
<div class="modal fade" id="reset-timer-modal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" style="margin-left: 30px;">공부기록 새로 시작</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                새벽 3시가 넘었어요. <br> 어제부터 시작한 공부시간이 저장되고 새로운 공부시간이 시작됩니다. :)
            </div>
            <div class="modal-footer" style="border-color:black;">
                <button style="width: 150px;" type="button" class="button-add-custom" data-bs-dismiss="modal">확 인</button>
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
    var timerCookie = document.cookie
        .split('; ')
        .find(row => row.startsWith('timerCookie'));
    var timerCookieStr = '';

    if(timerCookie === undefined){
        location.href="/user/user";
    }else{
        timerCookieStr = timerCookie.split('=')[1];
    }

    console.log("group read page load", document.cookie);

    function alarmTimerResetWhen3AM(){
        $("#reset-timer-modal button").on("click", function (e){
            location.href="/user/user";
        });
        $("#reset-timer-modal").modal("show");
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

                //내 타이머 상태변화로 리셋함
                try {
                    startIntervalGetUserTimerList();
                } catch(e) {
                }
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

                //내 타이머 상태변화로 리셋함
                try {
                    startIntervalGetUserTimerList();
                } catch(e) {
                }
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

            var domain = 'localhost'

            $(window).bind("pagehide", function (e){
                // 내용 저장하는 interval멈추기
                clearInterval(timerIntervalID);
                clearIntervalToSaveTimerStatuesForAppleUser();
                // 쿠키 상태저장하기
                document.cookie = "timerCookie="+getPresentTimerStatus()+";path=/; expires="+getDateStringToNextMorning3AM()+";";
                console.log("user page hide", document.cookie, getPresentTimerStatus());
            })

            $(window).bind("pageshow", function (e){
                if ( e.persisted || (window.performance && window.performance.navigation.type == 2) ){
                    // 타이머 멈추기
                    $("#time-pause").hide();
                    $('#time-play').show();
                    timerPlayFlag = false;
                    clearInterval(timerIntervalID);
                    // 쿠키내용읽어오기
                    timerCookieStr =  document.cookie
                        .split('; ')
                        .find(row => row.startsWith('timerCookie'))
                        .split('=')[1];
                    // 타이머 리셋하기
                    timerNumberInit($(".userTimer"), $("#time-play"), timerCookieStr, 1, alarmTimerResetWhen3AM);

                    // a1.clickOpen();
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
            // console.log(timerCookieStr);
            //타이머 셋팅
            timerNumberInit($(".userTimer"), $("#time-play"), timerCookieStr, 0, alarmTimerResetWhen3AM);
        }
    })
</script>
<!-- end 부속 타이머 -->