<%@ page import="java.sql.*" %>
<%@ page import="com.zb_mission1.dao.jdbcCall" %><%--
  Created by IntelliJ IDEA.
  User: byulhan
  Date: 2023/04/29
  Time: 9:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>위치 히스토리 목록</title>
    <link rel="stylesheet" href="resource/style.css">
    <% if(request.getAttribute("message") != null) { %>
    <script>
        alert("<%= request.getAttribute("message") %>");
    </script>
    <% } %>
</head>
<body>
<h1>위치 히스토리 목록</h1>
<a href="index.jsp">홈</a> | <a href="history.jsp">위치 히스토리 목록</a> | <a href="openApi">Open API 와이파이 정보 가져오기</a> | <a href="bookmarkview.jsp">북마크 보기</a> | <a href="bookmarkgroup.jsp">북마크 그룹 관리</a>
<br>
<br>
<table id="customers">
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>조회일자</th>
        <th>비고</th>
    </tr>
<%
    // 데이터베이스 연결
    Connection conn = jdbcCall.getConnection();

    // 쿼리문 작성
    String sql = "SELECT * FROM history ORDER BY id DESC;";

    // PreparedStatement를 사용하여 쿼리 실행
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    while(rs.next()) {
        int id = rs.getInt("id");
        out.println("<tr>");
        out.println("<td>" + rs.getInt("id") + "</td>");
        out.println("<td>" + rs.getDouble("lat") + "</td>");
        out.println("<td>" + rs.getDouble("lnt") + "</td>");
        out.println("<td>" + rs.getString("date") + "</td>");
        out.println("<td><form action=\"history\" method=\"post\"><input type=\"hidden\" name=\"id\" value=\"" + id + "\"><button type=\"submit\">삭제</button></form></td>");
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
