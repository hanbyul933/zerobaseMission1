<%@ page import="java.sql.Connection" %>
<%@ page import="com.zb_mission1.dao.jdbcCall" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 목록</title>
    <% if(request.getAttribute("message") != null) { %>
    <script>
        alert("<%= request.getAttribute("message") %>");
    </script>
    <% } %>
    <link rel="stylesheet" href="resource/style.css">
</head>
<body>
<h1>북마크 목록</h1>
<a href="index.jsp">홈</a> | <a href="history.jsp">위치 히스토리 목록</a> | <a href="openApi">Open API 와이파이 정보 가져오기</a> | <a
        href="bookmarkview.jsp">북마크 보기</a> | <a href="bookmarkgroup.jsp">북마크 그룹 관리</a>
<br>
<br>
<table id="customers">
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>와이파이명</th>
        <th>등록일자</th>
        <th>삭제</th>
    </tr>
    <%
        Connection conn = jdbcCall.getConnection();

// 쿼리문 작성
        String sql = "SELECT bj.id, bg.bookmarkname, wi.X_SWIFI_MAIN_NM, wi.X_SWIFI_MGR_NO, bj.creationdate FROM bookmarkjoin bj\n" +
                "         JOIN bookmarkgroup bg ON bj.bookmarkid = bg.id\n" +
                "         JOIN wifiInfo wi ON bj.wifiid = wi.X_SWIFI_MGR_NO;";

// PreparedStatement를 사용하여 쿼리 실행
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            do {
                out.println("<tr><td>" + rs.getString("bj.id") + "</td>");
                out.println("<td>" + rs.getString("bg.bookmarkname") + "</td>");
                out.println("<td><a href=\"detail.jsp?mgr_no=" + rs.getString("wi.X_SWIFI_MGR_NO") + "\">" + rs.getString("wi.X_SWIFI_MAIN_NM") + "</a></td>");
                out.println("<td>" + rs.getString("bj.creationdate") + "</td>");
                out.println("<td><a href=\"bookmarkdelete.jsp?id=" + rs.getString("bj.id") + "\">삭제</a></td></tr>");
            } while (rs.next());
        } else {
            out.println("<tr><td colspan=\"5\" style=\"text-align:center\">정보가 존재하지 않습니다.</td></tr>");
        }

        out.println("</table>");

        // 리소스 해제
        rs.close();
        pstmt.close();
        conn.close();
    %>

</table>

</body>
</html>
