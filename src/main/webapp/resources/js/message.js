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
                text = ""
                var list = data['list'];
                // console.log("message.js 에서 리스트 : "+list)
                const userId = data['userID'];
                // console.log("message.js 에서 userId : "+userId);
                for(var i=list.length-1; i >= 0; i--){
                    if(list[i].user_id == userId){
                        text += "<div class='d-flex flex-row-reverse' style='margin-top: 10px;padding-left: 0px;'>"
                        text += "<div class='p-2 remove_message' style='display: none'><img src='/resources/img/x-circle-fill.svg' value=':"+list[i].group_message_id+"'></div>"
                        // text += "<button class='remove_message btn' value='"+list[i].group_message_id+"'>삭제</button></div>"
                        text += "<div class='border rounded-3 p-2' style='padding-bottom: 7px;padding-top: 7px;background-color: #ff9000;color: white;'>"+list[i].group_message_content+"</div>"
                        text += "<div style='font-weight: lighter; text-align: left;color: #acacac;' class='align-self-end p-2'>"+list[i].group_message_mod_date[0]+"."+list[i].group_message_mod_date[1]+"."+list[i].group_message_mod_date[2]+"</div>"
                        text += "</div>"
                    }else{
                        text += "<div style='font-weight: lighter;padding-top: 8px; margin-left:10px;' id='groupMessageUserId'>"+list[i].user_id+"</div>";
                        text += "<div class='d-flex flex-row'>"
                        text += "<div class='p-2 border rounded-3' style='padding-bottom: 7px;padding-top: 7px;'>"+list[i].group_message_content+"</div>"
                        text += "<div style='text-align:end; font-weight: lighter;color: #acacac;' class='align-self-end p-2'>"+list[i].group_message_mod_date[0]+"."+list[i].group_message_mod_date[1]+"."+list[i].group_message_mod_date[2]+"</div></div>";
                    }
                    // text += "<div>"+list[i].group_message_content;
                    // text += "<button class='remove_message btn btn-outline-danger btn-sm' value='"+list[i].group_message_id+"'>삭제</button></div>"
                }
                callback(text,list.length);
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

    return {
        add:add,
        getList:getList,
        remove:remove
    };


})();