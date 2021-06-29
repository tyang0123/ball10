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
                // window.location.reload();
                callback(result)
            },
            error:(log)=>{alert("실패"+log)}
        });
    }

    function getList(group_id,limit,callback){
        $.ajax({
            url:'/group/read/ajax/list/?group_id='+group_id,
            type:'GET',
            data:{
                limit:limit
            },
            dataType: "json",
            success:function (data){
                console.log(data['list'])
                text = ""
                const list = data['list'];
                const userId = data['userID'];
                for(var i=list.length-1; i >= 0; i--){
                    if(list[i].user_id == userId){
                        text += "<padding><div align='right'>"
                        text += "<button class='remove_message btn btn-outline-danger btn-sm' value='"+list[i].group_message_id+"'>삭제</button>"
                        text += list[i].group_message_content+"</div></padding>"

                    }else{
                        text += "<div class='row row-cols-1'>"
                        text += "<div class='col' style='font-size : 15px;font-weight: lighter;'>"+list[i].user_id+"</div>";
                        text += "<div class='col-sm-8 border rounded-3' style='padding-bottom: 7px;padding-top: 7px;'>"+list[i].group_message_content+"</div><div class='col-sm-4'></div></div>";
                    }
                    // text += "<div>"+list[i].group_message_content;
                    // text += "<button class='remove_message btn btn-outline-danger btn-sm' value='"+list[i].group_message_id+"'>삭제</button></div>"
                }
                callback(text)
            },
            error: (log)=>{alert(log)}
        });
    }

    function remove(group_message_id,callback){
        $.ajax({
            type : 'delete',
            url : '/group/read/ajax/delete/?group_message_id='+group_message_id,
            success:function (deleteResult,status,xhr){
                if(callback){
                    callback(deleteResult);
                }
            },
            error:(log)=>{alert(log)}
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