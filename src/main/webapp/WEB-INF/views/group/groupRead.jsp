<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"> 그룹 조회 페이지 </div> <!-- /.panel-heading -->
            <div class="panel-body">
                <form id='operForm' action="/group/read">
                <div class="form-group">
                    <label for="group_id">방번호</label>
                    <input class="form-control" name="group_id" id="group_id" value="${group.group_id}"
                           readonly="readonly">
                </div>
                <div class="form-group">
                    <label for="group_name"> 방제목</label>
                    <input class="form-control" name="group_name" id="group_name" value="${group.group_name}"
                           readonly="readonly">
                </div>
                <div>
                    <label for="group_category">그룹 카테고리</label>
                    <input class="form-control" name="group_category" id="group_category" value="${group.group_category}"
                           readonly="readonly">
                </div>


                <div class="form-group">
                    <label for="group_content">텍스트 영역</label>
                    <textarea class="form-control" rows="3" name="group_content" id="group_content"
                              readonly="readonly">${group.group_content}</textarea>
                </div>
                <div class="form-group">
                    <label for="user_nickname_group_header">그룹장</label>
                    <input class="form-control" name="user_nickname_group_header" id="user_nickname_group_header" value="${group.user_nickname_group_header}"
                           readonly="readonly">
                </div>
                <div class="form-group">
                    <label for="group_person_count">참여인원</label>
                    <input class="form-control" name="group_person_count" id="group_person_count" value="${group.group_join_person_number}/${group.group_person_count}"
                           readonly="readonly">
                </div>


                <div class="form-group">
                    <label for="group_reg_date">그룹 생성일</label>

                    <input class="form-control" name="group_reg_date" id="group_reg_date"
                           value="<fmt:parseDate var="date1" value="${group.group_reg_date}" pattern="yyyy-MM-dd"/><fmt:formatDate value="${date1}" type="DATE" pattern="yyyy-MM-dd"/>"
                           readonly="readonly">

                </div>
                    <button data-oper='modify' class="btn btn-default"> 수정</button>
                    <button data-oper='list' class="btn btn-info">목록 </button>
                    <button data-oper='remove' class="btn btn-danger">그룹 파괴</button>
                    <button data-oper='remove' class="btn btn-block">탈퇴 하기</button>
                    <button data-oper='join' class="btn btn-warning">그룹 가입 </button>

                    <input type="hidden" name="group_id" value="${group.group_id}" />
