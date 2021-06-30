const init = {
    monList: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    dayList: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
    today: new Date(),
    monForChange: new Date().getMonth(),
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

function loadDate (day, month, week,date) {
    var weekarray = ['1st','2nd','3rd','4th','5th','6th'];
    document.querySelector('.subheading').textContent = date;
    document.querySelector('.cal-day').textContent = init.dayList[day]+",";
    document.querySelector('.cal-month').textContent = init.monList[month]+" "+weekarray[(week-1)];
}

function loadYYMM (fullDate) {
    let yy = fullDate.getFullYear();
    let mm = fullDate.getMonth();
    let firstDay = init.getFirstDay(yy, mm);
    let lastDay = init.getLastDay(yy, mm);
    let markToday;  // for marking today date


    //전월,익월 데이터
    const prevDate = new Date(firstDay);
    const nextDate = new Date(lastDay);
    const PLDay = prevDate.getDay();
    const NLDay = nextDate.getDay();

    const prevDates = [];
    const nextDates = [];

    if (PLDay !== 6) {
        for (let i = 0; i < PLDay; i++) {
            var yesterday = new Date(prevDate.setDate(prevDate.getDate() - 1));
            prevDates.unshift(yesterday);
        }
    }
    for (let i = 1; i < 7 - NLDay; i++) {
        var tomorrow = new Date(nextDate.setDate(nextDate.getDate() + 1));	// 내일
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
            if (!startCount) {
                calendarData += `<div class="calendar-day ${weekend} inactive" data-fdate="${notThis[countIn].toDateString()}"><span class="calendar-date">${notThis[countIn].getDate()}`
                countIn++;
            } else {
                let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
                calendarData += `<div class="calendar-day ${weekend}`;
                calendarData += (markToday && markToday === countDay + 1) ? ' active"><span class="calendar-date" ' : '"';
                calendarData += ` data-date="${countDay + 1}" data-fdate="${fullDate}"><span class="calendar-date">`;
            }
            calendarData += (startCount) ? ++countDay : '';
            if (countDay === lastDay.getDate()) {
                startCount = 0;
            }
            calendarData += '</span></div>';
        }
        calendarData += '</section>';
        if(startCount == 0) break;
    }
    $calBody.innerHTML = calendarData;
}

loadYYMM(init.today);
loadDate(init.today.getDay(), init.today.getMonth(),getWeekNo(init.today.toDateString()),init.today.toDateString());

function getWeekNo(v_date_str) {
    var date = new Date();
    if(v_date_str){
        date = new Date(v_date_str);
    }
    return Math.ceil(date.getDate() / 7);
}

const goToday = () => {
    date = new Date();
    loadDate(date.getDay(), date.getMonth(),getWeekNo(date.toDateString()),date.toDateString());
    loadYYMM(date);
}

$calBody.addEventListener('click', (e) => {
    if (e.target.classList.contains('calendar-day')) {
        if (init.activeDTag) {
            init.activeDTag.classList.remove('day-active');
        }
        let day = new Date(e.target.dataset.fdate);
        loadDate(day.getDay(), day.getMonth(), getWeekNo(day),day.toDateString());
        if(!e.target.classList.contains('active')){
            e.target.classList.add('day-active');
            init.activeDTag = e.target;
            init.activeDate.setDate(day);
        }
        else{ goToday();}
    }
});