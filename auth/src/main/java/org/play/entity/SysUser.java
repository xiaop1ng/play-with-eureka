package org.play.entity;

import lombok.Data;

@Data
public class SysUser {
    private String username;    //账号
    private String password;    //密码
    private String name;        //姓名
    private String role;        //角色
}