<%--                    <input type="hidden" name="pageNum" value="${cri.pageNum}" />--%>
<%--                    <input type="hidden" name="amount" value="${cri.amount}" />--%>
<%--                    <input type='hidden' name='type' value='<c:out value ="${cri.type}"/>'>--%>
<%--                    <input type='hidden' name='keyword' value='<c:out value ="${cri.keyword}"/>'>--%>
                </form>

                <!---------------------------------------------------------------------------------------->
                <!-- 타이머  표시 -->
                <div class="container">
                    <div class="row spinner-row">
                        <button class="btn btn-warning" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                            <span>Loading...</span>
                        </button>
                    </div>
                    <div class="row my-user-and-timer-row">

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



                <button id="modalShowButton">그룹메세지</button>
                <%--모달시작--%>
                <div class="modal" tabindex="-1">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title">그룹 메세지</h3>
                                <button id="modal_close" class="btn-close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="readGroupMessage"></div>
                                <form id = 'sendGroupMessage' action='/group/ajax/new' method='post'>
                                    <div class = 'md-3'>
                                        <label for = 'message-text' class='col-form-label'> 입력창 </label>
                                        <textarea class='form-control' id='message-text'></textarea>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" id="message_submit" class="btn btn-primary">전송</button>
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
    .my-img{
        width: 150px;
        height: 150px;

        -webkit-mask:url("/resources/img/pngegg (1).png");
        -webkit-mask-size: contain;
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
</style>
<!---------------------------------------------------------------------------------------->

<script type="text/javascript" src="/resources/js/message.js"></script>
<script>
    $(document).ready(function (){
        var password =  ${group.group_password}

        $(".btn-default").click(function (){
            $(operForm).attr("action","/group/modify").attr("method","get").submit(); //수정으로 돌아기기
        })

        $(".btn-info").click(function (){
            $(operForm).find("#group_id").remove();
            $(operForm).attr("action", "/group/list").attr("method","get").submit(); //리스트로 돌아가기
        })

        if(${group.user_id_group_header eq user_id}) {
            console.log("아이디가 같나?")
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

            if(${group.group_join_person_number == group.group_person_count}){
                alert('인원수가 초과되었습니다.')
                return false;
            }

            <%--if(${group.group_is_secret==1}){--%>

            <%--    // const checkPass = prompt('비밀번호를 입력하세요');--%>

            <%--    // if(checkPass === password){--%>
            <%--    //     $(operForm).attr("action","/group/read").attr("method","post").submit();  //비밀번호 입력 후 회원가입--%>
            <%--    // }--%>
            <%--    &lt;%&ndash;if(checkPass === ${check}){&ndash;%&gt;--%>
            <%--    &lt;%&ndash;    $(operForm).attr("action","/group/read").attr("method","post").submit();  //회원가입&ndash;%&gt;--%>
            <%--    &lt;%&ndash;}&ndash;%&gt;--%>
            <%--    return false;--%>

            <%--}--%>
            $(operForm).attr("action","/group/read").attr("method","post").submit();  //회원가입
        })
        $('.btn-danger').click(function (){
            $(operForm).attr("action","/group/groupRemove").attr("method","post").submit();  //그룹 파괴
        })
        $('.btn-block').click(function (){
            $(operForm).attr("action","/group/userRemove").attr("method","post").submit();  //탈퇴하기
        })

        var group_id = '${group.group_id}'
        var criterionNumber = ${firstCriNumber};
        // 스크롤로 더보기 구현
        var isLoading = false;

        //modal창 보여주기
        $("#modalShowButton").click(function (){
            $('.modal').modal("show")
            //첫번째 10개 메세지
            criterionNumber = criterionNumber-10;
            console.log(criterionNumber)

            messageService.getList(group_id,criterionNumber,function(result){
                $('.readGroupMessage').html(result);
                    //스크롤 이벤트
                    function loadNewPage(){
                        //다음 10개 추가
                        criterionNumber = criterionNumber-10;
                        console.log("스크롤 했을때 크리넘버: "+criterionNumber)

                        var temp = $('.modal').height();
                        messageService.getList(group_id,criterionNumber,function (result){
                            $('.readGroupMessage').html(result);
                            if(criterionNumber < 0) alert("마지막 메세지입니다.")

                            $('.modal').scrollTop($('.modal').height()-temp);
                            isLoading = false;
                        })
                    }

                    $('.modal').scroll(function (){
                        if($('.modal').scrollTop() <60 && !isLoading){
                            isLoading = true;
                            setTimeout(loadNewPage,1200);
                        }
                    })

                $(".remove_message").click(function (){
                    var group_message_id = $(this).val()
                    messageService.remove(group_message_id,function (deleteResult){
                        if(deleteResult == "success"){
                            alert("삭제되었습니다.");
                            $('.modal').modal("hide");
                        }
                    }, function (err){
                        alert("에러 발생");
                    })
                })

                $("#message_submit").click(function (){
                    var message = {
                        "user_id":'user1', //이후 쿠키에서 가져온 뒤 수정
                        "group_message_content": $('#message-text').val()
                    }
                    messageService.add(group_id,message,function (result){
                        if(result == "success"){
                            alert("입력되었습니다.")
                            $('#message-text').val("");
                            $('.modal').modal("hide");
                        }
                    })
                })
            });
        })

        $("#modal_close").click(function (){
            $('.modal').modal("hide")
        })
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
        list.forEach(data => {
            str+='<div class="col-md-3 mt-2">'
            str+='  <div class="row">'
            str+='    <div class="col-6 col-md-12">'
            str+='      <div class="my-img '+ (data.timer_is_play===1 ?'my-img-yellow':'my-img-balck')+'"></div>'
            str+='    </div>'
            str+='    <div class="col-6 col-md-12">'
            str+='      <div class="caption">'
            str+='        <p class="h6 text-center '+ (data.timer_is_play===1 ?'my-font-yellow':'')+'">'+data.user_nickname;
            str+='           <br>'+returnAccumulatedTimeToStringFormat(data.timer_accumulated_day)+'</p>'
            str+='      </div>'
            str+='    </div>'
            str+='  </div>'
            str+='</div>'

            // timer 증가
            if(data.timer_is_play===1){
                // timer_accumulated_day가 배열형식으로 되어있음
                [hour, minute, second] = data.timer_accumulated_day;

                second = second + 1;
                if (second >= 60) {
                    minute = minute + 1;
                    second = 0;
                }
                if (minute >= 60) {
                    hour = hour + 1;
                    minute = 0;
                }
                data.timer_accumulated_day = [hour, minute, second]
            }
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
                    console.log(result[i])
                    console.log(new Date(...result[i].timer_mod_date))

                    if(result[i].timer_accumulated_day.length < 3){
                        result[i].timer_accumulated_day = [0,0,0];
                    }
                    if(result[i].timer_is_play===1){
                        // timer_accumulated_day가 배열형식으로 되어있음
                        var now = new Date();
                        var lastModTime = new Date(...result[i].timer_mod_date);

                        [hour, minute, second] = result[i].timer_accumulated_day
                        result[i].timer_accumulated_day = [
                            now.getHours()-lastModTime.getHours()+hour,
                            now.getMinutes()-lastModTime.getMinutes()+minute,
                            now.getSeconds()-lastModTime.getSeconds()+second
                        ]
                    }
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

