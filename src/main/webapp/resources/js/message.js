console.log("Message Module......");
var messageService = (function (){

    function add(group_id,message, callback){
        console.log("add message ... ");
        $.ajax({
            url :'/group/read/ajax/new/?group_id='+group_id,
            type:'POST',
            data : JSON.stringify(message),
            contentType : "application/json; charset=utf-8",
            success : function(result){
                callback(result)
            },
            error:(log)=>{alert("실패"+log)}
        });
    }

    function getList(group_id,criterionNumber,callback){
        $.ajax({
            url:'/group/read/ajax/list/?group_id='+group_id,
            type:'GET',
            data:{
                criterionNumber:criterionNumber
            },
            dataType: "json",
            success:function (data){
                console.log(data['list'])
                text = ""
                const list = data['list'];
                for(var i=0; i<list.length; i++){
                    text += "<div>"+list[i].group_message_content;
                    text += "<button class='remove_message btn btn-outline-danger btn-sm' value='"+list[i].group_message_id+"'>삭제</button></div>"
                }
                callback(text)
            },
            error: (log)=>{alert(log)}
        });
    }

    function remove(group_message_id,callback,error){
        $.ajax({
            type : 'delete',
            url : '/group/read/ajax/delete/?group_message_id='+group_message_id,
            success:function (deleteResult,status,xhr){
                if(callback){
                    callback(deleteResult);
                }
            },
            error:function (xhr,status,er){
                if(error){
                    error(er);
                }
            }
        });
    }

    const displayTime = (timeValue)=>{
        var today = new Date();
        var gap = today.getTime() - timeValue;
        var dateObj = new Date(timeValue);
        if(gap<(1000*60*60*24)){ //시분초  1milli second
            var hh =dateObj.getHours();
            var mi =dateObj.getMinutes();
            var ss =dateObj.getSeconds();
            return [ (hh>9?'':'0') +hh, ':',(mi>9?'':'0')+mi,':',(ss>9?'':'0')+ss].join('');
        }  else {//년월일
            var yy= dateObj.getFullYear();
            var mm= dateObj.getMonth() +1; //getMonth는 0부터 시작
            var dd = dateObj.getDate();
            return [ yy,'/',(mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd].join('');
        }
    }

    return {
        add:add,
        getList:getList,
        remove:remove
    };


})();