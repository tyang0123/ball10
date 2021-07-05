console.log("Notice Module ........ ");
var noticeService = (function (){

    //공지추가
    function add(notice,callback){
        console.log("add notice .... ");
        $.ajax({
            url:'/ajax/notice/add',
            type:'POST',
            data : JSON.stringify(notice),
            contentType : "application/json; charset = utf-8",
            success : function (result){
                callback(result)
            },
            error:(log)=>{alert("실패"+log)}
        });
    }
    function modify(notice, notice_id, callback){
        console.log("공지가 수정이 되나")
        $.ajax({
            url:'/ajax/notice/modify?notice_id='+notice_id,
            type:'POST',
            data : JSON.stringify(notice),
            contentType : "application/json; charset = utf-8",
            success : function (result){
                callback(result)
            },
            error:(log)=>{alert("실패"+log)}
        });
    }
    function remove(notice_id,callback){
        $.ajax({
            type : 'delete',
            url : '/ajax/notice/remove?notice_id='+notice_id,
            success:function (deleteResult,status,xhr){
                if(callback){
                    callback(deleteResult);
                }
            },
            error:(log)=>{alert("에러"+log)}
        });
    }

    return{
        add:add,
        modify:modify,
        remove:remove,
    };
})();