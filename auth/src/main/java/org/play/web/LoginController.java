package org.play.web;

import cn.dev33.satoken.annotation.SaCheckRole;
import cn.dev33.satoken.stp.StpUtil;
import org.play.entity.SysUser;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

@SaCheckRole("admin")
@RestController
@RequestMapping("/user")
public class LoginController {


    @RequestMapping("/login")
    public String login(SysUser user) {
        String username = user.getUsername();
        String pass = user.getPassword();
        if (Objects.equals("admin", username) && Objects.equals("admin", pass)) {
            StpUtil.login(10086);
            return "success" + StpUtil.getTokenInfo().getTokenValue();
        }
        return "failed";
    }

    @RequestMapping("/islogin")
    public String isLogin() {
        boolean login = StpUtil.isLogin();
        if (login) {
            return "" + StpUtil.getLoginId();
        }
        return "" + StpUtil.isLogin();
    }
}
