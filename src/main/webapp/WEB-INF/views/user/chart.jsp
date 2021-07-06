<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.css">
<script type='text/javascript' src='https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.min.js'></script>
<script type='text/javascript' src='https://uicdn.toast.com/tui.chart/latest/raphael.js'></script>
<script src="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.js"></script>



<link
        rel="stylesheet"
        href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css"
/>
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>


<div class="row">
    <div class="col-12">
        <div id='chart-area'></div>
        <div id='chart-temp'></div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var container = document.getElementById('chart-area');
        var options = {
            chart: {
                width: 1160,
                height: 540,
            },
            yAxis: {
                title: 'Weekend',
                scale: {
                    min: 0,
                    max: 15
                },
            },
            xAxis: {
                title: 'Month'
            },
            series: {
                stackType: 'normal',
            },
            legend: {
                visible: false
            }
        };

        function callChart(baseMonday) {
            var data = {'date': baseMonday};
            $.ajax({
                type: "GET",
                url: "/ajax/timer/getseconds",
                data: data,
                success: function (result, status, xhr) {
                    const weekArr = ["일", "월", "화", "수", "목", "금", "토"];
                    let categories = [];
                    let dataList = [];
                    weekArr.forEach((value, index) => {
                        const timeData = result.find(data => Number(data.week) === (index+1));
                        if (timeData == null) {
                            dataList.push(0);
                        } else {
                            dataList.push(Math.floor(timeData.time / 12) / 100);
                            // dataList.push(timeData)
                        }
                        const pushDate = new Date(Number(baseMonday.substring(0,4)), Number(baseMonday.substring(5,7)) - 1, Number(baseMonday.substring(8,10)))
                        pushDate.setDate(pushDate.getDate() + index)
                        const pushMonth = pushDate.getMonth() + 1;
                        const pushDay = pushDate.getDate();
                        categories.push((pushMonth < 10 ? '0' : '') + pushMonth + "-" + (pushDay < 10 ? '0' : '') + pushDay + " " + value)
                    })
                    console.log(categories, dataList);

                    var chartData = {
                        categories: categories,
                        series: [
                            {
                                name: '공부시간',
                                data: dataList,
                            }
                        ]
                    };

                    $("#chart-area").empty();
                    tui.chart.columnChart(container, chartData, options);
                    $(".tui-chart-chartExportMenu-button").hide();
                },
                error: function (xhr, status, er) {
                    console.log("error : " + er);
                }
            });//end ajax
        }// end fn callChart

        function getSunday(base) {
            var d = new Date(base);
            var day = d.getDay(),
                diff = d.getDate() - day;
            var monday = new Date(d.setDate(diff));
            var month = monday.getMonth()+1;
            var day = monday.getDate()
            return monday.getFullYear()+"-"+( month< 10 ? '0' : '') + month + "-" + (day < 10 ? '0' : '') + day;
        }

        callChart(getSunday(Date.now()));
        setFnCallChart(function (date){
            callChart(getSunday(date))
        });
        var date;
        $(".dateSection").on("click", ".calendar-row", function (e) {
            var newDate = $(this).children().first().data("fdate");
            if(newDate == undefined){ // 선택된 날짜이면 그 밑의 자식이 date정보를 가지고 있음.
                console.log(newDate, "if")
                newDate = $(this).children().first().children().first().data("fdate");
            }
            if(newDate != date){
                date = newDate
                console.log(date);
                callChart(date);
            }
        })
    });

</script>
