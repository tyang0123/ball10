<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="row" style="text-align: center;margin-top: 50px; margin-bottom:50px;position: relative;">
    <div class="col-2"></div>
    <div class="col-8"><h1>공지사항</h1></div>
    <div class="col-2"><button style="width: 60px; position:absolute; right: 9vw;" type="button" class="button-timer-custom" id="createNoticeButton" value="${userID}">등록</button></div>
</div>

<div class="row">
    <div id="noticeTable">
        <table class="alarmTable table table-hover">
            <thead>
            <tr>
                <th style="width: 20%; font-size: 20px">작성일</th>
                <th style="width: 70%; font-size: 20px">공지</th>
                <th style="width: 10%; font-size: 20px"></th>
            </tr>
            </thead>
            <tbody id="noticeSection">
            </tbody>
        </table>
    </div>
    <div style="text-align: center; margin-bottom:60px; margin-top: 20px;">
        <button style="width: 150px;" type="button" class="button-add-custom" id="addBtn">더보기</button>
    </div>
</div>



<!-- 기존 태양씨 작업 -->

<%--<h1>공지사항</h1>--%>

<%--<button id="createNoticeButton" value="${userID}">공지작성</button>--%>
<%--<c:forEach var="list" items="${list}">--%>
<%--    <div>--%>
<%--        <row>--%>
<%--            <b>작성일</b> : <fmt:formatDate pattern="yyyy.MM.dd" value="${list.notice_mod_date}"/>--%>
<%--        </row>--%>
<%--        <low class = "notice_title">--%>
<%--            <b class="title">제목</b>--%>
<%--            <button id="dropDownIcon${list.notice_id}">보기</button>--%>
<%--                &lt;%&ndash;            <i class="bi bi-chevron-down">아이콘</i>&ndash;%&gt;--%>
<%--            <div class = "dropdown">--%>
<%--                <div id="noticeContent${list.notice_id}">--%>
<%--                        ${list.notice_content}--%>
<%--                    <button id = "noticeModify">수정하기</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </low>--%>
<%--    </div>--%>
<%--</c:forEach>--%>

<!-- modal -->
<%--<div class="modal fade" id="createNotice" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
<%--    <div class="modal-dialog">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <h5 class="modal-title" id="exampleModalLabel">공지작성</h5>--%>
<%--                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--            </div>--%>
<%--            <div class="modal-body">--%>
<%--                <form action="/ajax/notice/add" method="post">--%>
<%--                    <div class="mb-3">--%>
<%--                        <input type="text" class="form-control" id="recipient-name" placeholder="제목">--%>
<%--                    </div>--%>
<%--&lt;%&ndash;                    <div class="mb-3">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <textarea class="form-control" id="notice-text" placeholder="내용"></textarea>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>
<%--                </form>--%>
<%--            </div>--%>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" id ="noticeSubmit" class="btn btn-primary">등록하기</button>--%>
<%--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<div class="modal fade" id="createNotice" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">공지작성</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/ajax/notice/add" method="post">
<%--                    <div class="mb-3">--%>
<%--                        <input type="text" class="form-control" id="notice-content" placeholder="제목">--%>
<%--                    </div>--%>
                    <div class="mb-3">
                        <textarea class="form-control" id="notice-text" placeholder="내용"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id ="noticeSubmit" class="btn btn-primary">등록하기</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modifyNotice" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modifyModalLabel">공지 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/ajax/notice/modify" method="post">
                    <div class="mb-3">
                        <textarea class="form-control" id="modify_notice_text" placeholder="내용"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="modifySubmit" class="btn btn-primary">수정하기</button>
                <button type="button" class="btn btn-secondary" onclick="reset()" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<%--<script type="text/javascript" src="/resources/js/notice.js"></script>--%>
