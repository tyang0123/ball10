<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<link href="/resources/css/ml-calendar.css" rel="stylesheet">

<div class="row">


    <div class="ml-calendar-demo">
        <div class="ml-calendar">
            <section class="calendar-left">
                <div class="sidebar">
                    <p class="subheading"></p>
                    <h1><span class="cal-day"></span><br/><span class="cal-month"></span></h1>
                    <p class="primary-color"><span>0</span> Items</p>
                    <ul id="calendar-events">

                    </ul>
                    <p><a data-bs-toggle="modal" href="#insertSchedule" class="calendar-btn"><i class="fas fa-plus"></i> Add new item</a></p>
                </div>
            </section>
            <section class="calendar-right">
                <div class="calendar">
                    <section class="calendar-header">
                        <h2 class="header-margin"><strong></strong> <span></span></h2>
                        <div class="calendar-nav">
                            <a href="javascript:loadYYMM(init.prevMonth());"><i class="fas fa-arrow-left"></i></a><a href="javascript:goToday();">Today</a><a href="javascript:loadYYMM(init.nextMonth());"><i class="fas fa-arrow-right"></i></a>&nbsp;
                        </div>
                    </section>
                    <section class="calendar-row">
                        <div class="calendar-day day-name">일</div>
                        <div class="calendar-day day-name">월</div>
                        <div class="calendar-day day-name">화</div>
                        <div class="calendar-day day-name">수</div>
                        <div class="calendar-day day-name">목</div>
                        <div class="calendar-day day-name">금</div>
                        <div class="calendar-day day-name">토</div>
                    </section>
                    <div class="dateSection">

                    </div>
                </div>
            </section>
            <div class="clear"></div>
            </div>
        </div>
    </div>
</div>


<!-- 등록 Modal -->
<div class="modal fade" id="insertSchedule">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" style="margin-left: 30px;"></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form name="scheduleAdd" action="/ajax/schedule/add" method="post">
                <div class="modal-body">
                    <input type="hidden" id="scheduleDate" name="date"/>
                    <p style="margin-left: 10px;font-size: 20px;">스케쥴 등록 📝</p>
                    <select class="form-select form-select-custom" style="border: black 1px solid;margin-bottom: 15px;" name="hour">
                        <option value="" disabled selected hidden>몇시⏰</option>
                        <option value="00">0</option>
                        <option value="01">1</option>
                        <option value="02">2</option>
                        <option value="03">3</option>
                        <option value="04">4</option>
                        <option value="05">5</option>
                        <option value="06">6</option>
                        <option value="07">7</option>
                        <option value="08">8</option>
                        <option value="09">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                    </select>
                    <select class="form-select form-select-custom" style="border: black 1px solid;margin-bottom: 15px;" name="minute">
                        <option value="" disabled selected hidden>몇분</option>
                        <option value="00">00</option>
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                    </select>
                    <textarea class="form-control form-select-custom" rows="1" name="schedule_content" maxlength="20" placeholder="스케쥴 내용" style="resize: none;border: black 1px solid;margin-bottom: 15px;"></textarea>
                </div>
                <div class="modal-footer" style="border-color:black;">
                    <button style="width: 150px;" type="button" class="button-add-custom" id="schedule_submit">확 인</button>
                    <button style="width: 150px;" type="button" class="button-add-custom" data-bs-dismiss="modal">취 소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 수정 Modal -->
<div class="modal fade" id="modifySchedule">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title modal-title-modify" style="margin-left: 30px;"></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form name="scheduleModify" action="/ajax/schedule/modify" method="post">
                <div class="modal-body">
                    <input type="hidden" id="schedule_id" name="schedule_id"/>
                    <p style="margin-left: 10px;font-size: 20px;">스케쥴 수정 📝</p>
                    <select class="form-select form-select-custom" id="hourSelect" style="border: black 1px solid;margin-bottom: 15px;" name="hour">
                        <option value="" disabled selected hidden>몇시⏰</option>
                        <option value="00">0</option>
                        <option value="01">1</option>
                        <option value="02">2</option>
                        <option value="03">3</option>
                        <option value="04">4</option>
                        <option value="05">5</option>
                        <option value="06">6</option>
                        <option value="07">7</option>
                        <option value="08">8</option>
                        <option value="09">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                    </select>
                    <select class="form-select form-select-custom" id="minuteSelect" style="border: black 1px solid;margin-bottom: 15px;" name="minute">
                        <option value="" disabled selected hidden>몇분</option>
                        <option value="00">00</option>
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                    </select>
                    <textarea class="form-control form-select-custom" id="scheduleContent" rows="1" name="schedule_content" maxlength="20" placeholder="스케쥴 내용" style="resize: none;border: black 1px solid;margin-bottom: 15px;"></textarea>
                </div>
                <div class="modal-footer" style="border-color:black;">
                    <button style="width: 150px;" type="button" class="button-add-custom" id="modify_submit">수 정</button>
                    <button style="width: 150px;" type="button" class="button-add-custom" id="delete_submit">삭 제</button>
                    <button style="width: 150px;" type="button" class="button-add-custom" data-bs-dismiss="modal">취 소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="/resources/js/calendar.js"></script>
