<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>회원가입 페이지</title>
</head>
<body>
    <h1>회원가입 페이지</h1>
    <form action="/create" role="form" method="post">
        <input type="text"/>
        <button type="submit">전송</button>
    </form>
</body>
</html>

<%@ include file="../includes/footer.jsp" %>

