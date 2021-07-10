<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<style>
    .form-control:focus{
        box-shadow: unset;
    }
    .table {
        table-layout: fixed;
    }
</style>

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
    <div style="text-align: center; margin-bottom:20px; margin-top: 20px;">
        <button style="width: 150px;" type="button" class="button-add-custom" id="addBtn">더보기</button>
    </div>
</div>
<style>
    .footerMargin{
        margin-top: 20vh;
    }
</style>
<div class="footerMargin"></div>


<div class="modal fade" id="createNotice">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" style="margin-left: 30px;">공지 등록 🧐</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="/ajax/notice/add">
                <div class="modal-body">
                    <div class="mb-3">
                        <textarea id="notice-text" maxlength='20' class="form-control" aria-describedby="pwHelpInline" placeholder="공지 내용" style="border: black 1px solid;margin-top: 20px; resize: none; height: 150px;"></textarea>
                    </div>
                    <p id="pwHelpInline1" class="form-text text-danger" style="text-align: left;margin-left: 10px;">
                        &nbsp;
                    </p>
                </div>
                <div class="modal-footer" style="border-color:black;">
                    <button style="width: 150px;" id="noticeSubmit" type="button" class="passwordCheck button-add-custom">등 록</button>
                    <button style="width: 150px;" type="button" class="button-add-custom" onclick="reset()" data-bs-dismiss="modal">취 소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="modifyNotice">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" id="modifyModalLabel" style="margin-left: 30px;">공지 수정 🤓</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="/ajax/notice/modify">
                <div class="modal-body">
                    <div class="mb-3">
                        <textarea id="modify_notice_text" maxlength='20' class="form-control" aria-describedby="pwHelpInline" placeholder="내용" style="border: black 1px solid;margin-top: 20px; resize: none; height:150px;"></textarea>
                    </div>
                    <p id="pwHelpInline2" class="form-text text-danger" style="text-align: left;margin-left: 10px;">
                        &nbsp;
                    </p>
                </div>
                <div class="modal-footer" style="border-color:black;">
                    <button style="width: 150px;" id="modifySubmit" type="button" class="passwordCheck button-add-custom">수 정</button>
                    <button style="width: 150px;" type="button" class="button-add-custom" onclick="reset()" data-bs-dismiss="modal">취 소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript" src="/resources/js/notice.js"></script>
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
        });
        $('#noticeSubmit').click(function (){
            var notice = {
                "notice_content": $('#notice-text').val()
            }
            noticeService.add(notice,function (result){
                if(result == "success"){
                    alert("등록 완료 😎")
                    location.reload();
                    $('#notice-text').val("");
                    $('#createNotice').modal("hide");
                }
            })
        });
        //공지사항 드롭다운
        var clickedNoticeID;
        // var noticeID;
        $("#noticeSection").on("click","tr:nth-child(odd)",function (e) {
            console.log("clicked")
            clickedNoticeID = $(this).find(".noticeId").val();
            console.log(clickedNoticeID)
            var noticeContent = $(this).next("tr");
            if ($(noticeContent).hasClass('hideContent')) {
                console.log("true")
                $(noticeContent).removeClass('hideContent').addClass('showContent');
                $($(this).find(".drop-icon")).html("<svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile-upside-down smileSize' viewBox='0 0 16 16'><path d='M8 1a7 7 0 1 0 0 14A7 7 0 0 0 8 1zm0-1a8 8 0 1 1 0 16A8 8 0 0 1 8 0z'/><path d='M4.285 6.433a.5.5 0 0 0 .683-.183A3.498 3.498 0 0 1 8 4.5c1.295 0 2.426.703 3.032 1.75a.5.5 0 0 0 .866-.5A4.498 4.498 0 0 0 8 3.5a4.5 4.5 0 0 0-3.898 2.25.5.5 0 0 0 .183.683zM7 9.5C7 8.672 6.552 8 6 8s-1 .672-1 1.5.448 1.5 1 1.5 1-.672 1-1.5zm4 0c0-.828-.448-1.5-1-1.5s-1 .672-1 1.5.448 1.5 1 1.5 1-.672 1-1.5z'/></svg>");
            } else {
                $(noticeContent).removeClass('showContent').addClass('hideContent');
                $($(this).find(".drop-icon")).html("<svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile smileSize' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/><path d='M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z'/></svg>");
            }
        });
        $("#noticeSection").on("click", " .modifyNoticeButton", function (){
            clickedNoticeID = $(this).closest(".noticeContent").prev().find(".noticeId").val();
            $('#modifyNotice').modal('show');
            $.ajax({
                type:"post",
                url:"/ajax/notice/read?notice_id="+clickedNoticeID,
                data:{
                    noticeID:"${clickedNoticeID}",
                },
                dataType:"json",
                success : function (res){
                    const content = res['notice_content'];
                    $('#modify_notice_text').text(content.notice_content);
                },
                error : ()=>{}
            })
        });
        $('#modifySubmit').click(function (){
            var notice = {
                "notice_content": $('#modify_notice_text').val(),
                "notice_id":clickedNoticeID,
            }
            $.ajax({
                type:"post",
                url:"/ajax/notice/modify",
                data : JSON.stringify(notice),
                dataType:"json",
                contentType: "application/json; charset=UTF-8;",
                success : function (res){
                    const success = res['success'];
                    alert("수정 완료 😎");
                    location.reload();
                    $('#modify_notice_text').val("");
                    $('#modifyNotice').modal("hide");
                },
                error : ()=>{}
            })
        })
        $("#noticeSection").on("click", ".removeNoticeButton", function (){
            clickedNoticeID = $(this).closest(".noticeContent").prev().find(".noticeId").val();
            $.ajax({
                type:"delete",
                url:"/ajax/notice/remove?notice_id="+clickedNoticeID,
                data : {
                    "notice_id":clickedNoticeID
                },
                success: function (res){
                    alert("삭제 완료 😎");
                    location.reload();
                },
                error : ()=>{}
            })
        })
    })// end document ready
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
                    let lines = list[i].notice_content.split("\n")
                    data += "<tr class='itemTitle'>";
                    data += "   <input type='hidden' class='noticeId' value='" + list[i].notice_id+ "'></input>";
                    data += "   <td id='noticeDate' class='align-middle'>"+ displayTime(list[i].notice_reg_date) + "</td>";
                    data += "   <td><div id='notice-content' class='noticeContent text-truncate'>"+lines[0]+"</div></td>";
                    data += "   <td class='drop-icon' style='padding-left: 15px;'>" ;
                    data += "        <svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-emoji-smile smileSize' viewBox='0 0 16 16'>";
                    data += "           <path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/><path d='M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z'/>";
                    data += "       </svg>";
                    data += "   </td>";
                    data += "</tr>";
                    data += "<tr class='hideContent noticeContent'>";
                    data += "   <td></td>";
                    data += "   <td>";
                    data += "       <p>";
                    for (let i = 0; i < lines.length; i++) {
                        data += lines[i] + "<br/>";
                    }
                    data += "       </p>";
                    data += "       <button style='width: 60px;border: 1px solid black;border-radius: 1rem; cursor: pointer; background-color: #ffc107;' type='button' class='modifyNoticeButton' value='"+user_id+"'>수정</button>";
                    data += "       <button style='width: 60px;border: 1px solid black;border-radius: 1rem; cursor: pointer; background-color: #ff9000;' type='button' class='removeNoticeButton' value='"+user_id+"'>삭제</button>";
                    data += "   </td><td></td>";
                    data += "</tr>";
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
                //더보기할 내용없을시 더보기 버튼 삭제
                if(list.length<10){
                    $("#addBtn").remove();
                }
            },
            error : ()=>{}
        });
    };
</script>




<%@ include file="../includes/smallTimer.jsp" %>
<%@ include file="../includes/footer.jsp" %>