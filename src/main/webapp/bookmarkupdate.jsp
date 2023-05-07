<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>북마크 그룹 수정</title>
  <link rel="stylesheet" href="resource/style.css">
</head>
<body>
<h1>북마크 그룹 수정</h1>
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
  <div class="bookmarkedit-button" style="text-align: center">
    <a href="bookmarkgroup.jsp"> 돌아가기 </a>|
    <button type="submit" style="text-align: center">수정</button>
  </div>
  <input type="hidden" name="action" value="modify">
  <input type="hidden" name="id" value=<%=request.getParameter("id")%>>
</form>

</body>
</html>
