<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp" %>

<style>
    .btn-info:focus,
    .btn:focus {
        box-shadow: unset;
    }

</style>

<div class="row">
    <form id='operForm' action="/group/read">
        <div class="row" style="position: relative;text-align: center;margin-top: 3.5vw">
                <div class="col-2"><button style="background-color: #cb0d0d;left:7vw;top:1.5vw;" class="btn btn-danger group-read-buttonY btnsizeGroup" id="deleteBtn">그룹 파괴</button><button id="joinGroup" class="btn btn-warning group-read-buttonY btnsizeGroup" style="left:7vw;top:1.5vw;">그룹 가입</button><button id="removeOne" class="btn btn-block group-read-buttonY btnsizeGroup" style="left:7vw;top:1.5vw;">탈퇴 하기</button></div>
                <div style="margin-top: 10px;" class="col-8 group-read-title"><span>${group.group_name}</span></div>
                <div class="col-2"><button style="top:1.5vw;" class="btn btn-info group-read-buttonY">목록</button></div>
        </div>
        <div class="row" style="position: relative;text-align: center;margin-bottom:1.5vw">
            <div class="col-2"><button id="modifyBtn" style="background-color: #ff9000;left:7vw;" class="btn btn-default group-read-buttonY btnsizeGroup">수정</button></div>
            <div class="col-8"></div>
            <div class="col-2"></div>
        </div>
        <div class="row">
            <div class="col-12" style="text-align: center;margin-top: 10px"><span class="group-read-person1">멤버 </span><span style="color:#ff9000;" class="group-read-person2">${group.group_join_person_number}</span></div>
        </div>
        <div class="row">
            <div class="col-12" style="text-align: center;margin-top: 1vw">
                <div>
                    <span class="group-list-title">목표시간 : </span>
                    <span class="group-list-content">${group.group_target_hour} ${group.group_target_minute} </span>
                    <span class="group-list-title"> 그룹인원 : </span>
                    <span class="group-list-content">${group.group_join_person_number}/${group.group_person_count}명</span>
                    <span class="group-list-title">  그룹장 : </span>
                    <span class="group-list-content">${group.user_nickname_group_header}</span>
                </div>
                <div style="margin-bottom: 3vw;">
                    <span class="group-list-title"> 공부량 : </span>
                    <span class="group-list-content">
                         <c:choose>
                             <c:when test="${group.group_accumulated_avg_time eq '00:00'}">
                                 0시간 00분
                             </c:when>
                             <c:otherwise>
                                 <fmt:parseDate var="timeparse" type="time" timeStyle="FULL" value="${group.group_accumulated_avg_time}"  pattern="HH:mm:ss"/>
                                 <fmt:formatDate value="${timeparse}" type="time" pattern="K시간 mm분"/>
                             </c:otherwise>
                         </c:choose>
                    </span>
                    <span class="group-list-title">  시작일 : </span>
                    <span class="group-list-content">
                    <fmt:parseDate var="date" value="${group.group_reg_date}" pattern="yyyy-MM-dd"/>
                        <fmt:formatDate value="${date}" type="DATE" pattern="yyyy-MM-dd"/></span>
                </div>
                <div style="background-color: #cbcbcb; height: 1px;"></div>
                <div style="background-color: #efefef; height: 10px;"></div>
            </div>
        </div>

        <div class="group-notice-form">
            <div class="row">
                <div class="col-2 group-notice-content" style="text-align: center;">공지</div>
                <div class="col-8 group-notice-content" style="color: #858585;" id="noticeContent"></div>
                <div class="col-2" style="text-align: center;cursor:pointer;" id="clickNotice" value="1"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                </svg></div>
            </div>
        </div>
        <textarea id="inputbox" style="display:none;">${group.group_content}</textarea>
        <div style="background-color: #cbcbcb; height: 1px;"></div>
        <div style="background-color: #efefef; height: 10px;"></div>

        <input type="hidden" name="group_id" value="${group.group_id}" />
    </form>
</div>
<div class="group-notice-form">
    <div class="memberMarker"><span>그룹 멤버 현황 😌</span></div>
</div>


<!---------------------------------------------------------------------------------------->
<!-- 타이머  표시 -->
<%--<div class="col-10 offset-1 col-lg-8 offset-lg-2">--%>
<div class="col-10 offset-1 col-lg-10 offset-lg-1">
    <div class="row spinner-row">
        <button class="btn btn-warning" type="button" disabled>
            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
            <span>Loading...</span>
        </button>
    </div>
    <div class="row row-cols-4 row-cols-md-4 row-cols-lg-5 my-user-and-timer-row">

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

