<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="../includes/header.jsp" %>


    <i class="bi bi-lock-fill"></i>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<link href="/resources/css/group.css" rel="stylesheet">
<div class="row" style="text-align: center; margin-top: 40px; margin-bottom:40px;position: relative;">
    <div class="col-2"></div>
    <div class="col-8"><h1>스터디 그룹</h1></div>
    <div class="col-2"><button style="width: 60px; position:absolute; right: 12vw;" type="button" class="button-timer-custom" id="createBtn">등록</button></div>
</div>

<div class="row"> <!-- search -->
    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
        <div class="col-lg-12">
            <form id="listForm" action="/group/list" method="get">
                <select class="category" name="category">
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
                <div class="searchForm">
                <input type="text" id="listSearch" name="keyword"/>
                <button id="searchBtn"><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>  <!-- col-lg-12 -->
    </table>
</div>
<div class="row">  <!-- groupList -->
    <div style="background-color: #efefef; margin-top: 20px; padding-top:20px; padding-bottom: 80px;" class="center-block;">
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
                            <span class="group-list-title">공부량 : </span><span class="group-list-content">
                            <c:choose>
                                <c:when test="${list.group_accumulated_avg_time eq '00:00'}">
                                    0시간 0분
                                </c:when>
                                <c:otherwise>
                                    <fmt:parseDate var="timeparse" type="time" timeStyle="FULL" value="${list.group_accumulated_avg_time}"  pattern="HH:mm:ss"/>
                                    <fmt:formatDate value="${timeparse}" type="time" pattern="KK시간 mm분"/>
                                </c:otherwise>
                            </c:choose>
                            </span>
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
</div>

<div class="modal" id="modalPass" tabindex="-1">
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


<script>
    function reset(){
        $('#inputPass').val("");
        $('#modalPass').modal('');
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
            $('#modalPass').modal('show');
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


<%@ include file="../includes/smallTimer.jsp" %>

<%@ include file="../includes/footer.jsp" %>