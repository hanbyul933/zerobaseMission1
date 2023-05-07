<%--
  Created by IntelliJ IDEA.
  User: byulhan
  Date: 2023/05/03
  Time: 12:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 추가</title>
    <link rel="stylesheet" href="resource/style.css">
</head>
<body>
<h1>북마크 그룹 추가</h1>
<a href="index.jsp">홈</a> | <a href="history.jsp">위치 히스토리 목록</a> | <a href="openApi">Open API 와이파이 정보 가져오기</a> | <a
        href="bookmarkview.jsp">북마크 보기</a> | <a href="bookmarkgroup.jsp">북마크 그룹 관리</a>
<br>
<br>
<form action="bookmark" method="get">
<table id="customers">
    <tr>
    <th>북마크 이름</th>
        <td><input type="text" name="name"></td>
    </tr>
    <tr>
        <th>순서</th>
        <td><input type="text" name="num"></td>
    </tr>
</table>
    <br>
<div class="bookmark-button" style="text-align: center">
    <button type="submit" style="text-align: center">추가</button>
</div>
    <input type="hidden" name="action" value="create">
</form>

</body>
</html>
