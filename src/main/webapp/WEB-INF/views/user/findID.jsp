<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../includes/header.jsp" %>




<div class="container">
    <div>
        <div class="col-sm-12">
            <h1>아이디 찾기</h1>

            <form method="post" action="/user/findID">
                <div class="form-group m-3">
                    <input type="text" class="form-control" id="user-email" name="user_email" placeholder="이메일@example.com">
                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <input type="submit" class="btn btn-primary" style="margin-top: 1rem;" value="이메일로 ID보내기">
            </form>
        </div> <!-- end form div col-sm-12 -->
    </div>

</div><!--end div container -->


<script>
    $(document).ready(function(){
        var sendID = "${sendID}";
        console.log(sendID);
        if(sendID!=''){
            alert(sendID);
        }
    })//end document.ready
</script>





<%@ include file="../includes/footer.jsp" %>