<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.css">
<script type='text/javascript' src='https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.min.js'></script>
<script type='text/javascript' src='https://uicdn.toast.com/tui.chart/latest/raphael.js'></script>
<script src="https://uicdn.toast.com/tui.chart/latest/tui-chart.min.js"></script>





<div class="row">
    <div class="col-12">
        <div id='chart-area'></div>
    </div>
</div>

<button>btn</button>
<script type="text/javascript">
    var container = document.getElementById('chart-area');


    $("button").click(function(e){
        const criDate = new Date(2021,6-1,28);
        const year =  criDate.getFullYear();
        const month = criDate.getMonth()+1;
        const day = criDate.getDate();
        var data = { 'date' : year+"-"+(month < 10 ? '0' : '') + month+"-"+(day < 10 ? '0' : '') + day};
        $.ajax({
            type: "GET",
            url: "/ajax/timer/getseconds",
            data : data,
            success: function(result, status, xhr){
                result.forEach(i=>{
                    console.log(i.week)
                })
                const weekArr = ["월", "화", "수", "목", "금", "토", "일"];
                let categories = [];
                let dataList=[];
                weekArr.forEach((value, index)=>{
                    const timeData = result.find(data => Number(data.week) === index);
                    if(timeData == null){
                        dataList.push(0);
                    }else{
                        dataList.push(Math.floor(timeData.time/12)/100);
                        // dataList.push(timeData)
                    }
                    const pushDate = new Date(year, month-1, day)
                    pushDate.setDate(pushDate.getDate()+index)
                    const pushMonth = pushDate.getMonth()+1;
                    const pushDay = pushDate.getDay();
                    categories.push((pushMonth < 10 ? '0' : '') + pushMonth+"-"+(pushDay < 10 ? '0' : '') + pushDay+" "+value)
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
                tui.chart.columnChart(container, chartData, options)
            },
            error: function(xhr, status, er){
                console.log("error : "+er);
            }
        });//end ajax

    })

</script>

