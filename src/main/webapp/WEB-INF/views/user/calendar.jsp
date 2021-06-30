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
                    <p class="subheading">Today</p>
                    <!-- <div class="cal-day"></div>
                    <div class="cal-date"></div> -->
                    <h1><span class="cal-day"></span><br/><span class="cal-month"></span></h1>
                    <p class="primary-color"><span>4</span> Items</p>
                    <ul class="calendar-events">
                        <li>
                            <p><span class="timeStrong">8:00 AM</span><br/>
                                Team Meeting</p>
                        </li>

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


<!-- 수정 Modal -->
<div class="modal fade" id="insertSchedule">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 1px solid black;height: 80px;">
                <h4 class="modal-title" style="margin-left: 30px;"></h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                회원님의 정보가 수정되었습니다. 🤗 📝
            </div>
            <div class="modal-footer" style="border-color:black;">
                <button style="width: 150px;" type="button" class="button-add-custom">확 인</button>
                <button style="width: 150px;" type="button" class="button-add-custom" data-bs-dismiss="modal">취 소</button>
            </div>
        </div>
    </div>
</div>


<script src="/resources/js/calendar.js"></script>
<script>
    $(document).ready(function (){
        //모달테스트
        $('.calendar-btn').click(function (){
            var date = new Date($(".subheading").text());
            console.log(date);
            $(".modal-title").text(date.getFullYear()+"년 "+(date.getMonth()+1)+"월 "+date.getDate()+"일");

        })


    });
</script>
<%@ include file="../includes/footer.jsp" %>