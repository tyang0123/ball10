let timerID;
let timerIsPlay;
let accumulatedTimeStr;
let timerIsUseApple;
let fnAlarmTimerResetWhen3AM

let timerStartDateTime;

let cookieHour;
let cookieMinute;
let cookieSecond;

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
function getRemainSecondsFrom3AMPerSeconds(){
  let nowTime = new Date();
  let tomorrowDawn = new Date();

  if(nowTime.getHours()>3){
    tomorrowDawn.setDate(nowTime.getDate()+1);
  }
  tomorrowDawn.setHours(3, 0, 1, 0);
  // tomorrowDawn.setHours(23, 47, 1, 0);

  return Math.floor((tomorrowDawn-nowTime) / 1000);
}

// 초기 타이머 세팅
function timerNumberInit(myTimer, myTimerBtn, timerCookieStr, IsUseApple, fnAlarmTimerReset) {
  [timerID, timerIsPlay, accumulatedTimeStr] = timerCookieStr.split('-');
  timerIsUseApple = IsUseApple;
  fnAlarmTimerResetWhen3AM = fnAlarmTimerReset;
  const timeArray = accumulatedTimeStr.split(':');

  cookieHour = Number(timeArray[0]);
  cookieMinute = Number(timeArray[1]);
  cookieSecond = Number(timeArray[2]);

  hour = cookieHour;
  minute = cookieMinute;
  second = cookieSecond;

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

    const tempTime = new Date(Date.UTC(0,0,0, cookieHour, cookieMinute, cookieSecond, 0)).getTime();
    let diffTime = new Date(Date.now() - timerStartDateTime).getTime() + tempTime;
    diffTime = new Date(diffTime);


    hour = diffTime.getUTCHours();
    minute = diffTime.getUTCMinutes();
    second = diffTime.getUTCSeconds();


    hourScreen.html((hour < 10 ? '0' : '') + hour);
    minScreen.html((minute < 10 ? '0' : '') + minute);
    secScreen.html((second < 10 ? '0' : '') + second);

    if(getRemainSecondsFrom3AMPerSeconds()<1) {  //200
      timerStop(function (){ // 이 콜백함수를 user.jsp에서 선언해서 init에서 함수 저장후 여기에 파라미터값으로 지정해야함
        // alert("타이머가 리셋되었습니다.")
        // location.reload();
        $("#modifySuccess").modal("show");
        $("#modifySuccess h4").html("공부기록 새로 시작")
        $("#modifySuccess .modal-body").html("새벽 3시가 넘었어요. <br> 어제부터 시작한 공부시간이 저장되고 새로운 공부시간이 시작됩니다. :)");
        $("#modifySuccess button").on("click", function (e){
          location.reload();
        });
      });
    }
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
      if(resultFunc != null){
        resultFunc(timerID+"-"+timerIsPlay+"-"+accumulatedTimeStr);
        timerStartDateTime = Date.now();
        [ cookieHour, cookieMinute, cookieSecond ]= accumulatedTimeStr.split(':').map(i=>Number(i));
        // console.log(cookieHour, cookieMinute, cookieSecond);
      }
    },
    error: function(xhr, status, er){
      clearInterval(timerIntervalID);
      if(timerIsPlay == 1){
        viewTimerStartInterval();
      }
      if(resultFunc != null){
        resultFunc(timerID+"-"+timerIsPlay+"-"+accumulatedTimeStr);
        timerStartDateTime = Date.now();
        [ cookieHour, cookieMinute, cookieSecond ]= accumulatedTimeStr.split(':').map(i=>Number(i));
      }
      console.log("error : "+er);
    }
  });//end ajax
}


const timerStart = function(resultFunc) {

  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();
  timerIsPlay = 1;
  const data = {
    'accumulatedTime' : accumulatedTimeStr,
    'timerIsPlay': timerIsPlay,
    'timerIsOnSite' : 1,
    'timerIsUseApple': timerIsUseApple
  };
  //DB에 상태를 play상태를 업데이트 하면 timer시작
  saveTimerToDB(data, resultFunc);

  timerStartDateTime = Date.now();
}


const timerStop = function (resultFunc) {
  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();//타이머시간->string변환
  timerIsPlay = "0";
  const data = {
    'accumulatedTime' : accumulatedTimeStr,
    'timerIsPlay': timerIsPlay,
    'timerIsOnSite' : 1,
    'timerIsUseApple': timerIsUseApple
  };
  saveTimerToDB(data, resultFunc);
};//end timerStop

const timerSaveBeforeUnloadPage= function () {
  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();//타이머시간->string변환
  const data = {
    'accumulatedTime' : accumulatedTimeStr,
    'timerIsPlay': timerIsPlay,
    'timerIsOnSite' : 0,
    'timerIsUseApple': timerIsUseApple
  };
  saveTimerToDB(data, null);
};

const timerSaveForAppleUserPeriodically = function () {
  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();//타이머시간->string변환
  const data = {
    'accumulatedTime' : accumulatedTimeStr,
    'timerIsPlay': timerIsPlay,
    'timerIsOnSite' : 1,
    'timerIsUseApple': timerIsUseApple
  };
  $.ajax({
    type: "PUT",
    url: "/ajax/timer/"+timerID,
    data : JSON.stringify(data),
    contentType: "application/json; charset=UTF-8;",
    success: function(result, status, xhr){
      console.log("success")
    },
    error: function(xhr, status, er){
      console.log("error : "+er);
    }
  });//end ajax
}

const getDateStringToNextMorning3AM = function (){
  let date = new Date()
  date.setSeconds(date.getSeconds() + getRemainSecondsFrom3AMPerSeconds());
  return date.toGMTString();
}

const getPresentTimerStatus = function (){
  accumulatedTimeStr = setAccumulatedTimeStrFromHHMMSS();//타이머시간->string변환
  return timerID+"-"+timerIsPlay+"-"+accumulatedTimeStr;
}
