<%@ page import="java.sql.Connection" %>
<%@ page import="com.zb_mission1.dao.jdbcCall" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: byulhan
  Date: 2023/05/05
  Time: 7:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 삭제</title>
    <link rel="stylesheet" href="resource/style.css">
</head>
<body>
<h1>북마크 삭제</h1>
<a href="index.jsp">홈</a> | <a href="">위치 히스토리 목록</a> | <a href="openApi">Open API 와이파이 정보 가져오기</a> | <a
        href="bookmarkview.jsp">북마크
    보기</a> | <a href="bookmarkgroup.jsp">북마크 그룹 관리</a>
<br>
<br>
북마크를 삭제하시겠습니까?
<table id="customers">
    <%
        //jdbc 연결
        Connection conn = jdbcCall.getConnection();

        String bjid = request.getParameter("id");

        // 쿼리문 작성
        String sql = "SELECT bg.bookmarkname, wi.X_SWIFI_MAIN_NM, wi.X_SWIFI_MGR_NO, bj.creationdate FROM bookmarkjoin bj " +
                "JOIN bookmarkgroup bg ON bj.bookmarkid = bg.id " +
                "JOIN wifiInfo wi ON bj.wifiid = wi.X_SWIFI_MGR_NO " +
                "WHERE bj.id = ?";

        // PreparedStatement를 사용하여 쿼리 실행
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(bjid));
        ResultSet rs = pstmt.executeQuery();

        while(rs.next()) {
            out.println("<tr>");
            out.println("<th>북마크 이름</th><td>" + rs.getString("bg.bookmarkname") + "</td></tr>");
            out.println("<tr><th>와이파이명</th><td>" + rs.getString("wi.X_SWIFI_MAIN_NM") + "</td></tr>");
            out.println("<tr><th>등록일자</th><td>" + rs.getString("creationdate") + "</td></tr>");
        }
        // 리소스 해제
        rs.close();
        pstmt.close();
        conn.close();
    %>
    <form action="bookmark" method="get">
        <tr>
            <td colspan="2" style="text-align: center">
                <a href="bookmarkview.jsp">돌아가기</a> | <button type="submit">삭제</button> <input type="hidden" name="action" value="joindelete"><input type="hidden" name="id" value="<%=bjid%>">
            </td>
        </tr>
    </form>
</table>

</body>
</html>
