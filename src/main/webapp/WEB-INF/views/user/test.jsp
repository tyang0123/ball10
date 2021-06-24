<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="indexListAjax">
<c:forEach var='list' items='${list}'>
    <tbody>
    <tr class='itemTitle'>
    <td style='font-size: 12px;' class='align-middle' id='dada1'>displayTime(${list.alarm_message_mod_date})</td>
    <td><div class='alarm-content'id='dada2'>${list.alarm_message_content}</div></td>
    <td id='dada3'>${list.alarm_message_is_new}</td>
    </tr><tr class='hideContent'><td colspan='3' id='dada4'>${list.alarm_message_content}</td></tr>
    </tbody>
</c:forEach>
</div>