<img id = "modalShowButton" src="/resources/img/chat-left-dots.svg" style="cursor: pointer;">
<%--<button id="modalShowButton">그룹메세지</button>--%>
<%--모달시작--%>
<div class="modal" tabindex="-1" id="modalGroupMessage">
<%-- <div class="modal fade" id="modalGroupMessage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content" id="groupMessageModal">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" id="staticBackdropLabel"style="margin-left: 30px;">그룹 메세지</h4></span>
                <button style="color: black;" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
<%--                <h3 class='col-12 modal-title text-center fw-lighter'>그룹 메세지</h3>--%>
<%--                <button id="modal_close" class="btn-close" style="margin-left: -8px;"></button>--%>
            </div>
            <div class="modal-body-custom modal-body" style="padding: 2rem;padding-top: 1rem; padding-bottom: 1rem;">
                <div id="readGroupMessage" class="swiper-container"></div>
            </div>
<%--            <div class="modal-footer" style="display: block; border-top:1px solid black;">--%>
            <div class="modal-footer-custom modal-footer" style="display: inline-block;border-top:1px solid black;">
                <div class="row no-gutters">
                    <div class = 'col-10'>
                        <form id = 'sendGroupMessage' action='/group/ajax/new' method='post' style="margin-right: 2px;">
                            <textarea class='form-control' id='message-text' style='resize: none;'></textarea>
                        </form>
                    </div>
                    <div class = 'col-2'>
                        <button id="message_submit" class="form-control" type="submit" style="height:100%;">전송</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    .footerMargin{
        margin-top: 20vh;
    }
</style>
<div class="footerMargin"></div>


<!-- 파괴확인 Modal -->
<div class="modal fade" id="removeGroupCheck">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" style="margin-left: 30px;">그룹 파괴하기</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                정말로 그룹을 파괴하시겠습니까? 😢 😭
            </div>
            <div class="modal-footer" style="border-color:black;">
                <button style="width: 150px;" type="button" class="removeGroup button-add-custom">확 인</button>
                <button style="width: 150px;" type="button" class="button-add-custom" data-bs-dismiss="modal">취 소</button>
            </div>
        </div>
    </div>
</div>


