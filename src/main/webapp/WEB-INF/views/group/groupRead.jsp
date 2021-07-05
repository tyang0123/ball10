<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp" %>

<style>
    .btn{
        display: inline-block;
        font-weight: 400;
        line-height: 1.5;
        color: #000000;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        background-color: #ffc107;
        border: 2px solid black;
        padding: 0.375rem 0.75rem;
        font-size: 1.1rem;
        width: 145px;
        margin-right: 3px;
    }
    .btn-info{
        float: right;
    }
    #removeGroup{
        background-color: red;
    }

</style>

<div class="row">

    <div class="col-lg-12">
        <div class="panel panel-default">
<%--            <div class="panel-heading"> 그룹 조회 페이지 </div> <!-- /.panel-heading -->--%>
            <div class="panel-body">
                <form id='operForm' action="/group/read">
                <div>
                    <button id="joinGroup" class="btn btn-warning">그룹 가입 </button>
                    <button id= "removeGroup" class="btn btn-danger">그룹 파괴</button>
                    <button class="btn btn-info">목록 </button>
                    <button id="removeOne" class="btn btn-block">탈퇴 하기</button>
                </div>
                <button id="modifyBtn" class="btn btn-default"> 수정</button>
<%--                <form id='operForm' action="/group/read">--%>
                        <div class="card user-card-group"  value="${group.group_is_secret}">
                                <div class="card-body" style="background-color: #efefef;  padding-top:20px; padding-bottom: 40px;">
                                    <div class="row">
                                        <div class="col-10 group-category">${group.group_category}</div>
                                        <div class="col-2 text-end groupSecret">
                                            <c:if test="${group.group_is_secret==1}">
                                                <img src='/resources/img/lock.png' id='lockImg'/>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="group-list-margin">
                                        <span class="group-title">${group.group_name}</span>
                                    </div>
                                    <div>
                                        <span class="group-list-title">목표시간 : </span><span class="group-list-content">${group.group_target_hour} ${group.group_target_minute} </span><span class="group-list-title"> 그룹인원 : </span><span class="group-list-content">${group.group_join_person_number}/${group.group_person_count}명</span><span class="group-list-title">  그룹장 : </span><span class="group-list-content">${group.user_nickname_group_header}</span>
                                    </div>
                                    <div>
                                        <span class="group-list-title">공부량 : </span><span class="group-list-content">6시간 50분</span>
                                        <span class="group-list-title">  시작일 : </span><span class="group-list-content">
                        <fmt:parseDate var="date" value="${group.group_reg_date}" pattern="yyyy-MM-dd"/>
                            <fmt:formatDate value="${date}" type="DATE" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div> <!-- card-body -->
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item group-content">${group.group_content}</li>
                                </ul>
                            </div>
<%--                        </div>--%>
                    <input type="hidden" name="group_id" value="${group.group_id}" />
<%--                    <input type="hidden" name="pageNum" value="${cri.pageNum}" />--%>
<%--                    <input type="hidden" name="amount" value="${cri.amount}" />--%>
<%--                    <input type='hidden' name='type' value='<c:out value ="${cri.type}"/>'>--%>
<%--                    <input type='hidden' name='keyword' value='<c:out value ="${cri.keyword}"/>'>--%>
                </form>
            </div>
        </div>
    </div>
</div>
                <!---------------------------------------------------------------------------------------->
                <!-- 타이머  표시 -->
                <div class="col-10 offset-1 col-lg-8 offset-lg-2">
                    <div class="row spinner-row">
                        <button class="btn btn-warning" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                            <span>Loading...</span>
                        </button>
                    </div>
                    <div class="row row-cols-3 row-cols-md-4 row-cols-lg-5 my-user-and-timer-row">

                        <div class="col-md-3 mt-2" hidden>
                            <div class="row">
                                <div class="col-6 col-md-12">
                                    <div class="my-img my-img-yellow"></div>
                                </div>
                                <div class="col-6 col-md-12">
                                    <div class="caption">
                                        <p>Lorem ipsum...</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 mt-2" hidden>
                            <div class="row">
                                <div class="col-6 col-md-12">
                                    <div class="my-img my-img-yellow"></div>
                                </div>
                                <div class="col-6 col-md-12">
                                    <div class="caption">
                                        <p>Lorem ipsum...</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!---------------------------------------------------------------------------------------->

                <img id = "modalShowButton" src="/resources/img/chat-left-dots.svg">
