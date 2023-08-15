package org.play.config;

import org.play.entity.SysUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class UserUtil {

    @Autowired
    private UserService userService;

    /**
     * 获取当前登录者的信息
     * @return 当前者信息
     */
    public SysUser getUser() {
        //获取当前用户的用户名
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        SysUser user = userService.findByUsername(username);
        return user;
    }



}
