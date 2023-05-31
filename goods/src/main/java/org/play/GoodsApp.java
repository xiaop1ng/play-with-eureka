package org.play;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1")
@SpringBootApplication
// 开启服务注册发现功能
@EnableDiscoveryClient
public class GoodsApp {

    @Value("${goods.price:100}")
    private Long price;

    @Value("${server.port:100}")
    private Integer port;

    @GetMapping("/price")
    public Long get() {
        return price;
    }

    @GetMapping("/port")
    public String port() {
        return "port: " + port;
    }


    public static void main(String[] args) {
        SpringApplication.run(GoodsApp.class, args);
    }

}
