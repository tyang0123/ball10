var timerID;
var timerIsPlay;
var accumulatedTimeStr;

var hour;
var minute;
var second;

var hourScreen;
var minScreen;
var secScreen;

var timerIntervalID;

function setAccumulatedTimeStrFromHHMMSS(){
  accumulatedTimeStr = (hour < 10 ? '0' : '') + hour + ":"
      + (minute < 10 ? '0' : '') + minute +":"+(second < 10 ? '0' : '')+ second;
}

function getRemainSecondsFrom3AM(){
  var nowTime = new Date();
  var tomorrowDawn = new Date();

  if(nowTime.getHours()>3){
    tomorrowDawn.setDate(nowTime.getDate()+1);
  }
  tomorrowDawn.setHours(3, 0, 1, 0);

  return Math.floor((tomorrowDawn-nowTime) / 1000);
}

// 초기 타이머 세팅
function timerNumberInit(myTimer, myTimerBtn, timerCookieStr) {
  [timerID, timerIsPlay, accumulatedTimeStr] = timerCookieStr.split('-');
  var timeArray = accumulatedTimeStr.split(':');
  hour = Number(timeArray[0]);
  minute = Number(timeArray[1]);
  second = Number(timeArray[2]);

  hourScreen = $(myTimer).find('.timer-hours');
  minScreen = $(myTimer).find('.timer-min');
  secScreen = $(myTimer).find('.timer-sec');

  hourScreen.html((hour < 10 ? '0' : '') + hour);
  minScreen.html((minute < 10 ? '0' : '') + minute);
  secScreen.html((second < 10 ? '0' : '') + second);

  console.log("timerIsPlay",timerIsPlay)
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

var timerStart = function(resultFunc) {
  setAccumulatedTimeStrFromHHMMSS();//타이머시간-> accumulatedTimeStr string변환
  //DB에 상태를 play상태를 업데이트 하면 timer시작
  $.ajax({
    type: "PUT",
    url: "/ajax/timer/putstart/"+timerID,
    success: function(result, status, xhr){
      console.log("success")
      clearInterval(timerIntervalID);
      viewTimerStartInterval();
      if(resultFunc != null){
        resultFunc(timerID+"-1-"+accumulatedTimeStr);
      }
    },
    error: function(xhr, status, er){
      clearInterval(timerIntervalID);
      viewTimerStartInterval();
      alert("error : "+er)
    }
  });//end ajax
}
var timerStop = function (resultFunc) {
  setAccumulatedTimeStrFromHHMMSS();//타이머시간-> accumulatedTimeStr string변환

  $.ajax({
    type: "PUT",
    url: "/ajax/timer/putstop/"+timerID,
    data : accumulatedTimeStr,
    contentType: "application/json; charset=UTF-8;",
    success: function(result, status, xhr){
      clearInterval(timerIntervalID);
      if(resultFunc !=null){
        resultFunc(timerID+"-0-"+accumulatedTimeStr);
      }
    },
    error: function(xhr, status, er){
      clearInterval(timerIntervalID);
      alert("error : "+er)
    }
  });//end ajax
};//end timerStop
