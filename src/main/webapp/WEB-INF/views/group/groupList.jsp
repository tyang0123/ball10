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
                    <tr>
                        <td>${list.group_id}</td>
                        <td><a class='move' href='read?group_id=${list.group_id}'>${list.group_name}</a></td>
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

        <%--            <c:forEach var="group" items="${group}">--%>
        <%--                <div>--%>
        <%--                    <row>--%>
        <%--                            ${list.user_nickname}--%>
        <%--                            ${list.group_message_reg_date}--%>
        <%--                    </row>--%>
        <%--                </div>--%>
        <%--            </c:forEach>--%>
    </div>
</div>
</body>
</html>

<script>
    $(document).ready(function (){
        $("#createBtn").click(function(){
            console.log("버튼 눌리나")
            $("#listForm").attr("action", "/group/create").submit();
        })
        $('.move').click(function (){
            // prompt('비밀번호를 입력하세요');
            $.ajax({
                type:"post",
                url:"/group/list/ajax/list",
                data:{},
                dataType:"json",
                success: function (){
                    alert('성공');
                }

            })
        })

    })



</script>



<%@ include file="../includes/footer.jsp" %>