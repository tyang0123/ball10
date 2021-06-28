<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%@ include file="../includes/header.jsp" %>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"> 그룹 수정 페이지 </div> <!-- /.panel-heading -->
            <div class="panel-body">
                <form id="operForm" action="/group/modify" role="form" method="post">
                    <div class="form-group">
                        <label for="group_id">번호
                        <input class="form-control" name="group_id" id="group_id" value="${group.group_id}" readonly="readonly">
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="user_nickname_group_header">그룹장
                            <input class="form-control" name="user_nickname_group_header" id="user_nickname_group_header" value="${group.user_nickname_group_header}" readonly="readonly">
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="group_name">그룹이름
                        <input class="form-control" name="group_name" id="group_name" placeholder="그룹이름" value="${group.group_name}"/>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="group_category">그룹 카테고리</label><br>
<%--                        <input class="form-control" name="group_category" id="group_category"  value="${group.group_category}"/>--%>
                        <select id="group_category" name="group_category">
                            <option value="취업">취업</option>
                            <option value="토익" >토익</option>
                            <option value="이직">이직</option>
                            <option value="자격증">자격증</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="group_is_secret">비밀방
                            <input type="checkbox"  name="group_is_secret" id="group_is_secret" value="${group.group_is_secret}" onclick="checkClick()" readonly="readonly"/>
                            </label>

                    </div>
                    <div class="form-group">
                        <label for="group_password"> 비밀번호
                        <input class="form-control" name="group_password" id="group_password" placeholder="비밀번호" value="${group.group_password}"/>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="group_person_count">그룹 인원</label>
                        <select id="group_person_count" name="group_person_count">
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                        </select>

                    </div>
                    <div class="form-group">
                        <label for="group_content"/>
                        <textarea class="form-control" rows="3" name="group_content"
                                  id="group_content" placeholder="그룹 소개">${group.group_content}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="group_target_hour">목표 시간</label>
                        <select name="group_target_hour" id="group_target_hour">
                            <option value="1시간">1시간</option>
                            <option value="2시간">2시간</option>
                            <option value="3시간">3시간</option>
                            <option value="4시간">4시간</option>
                            <option value="5시간">5시간</option>
                            <option value="6시간">6시간</option>
                            <option value="7시간">7시간</option>
                            <option value="8시간">8시간</option>
                            <option value="9시간">9시간</option>
                            <option value="10시간">10시간</option>
                            <option value="11시간">11시간</option>
                            <option value="12시간">12시간</option>
                            <option value="13시간">13시간</option>
                            <option value="14시간">14시간</option>
                            <option value="15시간">15시간</option>
                        </select>
                        <select name="group_target_minute" id="group_target_minute">
                            <option value="0분">0분</option>
                            <option value="10분">10분</option>
                            <option value="20분">20분</option>
                            <option value="30분">30분</option>
                            <option value="40분">40분</option>
                            <option value="50분">50분</option>
                        </select>
                    </div>


<%--                    <div class="form-group">--%>
<%--                        <label for="group_mod_date">수정일</label>--%>
<%--                        <input type="text" class="form-control" name="updateDate"--%>
<%--                               value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>'--%>
<%--                               readonly="readonly">--%>
<%--                    </div>--%>
                    <button data-oper="modify" class="btn btn-default" type="submit"> 수정하기 </button>
                    <button data-oper="list" class="btn btn-info">취소</button>
                    <a href="group/list"></a>
                </form>
            </div> <!-- end panel-body -->
        </div> <!-- end panel -->
    </div> <!-- col-lg-12 -->
</div> <!-- row -->

<script>
    $(document).ready(function (){

            if($("#group_is_secret").val()==1){
                $("#group_is_secret").attr("checked",true);
                $("#group_password").attr('readonly',false);
                <%--$("#group_password").attr('value',${group.group_password})--%>
            }else{
                $("#group_is_secret").attr("checked",false);
                $("#group_password").attr('readonly',true);
            }


        $("#group_category").val("${group.group_category}").attr("selected", true);
        $("#group_person_count").val("${group.group_person_count}").attr("selected", true);
        $("#group_target_hour").val("${group.group_target_hour}").attr("selected", true);
        $("#group_target_minute").val("${group.group_target_minute}").attr("selected", true);

        $("#group_is_secret").click(function (){
            if($("#group_is_secret").is(':checked')){
                $("#group_password").attr('readonly',false)

            }else{
                $("#group_password").attr('readonly',true)
                $("#group_password").attr('value',null)
            }
        })
        $(".btn-default").click(function (){
            if($("#group_is_secret").is(':checked')){
                if($("#group_password").val() == ""){
                    $("#group_password").attr('required', true)
                }
            }
        })

        $("button").click(function (){
            var operation = $(this).data("oper");
            if(operation === 'list'){
                $("#operForm").attr("action", "/group/list").attr("method", "get")
            }
        })
        $('#group_target_time').selectpicker({
            multipleSeparator: ' '
        }).on('changed.bs.select', function() {
            $(this).selectpicker('refresh');
        })
    })
    function checkClick() {
        var valueClick = 0;
        if ($("#group_is_secret").is(':checked')) {
            valueClick = 1;
            $("#group_is_secret").val(valueClick)
            console.log("여기가 들어오나", valueClick)
        } else {
            valueClick = 0;
            $("#group_is_secret").val(valueClick)
            console.log("여기가 들어오나", valueClick)
        }
    }

    $("#group_password").on('input', function(e){
        var regex = new RegExp("^[A-Za-z0-9]+$"); // 비밀번호 설정
        if(!regex.test(e.target.value)){
            console.log("tick");
            var str = e.target.value;
            e.target.value= str.substring(0, str.length-1);
        }
    })

</script>
<%@ include file="../includes/footer.jsp" %>