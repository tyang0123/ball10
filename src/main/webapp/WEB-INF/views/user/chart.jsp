<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="row">
    <div class="chart-container col-12 col-sm-10 offset-sm-1">
        <canvas id="myChart"></canvas>
    </div>
</div>
<style>

</style>
<script type="text/javascript">
    $(document).ready(function () {
        var myChart;
        var ctx = document.getElementById('myChart').getContext('2d');
        var options = {
            parsing: {
                xAxisKey: 'tip',
                yAxisKey: 'value'
            },
            scales: {
                y: {
                    suggestedMin: 0,
                    suggestedMax: 8
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const secondsNumber = context.dataset.data[context.parsed.x].tip;
                            var hours   = Math.floor(secondsNumber / 3600);
                            var minutes = Math.floor((secondsNumber - (hours * 3600)) / 60);
                            var seconds = secondsNumber - (hours * 3600) - (minutes * 60);

                            if (hours   < 10) {hours   = "0"+hours;}
                            if (minutes < 10) {minutes = "0"+minutes;}
                            if (seconds < 10) {seconds = "0"+seconds;}

                            return hours+':'+minutes+':'+seconds;
                            // console.log(context.dataset.data[context.parsed.x].tip)
                            // return context.dataset.data[0];
                        },
                    }
                }
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
                            dataList.push({"value": 0, "tip": 0});
                        } else {
                            dataList.push({"value": Math.floor(timeData.time / 36) / 100, "tip":timeData.time}) ;
                            console.log(timeData.time)
                        }
                        //카테고리 날짜 + 요일
                        const pushDate = new Date(Number(baseMonday.substring(0,4)), Number(baseMonday.substring(5,7)) - 1, Number(baseMonday.substring(8,10)))
                        pushDate.setDate(pushDate.getDate() + index)
                        const pushMonth = pushDate.getMonth() + 1;
                        const pushDay = pushDate.getDate();
                        categories.push((pushMonth < 10 ? '0' : '') + pushMonth + "-" + (pushDay < 10 ? '0' : '') + pushDay + " " + value)
                    })
                    // console.log(categories, dataList);

                    if(myChart != null){ myChart.destroy()}
                    myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            datasets: [{
                                label: '하루 공부시간',
                                data: dataList, // [{value: seconds/1200, tip: seconds}]
                                backgroundColor: ['rgba(255, 255, 102, 0.7)']
                            }],
                            labels: categories
                        },
                        options: options
                    });
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
