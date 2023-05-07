<%@ page import="java.sql.*" %>
<%@ page import="com.zb_mission1.dao.jdbcCall" %><%--
  Created by IntelliJ IDEA.
  User: byulhan
  Date: 2023/04/29
  Time: 10:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>detail</title>
    <link rel="stylesheet" href="resource/style.css">
    <style>
        * button {
            font-size: 16px;
            padding: 2px 5px 2px 5px;
        }
    </style>
</head>
<body>
<h1>와이파이 정보 구하기</h1>
<a href="index.jsp">홈</a> | <a href="">위치 히스토리 목록</a> | <a href="openApi">Open API 와이파이 정보 가져오기</a> | <a href="bookmarkview.jsp">북마크
    보기</a> | <a href="bookmarkgroup.jsp">북마크 그룹 관리</a>
<br>
<br>
<form action="bookmark" method="get">
    <%
        Connection connB = jdbcCall.getConnection();

        String sqlB = "SELECT bookmarkname FROM bookmarkgroup";

        PreparedStatement prst = connB.prepareStatement(sqlB);
        ResultSet rsB = prst.executeQuery();

        out.println("<select name=\"bookmarkGroup\" id=\"bookmarkGroup\">");
        out.println("<option value=\"\">북마크 그룹 선택</option>");
        while (rsB.next()) {
            out.println("<option value=\"" + rsB.getString("bookmarkname") + "\">" + rsB.getString("bookmarkname") + "</option>");
        }
        out.println("</select>");

        // 리소스 해제
        rsB.close();
        prst.close();
        connB.close();
    %>
    <button type="submit">추가</button>
    <input type="hidden" name="action" value="wifiadd">
    <input type="hidden" name="mgr_no" value=<%=request.getParameter("mgr_no")%>>
</form>

<br>
<br>
<table id="customers">
        <%
        Connection conn = jdbcCall.getConnection();

        String thisMrgNo = request.getParameter("mgr_no");

// 쿼리문 작성
        String sql = "SELECT * FROM wifiInfo WHERE X_SWIFI_MGR_NO = ?";

// PreparedStatement를 사용하여 쿼리 실행
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, thisMrgNo);
        ResultSet rs = pstmt.executeQuery();

        while(rs.next()) {
            out.println("<tr><th>거리(Km)</th><td>" + rs.getDouble("distance_km") + "</td></tr>");
        out.println("<tr><th>관리번호</th><td>" + rs.getString("X_SWIFI_MGR_NO") + "</td></tr>");
        out.println("<tr><th>자치구</th><td>" + rs.getString("X_SWIFI_WRDOFC") + "</td></tr>");
        out.println("<tr><th>와이파이명</th><td>" + rs.getString("X_SWIFI_MAIN_NM") + "</td></tr>");
        out.println("<tr><th>도로명주소</th><td>" + rs.getString("X_SWIFI_ADRES1") + "</td></tr>");
        out.println("<tr><th>상세주소</th><td>" + rs.getString("X_SWIFI_ADRES2") + "</td></tr>");
        out.println("<tr><th>설치위치</th><td>" + rs.getString("X_SWIFI_INSTL_FLOOR") + "</td></tr>");
        out.println("<tr><th>설치유형</th><td>" + rs.getString("X_SWIFI_INSTL_TY") + "</td></tr>");
        out.println("<tr><th>설치기관</th><td>" + rs.getString("X_SWIFI_INSTL_MBY") + "</td></tr>");
        out.println("<tr><th>서비스구분</th><td>" + rs.getString("X_SWIFI_SVC_SE") + "</td></tr>");
        out.println("<tr><th>망종류</th><td>" + rs.getString("X_SWIFI_CMCWR") + "</td></tr>");
        out.println("<tr><th>설치년도</th><td>" + rs.getString("X_SWIFI_CNSTC_YEAR") + "</td></tr>");
        out.println("<tr><th>실내외구분</th><td>" + rs.getString("X_SWIFI_INOUT_DOOR") + "</td></tr>");
        out.println("<tr><th>WIFI접속환경</th><td>" + rs.getString("X_SWIFI_REMARS3") + "</td></tr>");
        out.println("<tr><th>X좌표</th><td>" + rs.getDouble("LAT") + "</td></tr>");
        out.println("<tr><th>Y좌표</th><td>" + rs.getDouble("LNT") + "</td></tr>");
        out.println("<tr><th>작업일자</th><td>" + rs.getString("WORK_DTTM") + "</td></tr>");
        }
        out.println("</table>");

        // 리소스 해제
        rs.close();
        pstmt.close();
        conn.close();
        %>
</body>
</html>