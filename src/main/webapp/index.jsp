<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zb_mission1.dao.HistoryDao" %>
<%@ page import="com.zb_mission1.dao.jdbcCall" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <script>
        let lat = null;
        let lnt = null;

        function getPosition() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (pos) {
                        lat = pos.coords.latitude;
                        document.getElementById("latId").value = lat;
                        lnt = pos.coords.longitude;
                        document.getElementById("lntId").value = lnt;
                    },

                    function (error) {
                        console.error(error);
                    },
                    {
                        enableHighAccuracy: false,
                        maximumAge: 0,
                        timeout: Infinity
                    });
                // document.getElementById("latName").value = document.getElementById("latId").value;
                // document.getElementById("lntName").value = document.getElementById("lntId").value;
            } else {
                alert('현재 위치를 조회할 수 없습니다.');
            }
        }
    </script>
    <style>
        * input {
            font-size: 16px;
        }
    </style>
    <link rel="stylesheet" href="resource/style.css">
</head>
<body>

<h1>와이파이 정보 구하기</h1>
<a href="index.jsp">홈</a> | <a href="history.jsp">위치 히스토리 목록</a> | <a href="openApi">Open API 와이파이 정보 가져오기</a> | <a
        href="bookmarkview.jsp">북마크 보기</a> | <a href="bookmarkgroup.jsp">북마크 그룹 관리</a>
<br>
<br>
<div>
    <form action="index.jsp" method="get">
        <label for="latId">LAT:</label>
        <input id="latId" name="latName"
               value="<%= request.getParameter("latName") != null ? request.getParameter("latName") : "0.0" %>">

        <label for="lntId">, LNT:</label>
        <input id="lntId" name="lntName"
               value="<%= request.getParameter("lntName") != null ? request.getParameter("lntName") : "0.0" %>">

        <input type="button" onclick="getPosition()" value="내 위치 가져오기">
        <input type="submit" value="근처 WIFI 정보 보기">
    </form>
</div>
<br>
<table id="customers">
    <tr>
        <th>거리(Km)</th>
        <th>관리번호</th>
        <th>자치구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내외구분</th>
        <th>WIFI접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>
    <%
        if (request.getParameter("latName") == null || request.getParameter("lntName") == null
                || request.getParameter("latName") == "" || request.getParameter("lntName") == "") {
            out.write("<tr>");
            out.write("<td colspan=\"17\" style=\"text-align:center\"> 위치 정보를 입력한 후에 조회해 주세요.</td>");
        } else {
            // 위도, 경도 값 받아오기
            double myLat = Double.parseDouble(request.getParameter("latName"));
            double myLng = Double.parseDouble(request.getParameter("lntName"));

            HistoryDao history = new HistoryDao();
            history.saveHistory(myLat, myLng);

            // 데이터베이스 연결
            Connection conn = jdbcCall.getConnection();

            String updateSql = "UPDATE wifiInfo SET distance_km = ROUND(6371 * ACOS(COS(RADIANS(?)) * COS(RADIANS(`LAT`)) * COS(RADIANS(`LNT`) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(`LAT`))), 4)";
            String selectSql = "SELECT * FROM wifiInfo ORDER BY distance_km ASC LIMIT 20";

// PreparedStatement를 사용하여 쿼리 실행 (UPDATE)
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setDouble(1, myLat);
            updateStmt.setDouble(2, myLng);
            updateStmt.setDouble(3, myLat);
            updateStmt.executeUpdate();

// PreparedStatement를 사용하여 쿼리 실행 (SELECT)
            PreparedStatement selectStmt = conn.prepareStatement(selectSql);
            ResultSet rs = selectStmt.executeQuery();

            // 결과 출력
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getDouble("distance_km") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_MGR_NO") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_WRDOFC") + "</td>");
                out.println("<td><a href=\"detail.jsp?mgr_no=" + rs.getString("X_SWIFI_MGR_NO")+ "\">" + rs.getString("X_SWIFI_MAIN_NM") + "</a></td>");
                out.println("<td>" + rs.getString("X_SWIFI_ADRES1") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_ADRES2") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_INSTL_FLOOR") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_INSTL_TY") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_INSTL_MBY") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_SVC_SE") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_CMCWR") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_CNSTC_YEAR") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_INOUT_DOOR") + "</td>");
                out.println("<td>" + rs.getString("X_SWIFI_REMARS3") + "</td>");
                out.println("<td>" + rs.getDouble("LAT") + "</td>");
                out.println("<td>" + rs.getDouble("LNT") + "</td>");
                out.println("<td>" + rs.getString("WORK_DTTM") + "</td>");
                // 나머지 필드 출력
                out.println("</tr>");
            }
            out.println("</table>");

            // 리소스 해제
            rs.close();
            updateStmt.close();
            selectStmt.close();
            conn.close();
        }
    %>

</table>
</body>
</html>