const init = {
    monList: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    dayList: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
    today: new Date(),
    monForChange: new Date().getMonth(),
    yearForChange: new Date().getFullYear(),
    activeDate: new Date(),
    getFirstDay: (yy, mm) => new Date(yy, mm, 1),
    getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
    nextMonth: function () {
        let d = new Date();
        d.setDate(1);
        d.setMonth(++this.monForChange);
        this.activeDate = d;
        return d;
    },
    prevMonth: function () {
        let d = new Date();
        d.setDate(1);
        d.setMonth(--this.monForChange);
        this.activeDate = d;
        return d;
    },
    addZero: (num) => (num < 10) ? '0' + num : num,
    activeDTag: null,
    getIndex: function (node) {
        let index = 0;
        while (node = node.previousElementSibling) {
            index++;
        }
        return index;
    }
};

const $calBody = document.querySelector('.dateSection');


const displayTime = (timeValue)=>{
    let dateObj = new Date(timeValue);
    let yy= dateObj.getFullYear();
    let mm= dateObj.getMonth() +1; //getMonth는 0부터 시작
    let dd = dateObj.getDate();
    return [ yy,'-',(mm>9?'':'0')+mm,'-',(dd>9?'':'0')+dd].join('');
};


let scheduleMonthListCount = new Map();
const scheduleCount = (date)=>{
    let getMonth = new Date(date.getFullYear(),date.getMonth());
    $.ajax({
        type:"post",
        url:"/ajax/schedule/count",
        async:false,
        data:{
            date:displayTime(getMonth).toString(),
        },
        success : function (res){
            let changeMonth = res['list'];
            $.each(changeMonth , function(idx, val) {
                scheduleMonthListCount.set(val.schedule_day,val.schedule_count);
            });
        },
        error : ()=>{}
    })
}


function loadDate (day, month, week,date) {
    let weekarray = ['1st','2nd','3rd','4th','5th','6th'];
    document.querySelector('.subheading').textContent = date;
    document.querySelector('.cal-day').textContent = init.dayList[day]+",";
    document.querySelector('.cal-month').textContent = init.monList[month]+" "+weekarray[(week-1)];
}
////////chartFunction
let fnCallChart;
const setFnCallChart = function (fn){
    fnCallChart = fn;
}

function loadYYMM (fullDate) {
    scheduleCount(fullDate);

    let yy = fullDate.getFullYear();
    let mm = fullDate.getMonth();
    let firstDay = init.getFirstDay(yy, mm,1);
    let lastDay = init.getLastDay(yy, mm,0);


    //전월,익월 데이터
    const prevDate = new Date(firstDay);
    const nextDate = new Date(lastDay);
    const PLDay = prevDate.getDay();
    const NLDay = nextDate.getDay();

    const prevDates = [];
    const nextDates = [];

    if (PLDay !== 5) {
        for (let i = 0; i < PLDay; i++) {
            let yesterday = new Date(prevDate.setDate(prevDate.getDate() - 1));
            prevDates.unshift(yesterday);
        }
    }

    console.log("이전달력 데이터"+prevDates);
    for (let i = 1; i < 7 - NLDay; i++) {
        let tomorrow = new Date(nextDate.setDate(nextDate.getDate() + 1));	// 내일
        nextDates.push(tomorrow);
    }
    const notThis = prevDates.concat(nextDates);



    if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
        markToday = init.today.getDate();
    }

    document.querySelector('.calendar-header h2 strong').textContent = init.monList[mm];
    document.querySelector('.calendar-header h2 span').textContent = yy;


    let calendarData = '';
    let startCount;
    let countDay = 0;
    let countIn = 0;
    for (let i = 0; i < 6; i++) {
        calendarData += '<section class="calendar-row">';
        for (let j = 0; j < 7; j++) {
            const weekend = (j==0 || j==6)
                ? 'weekend'
                : '';

            if (i === 0 && !startCount && j === firstDay.getDay()) {
                startCount = 1;
            }
            let fullDate = yy + '-' + init.addZero(mm + 1) + '-' + init.addZero(countDay + 1);

            if (!startCount) {
                calendarData += `<div class="calendar-day ${weekend} inactive" data-fdate="${displayTime(notThis[countIn])}"><input type="hidden" name="count" value="${displayTime(notThis[countIn])}"><span class="calendar-date">${notThis[countIn].getDate()}`;
                countIn++;
            } else {
                calendarData += `<div class="calendar-day ${weekend}`;
                calendarData += (markToday && markToday === countDay + 1) ? ' active"><span class="calendar-date" ' : '"';
                calendarData += ` data-date="${countDay + 1}" data-fdate="${fullDate}"><input type="hidden" name="count" value="${fullDate}"><span class="calendar-date">`;
            }

            calendarData += (startCount) ? ++countDay : '';
            calendarData += (startCount) ? (scheduleMonthListCount.get(countDay)>0) ? `</span><br/><span class="calendar-event">${scheduleMonthListCount.get(countDay)}</span>`:'</span>':'</span>';
            if (countDay === lastDay.getDate()) {
                startCount = 0;
            }

            calendarData += '</div>';

        }
       calendarData += '</section>';
        if(startCount == 0) break;
    }
    $calBody.innerHTML = calendarData;
    scheduleMonthListCount.clear();

    //chart
    try {
        fnCallChart(firstDay.getDay()===0? firstDay: prevDates[0]);
    } catch(e) {
        console.log(e)
    }
}

