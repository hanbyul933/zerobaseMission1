package com.zb_mission1.dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BookmarkDao {
    public void saveBookmarkGroup(String name, String num) {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = connection.prepareStatement("insert into bookmarkgroup(bookmarkname, ordernum, creationdate) values(?,?, NOW());");
            prst.setString(1, name);
            prst.setInt(2, Integer.parseInt(num));


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

    public void deleteBookmarkGroup(String id) {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = connection.prepareStatement("delete from bookmarkgroup where id = ?");
            prst.setInt(1, Integer.parseInt(id));


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

    public void modifyBookmark(String name, String num, String id) {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = connection.prepareStatement("UPDATE bookmarkgroup SET bookmarkname = ?, ordernum = ?, modifydate = NOW() WHERE id = ?");
            prst.setString(1, name);
            prst.setInt(2, Integer.parseInt(num));
            prst.setInt(3, Integer.parseInt(id));

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

    public void wifiToBookmark(String groupName, String wifiNo) {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = connection.prepareStatement("INSERT INTO bookmarkjoin (booKmarkid, wifiid, creationdate)\n" +
                    "SELECT bg.id, wg.X_SWIFI_MGR_NO\n, NOW()" +
                    "FROM bookmarkgroup bg, wifiInfo wg\n" +
                    "WHERE bg.bookmarkname = ? AND wg.X_SWIFI_MGR_NO = ?\n");
            prst.setString(1, groupName);
            prst.setString(2, wifiNo);
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

    public void joinDelete(int joinid) {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = connection.prepareStatement("delete from bookmarkjoin where id = ?");
            prst.setInt(1, joinid);
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
