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
                <div>
                    <button class="btn btn-warning">그룹 가입 </button>
                    <button id= "removeGroup" class="btn btn-danger">그룹 파괴</button>
                    <button class="btn btn-info">목록 </button>
                    <button id="removeOne" class="btn btn-block">탈퇴 하기</button>
                </div>
                <button id="modifyBtn" class="btn btn-default"> 수정</button>
                <form id='operForm' action="/group/read">
                    <div style="background-color: #efefef; margin-top: 20px; padding-top:20px; padding-bottom: 40px;" class="center-block;">
                            <div class="card user-card-group"  value="${group.group_is_secret}">
<%--                                <div class="card-body">--%>
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
<%--                                </div> <!-- card-body -->--%>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item group-content">${group.group_content}</li>
                                </ul>
                            </div>
                    </div>
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
                <div class="col-10 offset-1  col-md-8 offset-md-2">
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
                                <div id="readGroupMessage"></div>
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
<%@ include file="../includes/footer.jsp" %>
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

        $('.btn-warning').click(function (){
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

        //메세지 버튼 플로팅배너
        var floatPosition = parseInt($("#modalShowButton").css('top'));
        $(window).scroll(function() {
        // 현재 스크롤 위치를 가져온다.
            var scrollTop = $(window).scrollTop();
            var newPosition = scrollTop + floatPosition + "px";

            $("#modalShowButton").stop().animate({
                "top" : newPosition
            }, 500);

        }).scroll();

        //modal창 보여주기
        $("#modalShowButton").click(function () {
            var limit = 0
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
                    if(result == []){
                        console.log("다 가져왔습니다")
                        isLoading = true;
                    }else {
                        $('#readGroupMessage').prepend(result);
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

            $('#readGroupMessage').on("hide",$('.remove_message'));
            $("#readGroupMessage").on("swipeleft",$(".flex-row-reverse"),function(){
                console.log("확인용")
            });

        // //메세지 삭제
        // $("#readGroupMessage").on("click","button",function () {
        //     var group_message_id = $(this).val()
        //     messageService.remove(group_message_id, function (deleteResult) {
        //         if (deleteResult == "success") {
        //             messageService.getList(group_id, limit, function (result) {
        //                 $('#readGroupMessage').html(result);
        //             })
        //         }
        //     })
        // })


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
<!-- 타이머 script -->
<script>

    var group_id = "${group.group_id}";


    function returnAccumulatedTimeToStringFormat(timeValue){
        var array2 = [0,0,0].concat(timeValue)
        return new Date(Date.UTC(...array2)).toISOString().substring(11,19);
    };



    function getStringIconUserDOMObjects(list){
        var str = '';
        list.forEach((data, idx) => {
            // timer 계산
            if(data.timer_is_play===1 && data.timer_is_on_site===1){
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
            }else{
                data["show_timer"] = [...data.timer_accumulated_day];
            }

            str+='<div class="col mt-2">'
            str+='  <div class="row">'
            str+='    <div class="d-flex justify-content-center">'
            str+='      <div class="img-container">'
            str+='          <div class="my-img '+ (data.timer_is_play===1 && data.timer_is_on_site===1 ?'my-img-yellow':'my-img-balck')+'"></div>'
            str+='      </div>'
            str+='    </div>'
            str+='    <div>'
            str+='      <div class="caption d-flex justify-content-center">'
            str+='        <p class="text-center text-truncate '+ (data.timer_is_play===1 && data.timer_is_on_site===1 ?'my-font-yellow':'')+'">'+data.user_nickname;
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
            //getStringIconUserDOMObjects(list)
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
                    // if(result[i].timer_is_play===1 && result[i].timer_is_on_site===1){
                    //     // // timer_accumulated_day가 배열형식으로 되어있음
                    //     // var now = new Date();
                    //     // var lastModTime = new Date(...result[i].timer_mod_date);
                    //     //
                    //     // [hour, minute, second] = result[i].timer_accumulated_day
                    //     // result[i].timer_accumulated_day = [
                    //     //     now.getHours()-lastModTime.getHours()+hour,
                    //     //     now.getMinutes()-lastModTime.getMinutes()+minute,
                    //     //     now.getSeconds()-lastModTime.getSeconds()+second
                    //     // ]
                    // }
                }
                startIntervalViewUserTimerList(result);
            },//end ajax success
            error: function(xhr, status, er){
                alert("error : "+er)
            }
        });//end ajax
    }

    function startIntervalGetUserTimerList(){
        getGroupUserTimerList();
        timerIntervalID = setInterval(function () {
            getGroupUserTimerList();
        }, 60000); //1 min
    }//end startIntervalGetUserTimerList

    $(document).ready(function () {
        startIntervalGetUserTimerList();
    });
</script>
<!-- end timer script -->

