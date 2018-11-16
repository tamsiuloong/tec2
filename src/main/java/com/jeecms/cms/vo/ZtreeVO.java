package com.jeecms.cms.vo;

import lombok.Data;

import java.io.Serializable;
@Data
public class ZtreeVO implements Serializable {

    //{ id:1, pId:0, name:"随意勾选 1", open:true},
    private String id;
    private String pId;
    private String name;
    private Boolean checked=false;
    private Boolean open = false;
//    private Boolean isParent=false;

}