<script>
    var changeCriterionNumber=${firstCriterionNumber};
    $(document).ready(function (){
        //페이지 로딩시 첫 실행
        moreList(changeCriterionNumber);

        //더보기 버튼 클릭시
        $("#addBtn").click(function (){
            moreList(changeCriterionNumber);
        })

        //공지등록 admin 에게만 보이게
        $('#createNoticeButton').hide();
        var userID = $('#createNoticeButton').val();
        if(userID == 'admin'){
            $('#createNoticeButton').show();
        }else console.log("admin 계정이 아님");


        //공지등록
        $('#createNoticeButton').click(function (){
            $('#createNotice').modal("show")
            $('#noticeSubmit').click(function (){
                var notice = {
                    "notice_content": $('#notice-text').val()
                }
                noticeService.add(notice,function (result){
                    if(result == "success"){
                        alert("등록되었습니다.")
                        $('#notice-text').val("");
                        $('#createNotice').modal("hide");

                    }
                })
            })
        })
        // $('#modifySubmit').click(function (){
        //     alert('수정되었습니다.')
        // })
        <%--//공지 수정하기--%>
        <%--$('#noticeModify').click(function (){--%>
        <%--    console.log("수정하기")--%>
        <%--})--%>
        <%--//공지 읽기--%>
        <%--var notice_count = ${noticeCount};--%>
        <%--$("[id^='noticeContent']").hide()--%>
        <%--for(i=1; i<=notice_count; i++){--%>
        <%--    (function (m){--%>
        <%--        document.getElementById("dropDownIcon"+m).addEventListener("click",function (){--%>
        <%--            $('#noticeContent'+m).show()--%>
        <%--        },false);--%>
        <%--    })(i);--%>
        <%--}--%>




        //공지사항 드롭다운
        var noticeShow = (".alarmTable .showContent");
        // var noticeID;
            $("#noticeSection").on("click","tr",function (e) {
            var noticeID = $(this).find("#noticeId").val();
            var contentOne = $(this).find(".notice-content").text();
            console.log("디스값 ",$(this));
            console.log("노티스 아이디1",noticeID);
            console.log("노티스 내용 :", contentOne);
            $(".modifyNoticeButton").click(function (){
                console.log("수정버튼이 눌리나",noticeID);
                $('#modifyNotice').modal('show');
                $.ajax({
                    type:"post",
                    url:"/ajax/notice/read?notice_id="+noticeID,
                    data:{
                        noticeID:"${noticeID}",
                    },
                    dataType:"json",
                    success : function (res){
                        const content = res['notice_content'];
                        $('#modify_notice_text').text(content.notice_content);
                    },
                    error : ()=>{}
                })

                $('#modifySubmit').click(function (){
                    console.log("수정완료 버튼을 눌렀을 때 노티스아이디 : ",noticeID )
                    console.log($('#modify_notice_text').val());
                    var notice = {
                        "notice_content": $('#modify_notice_text').val(),
                        "notice_id":noticeID,
                    }

                    $.ajax({
                        type:"post",
                        url:"/ajax/notice/modify",
                        data : JSON.stringify(notice),
                        dataType:"json",

                        success : function (res){
                            const success = res['success'];
                            alert("등록되었습니다. " + success);
                            $('#modify_notice_text').val("");
                            $('#modifyNotice').modal("hide");
                        },
                        error : ()=>{}

                    })
                })



                // noticeID="";
                // $('#modifyNotice').modal("show");
                // $('#modifySubmit').click(function (){
                //     var notice = {
                //         "notice_content": $('#modify_notice_text').val()
                //     }
                //     noticeService.modify(notice, noticeID, function (result){
                //         if(result == "success"){
                //             alert("수정되었습니다..")
                //             $('#modify_notice_text').val("");
                //             noticeID="";
                //             $('#modifyNotice').modal("hide");
                //         }
                //     })
                // })

            })

            var myAlarm = $(this).next("tr");
            if ($(myAlarm).hasClass('hideContent')) {
                console.log('나타났다')

                $(noticeShow).removeClass('showContent').addClass('hideContent');
                $(myAlarm).removeClass('hideContent').addClass('showContent');
                $($(this).find("#drop")).html("<svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile-upside-down smileSize' viewBox='0 0 16 16'><path d='M8 1a7 7 0 1 0 0 14A7 7 0 0 0 8 1zm0-1a8 8 0 1 1 0 16A8 8 0 0 1 8 0z'/><path d='M4.285 6.433a.5.5 0 0 0 .683-.183A3.498 3.498 0 0 1 8 4.5c1.295 0 2.426.703 3.032 1.75a.5.5 0 0 0 .866-.5A4.498 4.498 0 0 0 8 3.5a4.5 4.5 0 0 0-3.898 2.25.5.5 0 0 0 .183.683zM7 9.5C7 8.672 6.552 8 6 8s-1 .672-1 1.5.448 1.5 1 1.5 1-.672 1-1.5zm4 0c0-.828-.448-1.5-1-1.5s-1 .672-1 1.5.448 1.5 1 1.5 1-.672 1-1.5z'/></svg>");
            } else {
                $(myAlarm).addClass('hideContent').removeClass('showContent');
                $($(this).find("#drop")).html("<svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile smileSize' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/><path d='M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z'/></svg>");

            }

        })

    })
    // function reset(){
    //     $('#modify_notice_text').val('');
    //     $('#modifyNotice').modal('');
    // }

    //시간 디스플레이 변환
    const displayTime = (timeValue)=>{
        var today = new Date();
        var gap = today.getTime() - timeValue;
        var dateObj = new Date(timeValue);
        if(gap<(1000*60*60*24)){ //시분초  1milli second
            var hh =dateObj.getHours();
            var mi =dateObj.getMinutes();
            var ss =dateObj.getSeconds();
            return [ (hh>9?'':'0') +hh, ':',(mi>9?'':'0')+mi,':',(ss>9?'':'0')+ss].join('');
        }  else {//년월일
            var yy= dateObj.getFullYear();
            var mm= dateObj.getMonth() +1; //getMonth는 0부터 시작
            var dd = dateObj.getDate();
            return [ yy,'/',(mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd].join('');
        }
    };

    //리스트가 추가되는 함수
    const moreList = (criterionNumber)=>{
        $.ajax({
            type:"post",
            url:"/ajax/notice/list",
            data:{
                criterionNumber:criterionNumber,
                userID:"${userID}"
            },
            dataType:"json",
            success : function (res){
                const list = res['list'];
                const user_id = res['userID'];
                var data = "";
                for (var i = 0; i < list.length; i++) {
                    data += "<tr class='itemTitle'>";
                    data += "<input type='hidden' id='noticeId' value='" + list[i].notice_id+ "'></input>";
                    data += "<td id='noticeDate' class='align-middle'>"+ displayTime(list[i].notice_mod_date) + "</td>";
                    data += "<td><div id='notice-content' class='noticeContent'>"+list[i].notice_content+"</div></td>";
                    data += "<td id='drop' style='padding-left: 15px;'><svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile smileSize' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/><path d='M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z'/></svg></td>";
                    data += "</tr><tr class='hideContent noticeContent' ><td></td><td>" + list[i].notice_content + "</p><button style='width: 60px;border: 1px solid black;border-radius: 1rem; cursor: pointer; background-color: #ffc107;' type='button' id='modifyNoticeButton' class='modifyNoticeButton' value='"+user_id+"'>수정</button>";
                    data += " <button style='width: 60px;border: 1px solid black;border-radius: 1rem; cursor: pointer; background-color: #ff9000;' type='button' id='removeNoticeButton' class='removeNoticeButton' value='"+user_id+"'>삭제</button></p></td><td></td></tr>";
                }
                $('#noticeSection').append(data);
                changeCriterionNumber = $("#noticeSection input:last").val();

                //수정버튼 admin 에게만 보이게
                $('.modifyNoticeButton').hide();
                var userID = $('.modifyNoticeButton').val();
                if(userID == 'admin'){
                    $('.modifyNoticeButton').show();
                }else console.log("admin 계정이 아님");
                //삭제 버튼 또한 admin에게 보이게
                $('.removeNoticeButton').hide();
                var userID = $('.removeNoticeButton').val();
                if(userID == 'admin'){
                    $('.removeNoticeButton').show();
                }else console.log("admin 계정이 아님");

                // $('.modifyNoticeButton').click(function (){
                //     $('#modifyNotice').modal("show");
                //
                //     console.log("수정버튼이 눌리나")
                    // var notice = {
                    //     "notice_content": $('#modify_notice_text').val()
                    // }
                    // var notice = {
                    //     "notice_content": $('#noticeContent').val()
                    // }
                    // var no_id = {
                    //     "notice_id": $('#noticeId').val()
                    // }
                    //
                    // console.log("노티스 내용은? ",notice)
                    // console.log("노티스 아이디는 ? ",no_id);

                    // noticeService.modify(notice, list[i].notice_id, function (result){
                    //     if(result == "success"){
                    //         alert("수정되었습니다..")
                    //         $('#notice-text').val("");
                    //         $('#modifyNotice').modal("hide");
                    //
                    //     }
                    // })
                // })

                $('.removeNoticeButton').click(function (){
                    console.log("클릭이 들어오나")
                    noticeService.remove(8, function (result){
                        console.log(result);
                        if(result=="success"){
                            alert("삭제 됐습니다.");
                        }
                    }, function (err){
                        alert('ERROR...');
                    });
                })


                //더보기할 내용없을시 더보기 버튼 삭제
                if(list.length<10){
                    $("#addBtn").remove();
                }
            },
            error : ()=>{}
        });
    };

</script>
<%--<script type="text/javascript">--%>
<%--    $(document).ready(function (){--%>
<%--        $('#noticeSection').click(function (){--%>
<%--            var noticeID = $(this).find("#noticeId").val();--%>
<%--            console.log("노티스 아이디",noticeID)--%>
<%--            console.log("section 버튼이 눌리나")--%>
<%--        })--%>
<%--    })--%>

<%--</script>--%>




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


