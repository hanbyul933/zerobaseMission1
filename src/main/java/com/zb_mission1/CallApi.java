package com.zb_mission1;

import java.io.IOException;
import java.sql.SQLException;

import com.zb_mission1.dao.WifiDao;
import com.zb_mission1.dto.RowDto;
import com.zb_mission1.dto.TbPublicWifiDto;

public class CallApi {
    public static void main(String[] args) throws IOException, SQLException, ClassNotFoundException {
        WifiDao wifiDao = new WifiDao();
//        }
    }
    /*
    public List<RowDto> getApis(TbPublicWifiDto tbPublicWifiDto) {

        JsonObject responseBody = tbPublicWifiDto.getAsJsonObject();
        JsonObject tbPublicWifiInfo = responseBody.getAsJsonObject("TbPublicWifiInfo");
        int listtotalcount = tbPublicWifiInfo.get("list_total_count").getAsInt();
        //System.out.println(listtotalcount);
        JsonArray row = tbPublicWifiInfo.get("row").getAsJsonArray();
        List<RowDto> list = new ArrayList<>();
        for (JsonElement element1 : row) {
            RowDto rowDto = new Gson().fromJson(element1.getAsJsonObject(), RowDto.class);
            list.add(rowDto);
        }

        return list;
    }

     */

}



