package com.zb_mission1.dao;

import com.google.gson.Gson;
import com.zb_mission1.dto.BaseDto;
import com.zb_mission1.dto.TbPublicWifiDto;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.mariadb.jdbc.Driver;

import java.io.IOException;
import java.sql.*;

public class WifiDao {
    public TbPublicWifiDto getApiResponse(int firstCount, int lastCount) throws IOException {
        OkHttpClient okHttpClient = new OkHttpClient();
        Request request = new Request.Builder().url("http://openapi.seoul.go.kr:8088/5771637a6668616e38396546446374/json/TbPublicWifiInfo/" + (firstCount) + "/" + (lastCount)).get().build();
        Response response = okHttpClient.newCall(request).execute();

        Gson gson = new Gson();
        String result = response.body().string();
        BaseDto base = gson.fromJson(result, BaseDto.class);
        TbPublicWifiDto tbPublicWifiDto = base.getTbPublicWifiInfo();
        return tbPublicWifiDto;
    }


    public int insertDB() {
        PreparedStatement prst = null;
        java.sql.Connection connection = null;
        ResultSet rs = null;
        int totalList = 0;

        try {// jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            OkHttpClient okHttpClient = new OkHttpClient();

            TbPublicWifiDto tbForCnt = getApiResponse(1, 1);
            totalList = tbForCnt.getList_total_count();

            int cnt = totalList / 1000; // 한번에 호출이 1000개 밖에 안돼서 나눠서 반복문 돌리기
            int callCnt = 0;
            try {
                for (int i = 0; i <= cnt; i++) {
                    TbPublicWifiDto tbObj = getApiResponse((i * 1000) + 1, (i + 1) * 1000);
                    for (int j = 0; j <= 999; j++) {
                        prst = connection.prepareStatement(
                                "insert into wifiInfo(X_SWIFI_MAIN_NM, X_SWIFI_MGR_NO, X_SWIFI_WRDOFC, X_SWIFI_ADRES1, " +
                                        "X_SWIFI_ADRES2, X_SWIFI_INSTL_FLOOR, X_SWIFI_INSTL_TY, X_SWIFI_INSTL_MBY, X_SWIFI_SVC_SE," +
                                        "X_SWIFI_CMCWR, X_SWIFI_CNSTC_YEAR, X_SWIFI_INOUT_DOOR, X_SWIFI_REMARS3, LAT, LNT, WORK_DTTM)" +
                                        " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");

                        prst.setString(1, tbObj.getRow().get(j).getX_SWIFI_MAIN_NM());
                        prst.setString(2, tbObj.getRow().get(j).getX_SWIFI_MGR_NO());
                        prst.setString(3, tbObj.getRow().get(j).getX_SWIFI_WRDOFC());
                        prst.setString(4, tbObj.getRow().get(j).getX_SWIFI_ADRES1());
                        prst.setString(5, tbObj.getRow().get(j).getX_SWIFI_ADRES2());
                        prst.setString(6, tbObj.getRow().get(j).getX_SWIFI_INSTL_FLOOR());
                        prst.setString(7, tbObj.getRow().get(j).getX_SWIFI_INSTL_TY());
                        prst.setString(8, tbObj.getRow().get(j).getX_SWIFI_INSTL_MBY());
                        prst.setString(9, tbObj.getRow().get(j).getX_SWIFI_SVC_SE());
                        prst.setString(10, tbObj.getRow().get(j).getX_SWIFI_CMCWR());
                        prst.setString(11, tbObj.getRow().get(j).getX_SWIFI_CNSTC_YEAR());
                        prst.setString(12, tbObj.getRow().get(j).getX_SWIFI_INOUT_DOOR());
                        prst.setString(13, tbObj.getRow().get(j).getX_SWIFI_REMARS3());
                        // 현재 위도 경도가 잘못 출력되는 오류가 있어서 반대로 데이터에 넣음
                        prst.setDouble(14, tbObj.getRow().get(j).getLNT());
                        prst.setDouble(15, tbObj.getRow().get(j).getLAT());
                        prst.setString(16, tbObj.getRow().get(j).getWORK_DTTM());

                        prst.executeUpdate();
                        callCnt++;
                        if (callCnt == totalList) {
                            break;
                        }
                    }
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
        } catch (IOException e) {
            throw new RuntimeException(e);
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
        return totalList;
    }

    public void deleteDb() {
        java.sql.Connection connection = null;
        PreparedStatement prst = null;
        ResultSet rs = null;


        try {
            // jdbc 로딩
            Class.forName("org.mariadb.jdbc.Driver");

            // db 연결
            connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi?allowQueries=true", "wifi_user", "2411");

            prst = null;

            String sql = "truncate table wifiInfo";
            prst = connection.prepareStatement(sql);
            prst.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
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
