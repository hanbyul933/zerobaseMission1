package com.zb_mission1.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class jdbcCall {
    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            // JDBC 드라이버 로드
            Class.forName("org.mariadb.jdbc.Driver");
            // DB 연결
            conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
