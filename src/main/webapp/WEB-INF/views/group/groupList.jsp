<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp" %>

<html>
<head>
    <i class="bi bi-lock-fill"></i>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>그룹</title>
</head>
<body>
<div class="row">
    <div class="col-sm-12">
        <h2>스터디 그룹</h2>
        <table width="100%" class="table table-striped table-bordered table-hover"
               id="dataTables-example">
            <div class="row">
                <div class="col-lg-12">
                    <form id="listForm" action="/group/list" method="get">
                        <button id="createBtn" type="submit" class="btn pull-right btn-warning">그룹 생성</button>
                        <select name="category">
                            <option value="" <c:out value="${cri.category ==null?'selected':''}"/>>---</option>
                            <option value="토익"
                                    <c:out value="${cri.category eq '토익'?'selected':''}"/>>토익</option>
                            <option value="입시"
                                    <c:out value="${cri.category eq '입시'?'selected':''}"/>>입시</option>
                            <option value="자격증"
                                    <c:out value="${cri.category eq '자격증'?'selected':''}"/>>자격증</option>
                            <option value="이직"
                                    <c:out value="${cri.category eq '이직'?'selected':''}"/>>이직</option>

                        </select>
                        <input type="text" name="keyword"/>

                        <button class='btn btn-default'>검색</button>
                    </form>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>그룹 이름</th>
                        <th>그룹장</th>
                        <th>카테고리</th>
                        <th>참여인원</th>
                        <th>생성일자</th>

                    </tr>
                    </thead>
                    <c:forEach items="${list}" var="list" end="${list.size()}">
                    <tr class='move' style="cursor: pointer;" value="${list.group_is_secret}">
                        <input type="hidden" name="group_id" value="${list.group_id}"/>
                        <td>${list.group_id}</td>
                        <td>${list.group_name}</td>
                        <td>${list.user_nickname_group_header}</td>
                        <td>${list.group_category}</td>
                        <td>${list.group_join_person_number}/${list.group_person_count}
                            <c:if test="${list.group_is_secret==1}">
                                <i class="fa fa-lock"  aria-hidden="true"/>
                            </c:if>
                        </td>
                        <td><fmt:parseDate var="date1" value="${list.group_reg_date}" pattern="yyyy-MM-dd"/>
                            <fmt:formatDate value="${date1}" type="DATE" pattern="yyyy-MM-dd"/>
                                ${date2}
                        </td>
                    </tr>
                    </c:forEach>
        </table>
    </div>
</div>

<div class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">비밀번호 입력</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
    <form  method='post'>
            <div class="modal-body">
                    <input id="inputPass" type="text"  placeholder="비밀번호를 입력하세요">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" >입력</button>
            </div>
    </form>
        </div>
    </div>
</div>
</body>
</html>

<script>
    $(document).ready(function (){
        <%--var password = ${password}--%>

        $("#createBtn").click(function(){
            console.log("버튼 눌리나")
            $("#listForm").attr("action", "/group/create").submit();
        })


        $(".move").on('click',function (){
            var groupID = $(this).find('input[name=group_id]').attr('value');
            console.log("move눌리나 값"+ $(this).attr('value'));
            let url = "/group/read?group_id="+groupID;

            if($(this).attr('value')==1){
                console.log("move 그룹 아이디 가져오기"+ groupID);
                $('.modal').modal('show');
                $(".btn-primary").click(function (){

                    console.log("모달창의 입력 값은? : "+ $('#inputPass').val());
                    $.ajax({
                        type:"POST",
                        url:"/ajax/list/"+groupID,
                        dataType:"json",
                        success: function (res){
                            let passwordAjax = res['password'];
                            let passInput = $('#inputPass').val();
                            if(passwordAjax === passInput){
                                alert("hi ajax");

                                location.replace(url);
                            }else{
                                $('#inputPass').attr("required",true);
                                console.log("bye ajax");
                            }

                            console.log("아작스 안에 들어온 패스워드",passwordAjax);
                            console.log("아작스 안에 들어온 인풋 패스워드",passInput);
                        },error : ()=>{}
                    })
                })
            }else{
                location.replace(url);
            }
        })
    })

    function clickGroup(){
        console.log("함수가 출력되나?")

    }



</script>



<%@ include file="../includes/footer.jsp" %>