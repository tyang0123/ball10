let timerID;
let timerIsPlay;
let accumulatedTimeStr;

let hour;
let minute;
let second;

let hourScreen;
let minScreen;
let secScreen;

let timerIntervalID;

function setAccumulatedTimeStrFromHHMMSS(){
  return (hour < 10 ? '0' : '') + hour + ":"
      + (minute < 10 ? '0' : '') + minute +":"+(second < 10 ? '0' : '')+ second;
}
function getRemainSecondsFrom3AM(){
  let nowTime = new Date();
  let tomorrowDawn = new Date();

  if(nowTime.getHours()>3){
    tomorrowDawn.setDate(nowTime.getDate()+1);
  }
  tomorrowDawn.setHours(3, 0, 1, 0);

  return Math.floor((tomorrowDawn-nowTime) / 1000);
}

// 초기 타이머 세팅
function timerNumberInit(myTimer, myTimerBtn, timerCookieStr) {
  [timerID, timerIsPlay, accumulatedTimeStr] = timerCookieStr.split('-');
  const timeArray = accumulatedTimeStr.split(':');
  hour = Number(timeArray[0]);
  minute = Number(timeArray[1]);
  second = Number(timeArray[2]);

  hourScreen = $(myTimer).find('.timer-hours');
  minScreen = $(myTimer).find('.timer-min');
  secScreen = $(myTimer).find('.timer-sec');

  hourScreen.html((hour < 10 ? '0' : '') + hour);
  minScreen.html((minute < 10 ? '0' : '') + minute);
  secScreen.html((second < 10 ? '0' : '') + second);

  if(timerIsPlay==="1"){
    //타이머가 play상태이면 click이벤트 발생으로 timer start를 해준다
    myTimerBtn.trigger("click");
  }
}


function viewTimerStartInterval(){
  timerIntervalID = setInterval(function () {
    second = second + 1;
    if (second >= 60) {
      minute = minute + 1;
      second = 0;
    }
    if (minute >= 60) {
      hour = hour + 1;
      minute = 0;
    }
    hourScreen.html((hour < 10 ? '0' : '') + hour);
    minScreen.html((minute < 10 ? '0' : '') + minute);
    secScreen.html((second < 10 ? '0' : '') + second);

    if(getRemainSecondsFrom3AM()<2000) {
      timerStop();
      ////////////////////////////////////////////////////////////////////////////////페이지 리셋 및 user 페이지 이동해야함
    }
  }, 1000);
}

function viewTimerStartInterval(){
  timerIntervalID = setInterval(function () {
    second = second + 1;
    if (second >= 60) {
      minute = minute + 1;
      second = 0;
    }
    if (minute >= 60) {
      hour = hour + 1;
      minute = 0;
    }
    hourScreen.html((hour < 10 ? '0' : '') + hour);
    minScreen.html((minute < 10 ? '0' : '') + minute);
    secScreen.html((second < 10 ? '0' : '') + second);
  }, 1000);
}

const saveTimerToDB = function(data, resultFunc){
  $.ajax({
    type: "PUT",
    url: "/ajax/timer/"+timerID,
    data : JSON.stringify(data),
    contentType: "application/json; charset=UTF-8;",
    success: function(result, status, xhr){
      console.log("success")
      clearInterval(timerIntervalID);
      if(timerIsPlay == 1){
        viewTimerStartInterval();
      }
      resultFunc(timerID+"-"+timerIsPlay+"-"+accumulatedTimeStr);
    },
    error: function(xhr, status, er){
      clearInterval(timerIntervalID);
      if(timerIsPlay == 1){
        viewTimerStartInterval();
      }
      resultFunc(timerID+"-"+timerIsPlay+"-"+accumulatedTimeStr);
      alert("error : "+er)
    }
  });//end ajax
}


const timerStart = function(resultFunc) {
  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();
  timerIsPlay = 1;
  const data = {
    'accumulatedTime' : accumulatedTimeStr,
    'timerIsPlay': timerIsPlay,
    'timerIsOnSite' : 1
  };
  //DB에 상태를 play상태를 업데이트 하면 timer시작
  saveTimerToDB(data, resultFunc);
}


const timerStop = function (resultFunc) {
  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();//타이머시간->string변환
  timerIsPlay = "0";
  const data = {
    'accumulatedTime' : accumulatedTimeStr,
    'timerIsPlay': timerIsPlay,
    'timerIsOnSite' : 1
  };
  saveTimerToDB(data, resultFunc);
};//end timerStop

const timerSaveBeforeUnloadPage= function (resultFunc) {
  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();//타이머시간->string변환
  const data = {
    'accumulatedTime' : accumulatedTimeStr,
    'timerIsPlay': timerIsPlay,
    'timerIsOnSite' : 0
  };
  saveTimerToDB(data, resultFunc);
};