<!---------------------------------------------------------------------------------------->
<!-- 타이머 스타일 -->
<style>
    .no-gutters {
        margin-right: 0;
        margin-left: 0;
    }

    .no-gutters > .col,
    .no-gutters > [class*="col-"] {
        padding-right: 0;
        padding-left: 0;
    }
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
            width: 75px;
            height: 75px;
        }
        .my-user-and-timer-row p{
            max-width: 120px;
            font-size: 0.8rem;
        }
    }
    @media (max-width: 512px) {
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
        let txtBox = document.getElementById("inputbox");
        let lines = txtBox.value.split("\n");

        $('#noticeContent').html(lines[0]);
        //공지사항 클릭 이벤트
        $('#clickNotice').click(function (){
            if($(this).attr("value")==1){
                $(this).attr("value","0");
                $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chevron-up' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z'/></svg>");
                processText();
            }
            else {
                $(this).attr("value","1");
                $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chevron-down' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z'/>");
                $('#noticeContent').html(lines[0]);
            }
        });

        //그룹 공지사항 입력 받은값 그대로 출력하는 함수
        function processText() {
            let resultString  = "<p>";
            for (let i = 0; i < lines.length; i++) {
                resultString += lines[i] + "<br/>";
            }
            resultString += "</p>";
            var blk = document.getElementById("noticeContent");
            blk.innerHTML = resultString;
        }

        $(".btn-default").click(function (){
            $('#operForm').attr("action","/group/modify").attr("method","get").submit(); //수정으로 돌아기기
        })

        $(".btn-info").click(function (){
            $('#operForm').find('${group.group_id}').remove();
            $('#operForm').attr("action", "/group/list").attr("method","get").submit(); //리스트로 돌아가기
        })

        if(${group.user_id_group_header eq user_id}) {
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
            if(${group.group_join_person_number >= group.group_person_count}){
                alert('인원수가 초과되었습니다.')
                return false;
            }
            $('#operForm').attr("action","/group/read").attr("method","post").submit();  //회원가입
        })
        $('#deleteBtn').click(function(){
            console.log("여기 파괴눌리니?");
            // $("#removeGroupCheck").modal("show");
        })
        $('.removeGroup').click(function (){
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

        var limit = 15
        messageService.getList(group_id, limit, function (result) {
            $('#readGroupMessage').html(result);
        })

        //modal창 보여주기
        $("#modalShowButton").click(function () {
            limit = 15
            $('#modalGroupMessage').modal("show")

            //처음 메세지 가져오기
            messageService.getList(group_id, limit, function (result) {
                $('#readGroupMessage').html(result);
            })
            console.log("리밋 값 : "+limit)

            //열었을때 입력창 보여주기
            var offset = $('.modal-footer-custom').offset();
            $('.modal-body-custom').animate({scrollTop : offset.top}, 40);
            // console.log(offset);
        })

        //상위로 스크롤 했을때 메세지 더보기
        var isLoading = false;

        function loadNewPage() {
            limit += 15;
            console.log("limit 값 : "+limit);
            var temp = $('.modal-body-custom').prop('scrollHeight');
            messageService.getList(group_id, limit, function (result) {
                if(limit > count){
                    console.log("다 가져왔습니다")
                    isLoading = true;
                    $('#readGroupMessage').html(result);
                }else {
                    $('#readGroupMessage').html(result);
                    $('.modal-body-custom').animate({scrollTop: $('.modal-body-custom').prop('scrollHeight')-temp},1);
                    // $('.modal-body').scrollTop($('.modal-body').height()-temp);
                    isLoading = false;
                }
            })
        }

        function upNdown() {
            var lastScroll = 0;
            $('.modal-body-custom').scroll(function (event) {
                var st = $(this).scrollTop();
                if (st > lastScroll) {
                } else {
                    if ($('.modal-body-custom').scrollTop() < 5 && !isLoading) {
                        // isLoading = true;
                        setTimeout(loadNewPage, 1200);
                    }
                    lastScroll = st;
                };
            });
        }

        upNdown();
        //상위로 스크롤 했을때 메세지 더보기 끝

        $('#modalGroupMessage').on('hidden.bs.modal', function () {
            isLoading = false;
        });

        //메세지 삭제
            $("#readGroupMessage").off("click").on("click",".flex-row-reverse",function () {
                //삭제 버튼 보이게
                if($(this).children('.remove_message').css("display") == "none"){
                    $(this).children('.remove_message').css("display","block")

                    //삭제 버튼 클릭했을때 삭제
                    $(this).children('.remove_message').off("click").on("click",function (){
                        //val()값이 <empty string>이 나와서 대체 ㅠ.ㅠ
                        var group_message_idH = $(this).html()
                        var start = group_message_idH.indexOf(':');
                        var end = group_message_idH.lastIndexOf('"');

                        var group_message_id = group_message_idH.substring(start+1,end);

                        // var group_message_id = $(this).val()
                        messageService.remove(group_message_id, function (deleteResult) {
                            if (deleteResult == "success") {
                                messageService.getList(group_id, limit, function (result) {
                                    $('#readGroupMessage').html(result);
                                })
                            }
                        })
                    })
                }else {
                    $(this).children('.remove_message').css("display","none")
                }
                // $(this).children('.remove_message').css("display","block")
                $(".flex-row-reverse").not($(this)).children('.remove_message').css("display","none")
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
                        var offset = $('.modal-body-custom').prop('scrollHeight');
                        $('.modal-body-custom').animate({scrollTop : offset}, 40);
                    })
                }
            })
        })

        // });

        $("#modal_close").click(function (){
            $('#modalGroupMessage').modal("hide")
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
                // alert("error : "+er)
            }
        });//end ajax
    }

    var groupTimerIntervalID;

    function startIntervalGetUserTimerList(){
        clearInterval(groupTimerIntervalID);
        getGroupUserTimerList();
        groupTimerIntervalID = setInterval(function () {
            getGroupUserTimerList();
        }, 60000); //1 min
    }//end startIntervalGetUserTimerList

    $(document).ready(function () {
        startIntervalGetUserTimerList();
    });

</script>
<!-- 그룹 멤버 타이머 script -->


<%@ include file="../includes/smallTimer.jsp" %>

<%@ include file="../includes/footer.jsp" %>