loadYYMM(init.today);
loadDate(init.today.getDay(), init.today.getMonth(),getWeekNo(init.today.toDateString()),init.today.toDateString());
scheduleList(init.today);

function getWeekNo(v_date_str) {
    let date = new Date();
    if(v_date_str){
        date = new Date(v_date_str);
    }
    return Math.ceil(date.getDate() / 7);
}

const goToday = () => {
    location.reload();
}

$calBody.addEventListener('click', (e) => {
    if (e.target.classList.contains('calendar-day')) {
        if (init.activeDTag) {
            init.activeDTag.classList.remove('day-active');
        }
        let day = new Date(e.target.dataset.fdate);
        loadDate(day.getDay(), day.getMonth(), getWeekNo(day),day.toDateString());
        scheduleList(day);
        if(!e.target.classList.contains('active')){
            e.target.classList.add('day-active');
            init.activeDTag = e.target;
            init.activeDate.setDate(day);
        }
        else{ goToday();}
    }
});

function scheduleList(date){
    $.ajax({
        type:"post",
        url:"/ajax/schedule/list",
        data:{
            date:displayTime(date).toString(),
        },
        success : function (res){
            let list = res['list'];
            let count = list.length;
            let data = "";

            for (let i = 0; i < list.length; i++) {
                const checkValue = (list[i].schedule_checked==1)
                    ? "checked='checked'"
                    : '';
                const checkLine = (list[i].schedule_checked==1)
                    ? "style='text-decoration:line-through;'"
                    : '';
                data += `<li ${checkLine}><input type="hidden" value=${list[i].schedule_id}>`;
                data += `<p style='cursor: pointer;'><span class="timeStrong">${timeChange(String(list[i].schedule_time))}</span><br/>`;
                data += `${list[i].schedule_content}</p></li>`;
                data += `<div class="form-check" style="font-size: 13px; margin-top: -13px;margin-bottom: 15px;">`;
                data += `<label><input class="form-check-input" ${checkValue} type="checkbox" name="todo" value=${list[i].schedule_checked}>&nbsp;check</label></div>`;

            }
            document.querySelector('#calendar-events').innerHTML = data;
            document.querySelector('.primary-color span').textContent = count;
        },
        error : ()=>{}
    })
}

const timeChange = (time)=>{
    let arrayTime = time.split(',');
    let hour = Number(arrayTime[0]);
    let minute = arrayTime[1];
    if(hour<12) return hour+':'+minute+" AM";
    else {
        if (hour==12) return hour+':'+minute+" PM";
        return (hour-12)+':'+minute+" PM";
    }
}

function todoCheck(scheduleID){
    $.ajax({
        type:"post",
        url:"/ajax/schedule/todo",
        data:{
            scheduleID:scheduleID,
        },
        success : function (res){
        },
        error : ()=>{}
    })
}