<%--                <button id="modalShowButton">그룹메세지</button>--%>
                <%--모달시작--%>
                <div class="modal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-scrollable">
                        <div class="modal-content" id="groupMessageModal">
                            <div class="modal-header" style="border-bottom: 1px solid black;">
                                <h3 class='col-12 modal-title text-center fw-lighter'>그룹 메세지</h3>
                                <button id="modal_close" class="btn-close" style="margin-left: -8px;"></button>
                            </div>
                            <div class="modal-body" style="padding: 2rem;padding-top: 1rem; padding-bottom: 1rem;">
                                <div id="readGroupMessage" class="swiper-container"></div>
                            </div>
                            <div class="modal-footer" style="display: block; border-top:1px solid black;">
                                <div class="row">
                                    <div class = 'col-sm-10'>
                                    <form id = 'sendGroupMessage' action='/group/ajax/new' method='post'>
                                        <textarea class='form-control' id='message-text' style='resize: none'></textarea>
                                    </form>
                                    </div>
                                    <div class = 'col-sm-2'>
                                        <button id="message_submit" class="form-control" type="submit" style="height:100%">전송</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- end panel-body -->
        </div> <!-- end panel -->
    </div> <!-- col-lg-12 -->
</div> <!-- row -->

<!---------------------------------------------------------------------------------------->
<!-- 타이머 스타일 -->
<style>
    .img-container{
        margin:0 auto;
    }
    .my-img{
        width: 120px;
        height: 120px;

        -webkit-mask:url("/resources/img/pngegg (1).png");
        mask-image: url("/resources/img/pngegg (1).png");
        -webkit-mask-size: 100%;
        mask-size: 100%;
        /*-webkit-mask:url("/resources/img/pngegg (1).png") no-repeat center/contain;*/
        /*mask:url("/resources/img/pngegg (1).png") center/contain;*/
    }

    .my-img-yellow{
        background:#ff9000;
    }

    .my-font-yellow{
        color:#ff9000;
    }

    .my-img-balck{
        background:black;
    }
    #modifyBtn {
        background-color : #ff9000;
    }

    .my-user-and-timer-row p{
        max-width: 180px;
        font-size: 1rem;
    }
    
    @media (max-width: 992px) {
        .my-img{
            width: 90px;
            height: 90px;
        }
        .my-user-and-timer-row p{
            max-width: 140px;
            font-size: 0.9rem;
        }
    }
    @media (max-width: 767px) {
        .my-img{
            width: 60px;
            height: 60px;
        }
        .my-user-and-timer-row p{
            max-width: 100px;
            font-size: 0.7rem;
        }
    }
