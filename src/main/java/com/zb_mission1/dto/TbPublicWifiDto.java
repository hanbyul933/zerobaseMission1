package com.zb_mission1.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TbPublicWifiDto {
    private int list_total_count;
    private ResultDto RESULT;
    private List<RowDto> row;

    public TbPublicWifiDto() {
        this.list_total_count = list_total_count;
        this.RESULT = RESULT;
        this.row = row;
    }
}
