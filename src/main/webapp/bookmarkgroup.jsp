<%@ page import="com.zb_mission1.dao.jdbcCall" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: byulhan
  Date: 2023/05/03
  Time: 12:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        function goToCreatePage() {
            window.location.href = "http://localhost:8080/index/bookmarkcreate.jsp";
        }
    </script>
    <% if(request.getAttribute("message") != null) { %>
    <script>
        alert("<%= request.getAttribute("message") %>");
    </script>
    <% } %>
    <title>북마크 그룹 관리</title>
    <link rel="stylesheet" href="resource/style.css">
    <style>
        * input {
            font-size: 16px;
        }
    </style>
</head>
<body>
<h1>북마크 그룹</h1>
<a href="index.jsp">홈</a> | <a href="history.jsp">위치 히스토리 목록</a> | <a href="openApi">Open API 와이파이 정보 가져오기</a> | <a
        href="bookmarkview.jsp">북마크 보기</a> | <a href="bookmarkgroup.jsp">북마크 그룹 관리</a>
<br>
<br>
<input type="button" onclick="goToCreatePage()" value="북마크 그룹 이름 추가">
<br>
<br>
<table id="customers">
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>순서</th>
        <th>등록일자</th>
        <th>수정일자</th>
        <th>비고</th>
    </tr>
        <%
    //jdbc 연결
    Connection conn = jdbcCall.getConnection();

    // 쿼리문 작성
    String sql = "SELECT * FROM bookmarkgroup ORDER BY ordernum;";

    // PreparedStatement를 사용하여 쿼리 실행
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    while(rs.next()) {
        int id = rs.getInt("id");
        out.println("<tr>");
        out.println("<td>" + rs.getInt("id") + "</td>");
        out.println("<td>" + rs.getString("bookmarkname") + "</td>");
        out.println("<td>" + rs.getString("ordernum") + "</td>");
        out.println("<td>" + rs.getString("creationdate") + "</td>");
        out.println("<td>" + (rs.getString("modifydate") == null? "": rs.getString("modifydate")) + "</td>");
        out.println("<td><a href=\"bookmarkupdate.jsp?id=" + id + "\">수정</a> ");
        out.println("<a href=\"bookmark?action=delete&id=" + id + "\">삭제</a></td>");

        out.println("</tr>");
    }
    out.println("</table>");

    // 리소스 해제
    rs.close();
    pstmt.close();
    conn.close();
    %>

</body>
</html>
