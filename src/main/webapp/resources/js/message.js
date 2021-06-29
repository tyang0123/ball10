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
                // console.log(data['list'])
                console.log(data['list'][0].group_message_mod_date)
                text = ""
                const list = data['list'];
                const userId = data['userID'];
                for(var i=list.length-1; i >= 0; i--){
                    if(list[i].user_id == userId){
                        text += "<div class='container' style='margin-top: 18px'><div class='row'>"
                        // text += "<button class='remove_message btn btn-outline-danger btn-sm' value='"+list[i].group_message_id+"'>삭제</button>"
                        text += "<div style='font-weight: lighter;font-size: 15px;' class='col-sm-4 align-self-center'>"+list[i].group_message_mod_date[0]+"."+list[i].group_message_mod_date[1]+"."+list[i].group_message_mod_date[2]+"</div>"
                        text += "<div class='col-sm-8 border rounded-3' style='padding-bottom: 7px;padding-top: 7px;'>"+list[i].group_message_content+"</div>"
                        text += "</div></div>"

                    }else{
                        text += "<div class='row row-cols-1'>"
                        text += "<div class='col' style='font-size : 15px;font-weight: lighter;padding-top: 8px;'>"+list[i].user_id+"</div>";
                        text += "<div class='col-sm-8 border rounded-3' style='padding-bottom: 7px;padding-top: 7px;'>"+list[i].group_message_content+"</div>"
                        text += "<div style='text-align:end; font-weight: lighter;font-size: 15px;' class='col-sm-4 align-self-center'>"+list[i].group_message_mod_date[0]+"."+list[i].group_message_mod_date[1]+"."+list[i].group_message_mod_date[2]+"</div></div>";
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

    return {
        add:add,
        getList:getList,
        remove:remove
    };


})();