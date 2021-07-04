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

<%--<!-- modal -->--%>
<%--<div class="modal fade" id="createNotice" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
<%--    <div class="modal-dialog">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <h5 class="modal-title" id="exampleModalLabel">공지작성</h5>--%>
<%--                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--            </div>--%>
<%--            <div class="modal-body">--%>
<%--                <form>--%>
<%--                    <div class="mb-3">--%>
<%--                        <input type="text" class="form-control" id="recipient-name" placeholder="제목">--%>
<%--                    </div>--%>
<%--                    <div class="mb-3">--%>
<%--                        <textarea class="form-control" id="notice-text" placeholder="내용"></textarea>--%>
<%--                    </div>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" id ="noticeSubmit" class="btn btn-primary">등록하기</button>--%>
<%--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

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


        <%--//공지등록--%>
        <%--$('#createNoticeButton').click(function (){--%>
        <%--    $('#createNotice').modal("show")--%>
        <%--    $('#noticeSubmit').click(function (){--%>
        <%--        var notice = {--%>
        <%--            "notice_content": $('#notice-text').val()--%>
        <%--        }--%>
        <%--        noticeService.add(notice,function (result){--%>
        <%--            if(result == "success"){--%>
        <%--                alert("등록되었습니다.")--%>
        <%--                $('#notice-text').val("");--%>
        <%--                $('#createNotice').modal("hide");--%>
        <%--            }--%>
        <%--        })--%>
        <%--    })--%>
        <%--})--%>
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
        $("#noticeSection").on("click","tr",function () {

            var myAlarm = $(this).next("tr");
            if ($(myAlarm).hasClass('hideContent')) {

                $(noticeShow).removeClass('showContent').addClass('hideContent');
                $(myAlarm).removeClass('hideContent').addClass('showContent');
                $($(this).find("#drop")).html("<svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile-upside-down smileSize' viewBox='0 0 16 16'><path d='M8 1a7 7 0 1 0 0 14A7 7 0 0 0 8 1zm0-1a8 8 0 1 1 0 16A8 8 0 0 1 8 0z'/><path d='M4.285 6.433a.5.5 0 0 0 .683-.183A3.498 3.498 0 0 1 8 4.5c1.295 0 2.426.703 3.032 1.75a.5.5 0 0 0 .866-.5A4.498 4.498 0 0 0 8 3.5a4.5 4.5 0 0 0-3.898 2.25.5.5 0 0 0 .183.683zM7 9.5C7 8.672 6.552 8 6 8s-1 .672-1 1.5.448 1.5 1 1.5 1-.672 1-1.5zm4 0c0-.828-.448-1.5-1-1.5s-1 .672-1 1.5.448 1.5 1 1.5 1-.672 1-1.5z'/></svg>");
            } else {
                $(myAlarm).addClass('hideContent').removeClass('showContent');
                $($(this).find("#drop")).html("<svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile smileSize' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/><path d='M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z'/></svg>");

            }
        })

    })

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
                    data += "<input type='hidden' value='" + list[i].notice_id + "'></input>";
                    data += "<td id='noticeDate' class='align-middle'>"+ displayTime(list[i].notice_mod_date) + "</td>";
                    data += "<td><div id='alarm-content' class='noticeContent'>"+list[i].notice_content+"</div></td>";
                    data += "<td id='drop' style='padding-left: 15px;'><svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile smileSize' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/><path d='M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z'/></svg></td>";
                    data += "</tr><tr class='hideContent noticeContent'><td></td><td>" + list[i].notice_content + "</p><button style='width: 60px;border: 1px solid black;border-radius: 1rem;  background-color: #ff9000;' type='button' class='modifyNoticeButton' value='"+user_id+"'>수정</button></p></td><td></td></tr>";
                }
                $('#noticeSection').append(data);
                changeCriterionNumber = $("#noticeSection input:last").val();
                //수정버튼 admin 에게만 보이게
                $('.modifyNoticeButton').hide();
                var userID = $('.modifyNoticeButton').val();
                if(userID == 'admin'){
                    $('.modifyNoticeButton').show();
                }else console.log("admin 계정이 아님");


                //더보기할 내용없을시 더보기 버튼 삭제
                if(list.length<10){
                    $("#addBtn").remove();
                }
            },
            error : ()=>{}
        });
    };


</script>

<%@ include file="../includes/footer.jsp" %>


