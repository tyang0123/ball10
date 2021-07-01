<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.css">
<script type='text/javascript' src='https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.min.js'></script>
<script type='text/javascript' src='https://uicdn.toast.com/tui.chart/latest/raphael.js'></script>
<script src="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.js"></script>





<div class="row">
    <div class="col-12">
        <div id='chart-area'></div>
    </div>
</div>

<script type="text/javascript">
    var container = document.getElementById('chart-area');
    var data = {
        categories: ["월", "화", "수", "목", "금", "토", "일"],
        series: [
            {
                name: '일주일간의 공부량',
                data: [380595, 472893, 724408, 829149, 853032, 812687, 548381],
            }
        ]
    };
    var options = {
        chart: {
            width: 1160,
            height: 540,
            title: 'Monthly Revenue',
        },
        yAxis: {
            title: 'Weekend'
        },
        xAxis: {
            title: 'Month'
        },
        series: {
            stackType: 'normal'
        }
    };


    tui.chart.columnChart(container, data, options);
</script>


<%@ include file="../includes/footer.jsp" %>