<script>

    $(document).ready(function (){
        //스케쥴 등록 모달
        $('.calendar-btn').click(function (){
            var date = new Date($(".subheading").text());
            $(".modal-title").text(date.getFullYear()+"년 \xa0"+(date.getMonth()+1)+"월 \xa0"+date.getDate()+"일");
            $("#scheduleDate").val(displayTime(date).toString());
        })
        //모달 초기화
        $('#insertSchedule').on('hidden.bs.modal', function (e) {
            $(this).find('form')[0].reset();
        });
        $('#modifySchedule').on('hidden.bs.modal', function (e) {
            $(this).find('form')[0].reset();
        });

        //스케쥴 추가
        $('#schedule_submit').click(function (){
            var queryString = $("form[name=scheduleAdd]").serialize() ;
            $.ajax({
                type:"post",
                url:"/ajax/schedule/add",
                data:queryString,
                success : function (res){
                    var schedule_time = res['schedule_time'];
                    var schedule_content = res['schedule_content'];
                    var schedule_id = res['id'];
                    var data = "";
                    data += "<li><input type='hidden' value="+schedule_id+">";
                    data += "<p style='cursor: pointer;'><span class='timeStrong'>"+timeChange(schedule_time)+"</span>";
                    data += "<br/>"+schedule_content+"</p></li>";

                    $('#calendar-events').append(data);
                    var countSection = document.querySelector('.primary-color span');
                    var count = countSection.textContent;
                    count++;
                    countSection.textContent = count;

                    $('#insertSchedule').find('form')[0].reset();
                    $('#insertSchedule').modal("hide"); //닫기
                    // $(".calendar-event").load(window.location.href + ".calendar-event");
                    // $("#calendar-events").load(window.location.href + "#calendar-events");
                },
                error : ()=>{}
            })
        });

        //스케쥴 하나 선택
        $("#calendar-events").on("click","li",function () {
            var sheduleID = $(this).find("input").val();
            $('#modifySchedule').modal("show");
            console.log("클릭되니???!!" + sheduleID);
            $.ajax({
                type:"post",
                url:"/ajax/schedule/read",
                data:{
                    sheduleID:sheduleID
                },
                success : function (res){
                    var scheduleVO = res['vo'];
                    console.log("타임 어케 들어오지 "+scheduleVO.schedule_time);
                    console.log("날짜 어케 들어오지 "+scheduleVO.schedule_date);
                    var scheduleDate = String(scheduleVO.schedule_date).split(',');
                    $(".modal-title-modify").text(scheduleDate[0]+"년 \xa0"+scheduleDate[1]+"월 \xa0"+scheduleDate[2]+"일");

                    var scheduleTime = String(scheduleVO.schedule_time).split(',');
                    console.log("글자수"+scheduleTime[0].length);
                    if(scheduleTime[0].length==1){
                        $("#hourSelect").val("0"+scheduleTime[0]).attr("selected", true);
                    }
                    else $("#hourSelect").val(scheduleTime[0]).attr("selected", true);
                    $("#minuteSelect").val(scheduleTime[1]).attr("selected", true);
                    $('#scheduleContent').text(scheduleVO.schedule_content);
                    $('#schedule_id').val(scheduleVO.schedule_id);
                },
                error : ()=>{}
            });
        });
        //스케쥴 수정
        $('#modify_submit').click(function () {
            var queryString = $("form[name=scheduleModify]").serialize();
            $.ajax({
                type: "post",
                url: "/ajax/schedule/modify",
                data: queryString,
                success: function (res) {
                    var success = res['success'];
                    console.log("수정됐나?"+success);
                    $('#modifySchedule').find('form')[0].reset();
                    $('#modifySchedule').modal("hide"); //닫기
                },
                error: () => {
                }
            });
        });
        //스케쥴 삭제
        $('#delete_submit').click(function () {
            var queryString = $("form[name=scheduleModify]").serialize();
            $.ajax({
                type: "post",
                url: "/ajax/schedule/delete",
                data: queryString,
                success: function (res) {
                    var success = res['success'];
                    console.log("삭제됐나?"+success);
                    $('#modifySchedule').find('form')[0].reset();
                    $('#modifySchedule').modal("hide"); //닫기
                },
                error: () => {
                }
            });
        });

    });

</script>

<%@ include file="../includes/footer.jsp" %>