</style>
<!---------------------------------------------------------------------------------------->
<script type="text/javascript" src="/resources/js/message.js"></script>
<script>
    $(document).ready(function (){

        $(".btn-default").click(function (){
            $('#operForm').attr("action","/group/modify").attr("method","get").submit(); //수정으로 돌아기기
        })

        $(".btn-info").click(function (){
            $('#operForm').find('${group.group_id}').remove();
            $('#operForm').attr("action", "/group/list").attr("method","get").submit(); //리스트로 돌아가기
        })

        if(${group.user_id_group_header eq user_id}) {
            // console.log("아이디가 같나?")
            $('.btn-warning').attr('hidden', true)
            $('.btn-block').attr('hidden', true)
        }else{
            $('.btn-danger').attr('hidden', true)
            $('.btn-default').attr('hidden', true)
        }
        if(${join >=1}){
            $('.btn-warning').attr('hidden',true);
        }else{
            $('.btn-block').attr('hidden', true)
        }

        $('#joinGroup').click(function (){
            console.log('그룹가입 버튼이 눌리나')

            if(${group.group_join_person_number >= group.group_person_count}){
                alert('인원수가 초과되었습니다.')
                return false;
            }
            $('#operForm').attr("action","/group/read").attr("method","post").submit();  //회원가입
        })
        $('.btn-danger').click(function (){
            $('#operForm').attr("action","/group/groupRemove").attr("method","post").submit();  //그룹 파괴
        })
        $('#removeOne').click(function (){
            $('#operForm').attr("action","/group/userRemove").attr("method","post").submit();  //탈퇴하기
        })


        <%-- 그룹 메세지 부분 --%>
        var group_id = '${group.group_id}'
        var user_id = '${user_id}';
        var count = ${count};

        //메세지 버튼 플로팅배너
        var currentPosition = parseInt($("#modalShowButton").css("top"));
        console.log(currentPosition)
        $(window).scroll(function() {
            var position = $(window).scrollTop();
            $("#modalShowButton").stop().animate({"top":position+currentPosition+10+"px"},1000);
        });


        //modal창 보여주기
        $("#modalShowButton").click(function () {
            var limit = 15
            $('.modal').modal("show")

            //처음 메세지 가져오기
            messageService.getList(group_id, limit, function (result) {
                $('#readGroupMessage').html(result);
            })

            //열었을때 입력창 보여주기
            var offset = $('#sendGroupMessage').offset();
            $('.modal-body').animate({scrollTop : offset.top}, 40);

            //상위로 스크롤 했을때 메세지 더보기
            var isLoading = false;

            function loadNewPage() {
                limit += 15;
                console.log("limit 값 : "+limit);
                var temp = $('.modal-body').prop('scrollHeight');
                messageService.getList(group_id, limit, function (result) {
                    if(limit > count){
                        console.log("다 가져왔습니다")
                        isLoading = true;
                        $('#readGroupMessage').html(result);
                    }else {
                        $('#readGroupMessage').html(result);
                        $('.modal-body').animate({scrollTop: $('.modal-body').prop('scrollHeight')-temp},1);
                        // $('.modal-body').scrollTop($('.modal-body').height()-temp);
                        isLoading = false;
                    }
                })
            }

            function upNdown() {
                var lastScroll = 0;
                $('.modal-body').scroll(function (event) {
                    var st = $(this).scrollTop();
                    if (st > lastScroll) {
                    } else {
                        if ($('.modal-body').scrollTop() < 5 && !isLoading) {
                            isLoading = true;
                            setTimeout(loadNewPage, 1200);
                        }
                        lastScroll = st;
                    };
                });
            };
            upNdown();
            //상위로 스크롤 했을때 메세지 더보기 끝
        // });

            //메세지 삭제
            $("#readGroupMessage").on("click",".flex-row-reverse",function () {
                //삭제 버튼 보이게
                $(this).children('.remove_message').css("display","block")
                $(".flex-row-reverse").not($(this)).children('.remove_message').css("display","none")


                //삭제 버튼 클릭했을때 삭제
                $(this).children('.remove_message').on("click",function (){
                    //val()값이 <empty string>이 나와서 대체 ㅠ.ㅠ
                    var group_message_idH = $(this).html()
                    var start = group_message_idH.indexOf(":");
                    var group_message_id = group_message_idH.substr(start+1,3);

                    // var group_message_id = $(this).val()
                    messageService.remove(group_message_id, function (deleteResult) {
                        if (deleteResult == "success") {
                            messageService.getList(group_id, limit, function (result) {
                                $('#readGroupMessage').html(result);
                            })
                        }
                    })
                })
            })

        //메세지 추가
        $("#message_submit").click(function () {
            var message = {
                "user_id": user_id,
                "group_message_content": $('#message-text').val()
            }
            messageService.add(group_id, message, function (result) {
                if(result == "success"){
                    $('#message-text').val("");
                    messageService.getList(group_id, limit, function (result) {
                        $('#readGroupMessage').html(result);
                    })
                }
            })
        })

        });

        $("#modal_close").click(function (){
            $('.modal').modal("hide")
        })

        //해당 그룹 멤버한테만 메세지 보이기(보이지 않는게 디폴트)
        var userJoined = ${userJoinedGroup};
        $("#modalShowButton").hide();
        for(var i = 0; i<userJoined.length; i++){
            if(group_id == userJoined[i]){
                $('#modalShowButton').show();
            }
        }
    })
</script>

