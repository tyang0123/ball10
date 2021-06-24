console.log("Notice Module ........ ");
var noticeService = (function (){

    //공지추가
    function add(notice,callback){
        console.log("add notice .... ");
        $.ajax({
            url:'/notice/add',
            type:'POST',
            data : JSON.stringify(notice),
            contentType : "application/json; charset = utf-8",
            success : function (result){
                callback(result)
            },
            error:(log)=>{alert("실패"+log)}
        });
    }

    return{
        add:add,
    };
})();