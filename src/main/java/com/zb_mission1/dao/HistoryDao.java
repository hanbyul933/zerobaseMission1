package com.zb_mission1.dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class HistoryDao {
    public void saveHistory(double lat, double lnt) {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = connection.prepareStatement("insert into history(lat, lnt, date) values(?,?, NOW());");
            prst.setDouble(1, lat);
            prst.setDouble(2, lnt);


            prst.executeUpdate();

        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } catch (ClassNotFoundException ex) {
            throw new RuntimeException(ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {

                }
            }
            if (prst != null) {
                try {
                    prst.close();
                } catch (Exception e) {

                }
            }
        }
    }

    public void deleteHistory(int id) {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = connection.prepareStatement("delete from history where id = ?;");
            prst.setInt(1, id);

            prst.executeUpdate();

        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } catch (ClassNotFoundException ex) {
            throw new RuntimeException(ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {

                }
            }
            if (prst != null) {
                try {
                    prst.close();
                } catch (Exception e) {

                }
            }
        }
    }
}