<!---------------------------------------------------------------------------------------->
<!-- 그룹 멤버 타이머 script -->
<script>

    var group_id = "${group.group_id}";


    function returnAccumulatedTimeToStringFormat(timeValue){
        var array2 = [0,0,0].concat(timeValue)
        return new Date(Date.UTC(...array2)).toISOString().substring(11,19);
    };



    function getStringIconUserDOMObjects(list){
        var str = '';
        list.forEach((data, idx) => {
            let timerIsOnPlay = false;
            // timer 계산
            if(data.timer_is_play===1 && data.timer_is_on_site===1 && data.timer_is_use_apple === 0){
                timerIsOnPlay = true;
                // timer_accumulated_day가 배열형식으로 되어있음
                [hour, minute, second] = data.timer_accumulated_day;

                const tempTime = new Date(Date.UTC(0,0,0, hour, minute, second, 0)).getTime();
                const lastModTime = new Date(...data.timer_mod_date);
                let diffTime = new Date(Date.now() - lastModTime).getTime() + tempTime;
                diffTime = new Date(diffTime);


                hour = diffTime.getUTCHours();
                minute = diffTime.getUTCMinutes();
                second = diffTime.getUTCSeconds();

                data["show_timer"] = [hour, minute, second]
            }else if(data.timer_is_play===1 && data.timer_is_on_site===1 && data.timer_is_use_apple === 1){
                const lastModTime = new Date(...data.timer_mod_date);
                let diffTime = new Date(Date.now() - lastModTime);
                //console.log(diffTime.getUTCMinutes(), diffTime.getUTCSeconds());
                if(diffTime.getUTCMinutes() <= 1){
                    timerIsOnPlay = true;
                    [hour, minute, second] = data.timer_accumulated_day;
                    const tempTime = new Date(Date.UTC(0,0,0, hour, minute, second, 0)).getTime();

                    diffTime = new Date(diffTime.getTime() + tempTime);

                    hour = diffTime.getUTCHours();
                    minute = diffTime.getUTCMinutes();
                    second = diffTime.getUTCSeconds();

                    data["show_timer"] = [hour, minute, second]
                }else{
                    data["show_timer"] = [...data.timer_accumulated_day];
                }
            }else{
                data["show_timer"] = [...data.timer_accumulated_day];
            }

            str+='<div class="col mt-2">'
            str+='  <div class="row" data-timer-id="'+data.timer_id+'">'
            str+='    <div class="d-flex justify-content-center">'
            str+='      <div class="img-container">'
            str+='          <div class="my-img '+ (timerIsOnPlay ?'my-img-yellow':'my-img-balck')+'"></div>'
            str+='      </div>'
            str+='    </div>'
            str+='    <div>'
            str+='      <div class="caption d-flex justify-content-center">'
            str+='        <p class="text-center text-truncate '+ (timerIsOnPlay  ?'my-font-yellow':'')+'">'+data.user_nickname;
            str+='           <br>'+returnAccumulatedTimeToStringFormat(data.show_timer)+'</p>'
            str+='      </div>'
            str+='    </div>'
            str+='  </div>'
            str+='</div>'

        })

        $(".spinner-row").hide();
        $('.my-user-and-timer-row').empty().html(str);
    };

    var viewTimer;

    function startIntervalViewUserTimerList(list){
        clearInterval(viewTimer);
        getStringIconUserDOMObjects(list)
        viewTimer = setInterval(function(){
            getStringIconUserDOMObjects(list)
        }, 1000)
    }


    function getGroupUserTimerList(){
        $.ajax({
            type: "GET",
            url: "/ajax/timer/gettimers/"+group_id,
            success: function(result, status, xhr){
                for(var i in result){
                    // console.log(result[i])
                    // console.log(new Date(...result[i].timer_mod_date))

                    if(result[i].timer_accumulated_day.length < 3){
                        result[i].timer_accumulated_day = [0,0,0];
                    }
                }
                startIntervalViewUserTimerList(result);
            },//end ajax success
            error: function(xhr, status, er){
                alert("error : "+er)
            }
        });//end ajax
    }

    var groupTimerIntervalID;

    function startIntervalGetUserTimerList(){
        getGroupUserTimerList();
        clearInterval(groupTimerIntervalID);
        groupTimerIntervalID = setInterval(function () {
            getGroupUserTimerList();
        }, 60000); //1 min
    }//end startIntervalGetUserTimerList

    $(document).ready(function () {
        startIntervalGetUserTimerList();
    });

</script>
<!-- 그룹 멤버 타이머 script -->


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
                startIntervalGetUserTimerList()
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
                startIntervalGetUserTimerList()
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
                clearIntervalToSaveTimerStatuesForAppleUser();
                // 타이머 멈추기
                $("#time-pause").hide();
                $('#time-play').show();
                timerPlayFlag = false;
                executeTimerIntervalClear();
                // 쿠키 상태저장하기
                document.cookie = "timerCookie="+getPresentTimerStatus()+";path=/; expires="+getDateStringToNextMorning3AM()+";";
                console.log("user page hide", document.cookie, getPresentTimerStatus());
            })

            $(window).bind("pageshow", function (e){
                if ( e.persisted || (window.performance && window.performance.navigation.type == 2) ){
                    a1.clickOpen();
                    // 쿠키내용읽어오기
                    timerCookieStr =  document.cookie
                        .split('; ')
                        .find(row => row.startsWith('timerCookie'))
                        .split('=')[1];
                    // 타이머 리셋하기
                    timerNumberInit($(".userTimer"), $("#time-play"), timerCookieStr, 1, alarmTimerResetWhen3AM);

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


<%@ include file="../includes/footer.jsp" %>