
模块

- order 订单服务
- goods 商品服务
- ~~zuul 网关~~
- gateway 网关
- eureka-server 服务发现


## todo

- 集群环境搭建
- 配置中心
    - 模块引入依赖
    - 环境配置
    - 原配置文件迁移
- 注册中心
    - 模块引入依赖
    - 环境配置
    - 服务开启注册发现
    - 服务间调用方式变更
    - 服务间联调测试
    - 网关调用方式变更
    - 网关联调测试

## 版本选择

使用[在线初始化工具](https://start.spring.io/) 可以很方便确认 SpringBoot 和 SpringCloud 的对应版本


升级 SpringBoot 版本：`2.7.12`, Spring Cloud 版本 `2021.0.7`

```
  <spring-boot.version>2.7.12</spring-boot.version>
  <spring-cloud.version>2021.0.7</spring-cloud.version>
```

## 集群部署 eureka-server

Eureka Server 的高可用采用的是 Peer to Peer 对等通信。

Eureka Server的高可用，实际上就是将自己也作为服务向其他服务注册中心进行注册，这样就可以形成一组相互注册的服务注册中心，以实现服务清单的互相同步，达到高可用的效果。

# Eureka

高可用部署

```
spring:
  application:
    # eurka 高可用模式
    name: eurka-server
---
# node1
spring:
  profiles: node1
server:
  port: 8761
eureka:
  instance:
    # 指定 profile=node1时，将 node1 注册到 node2 和 node3 上
    hostname: node1
  client:
    serviceUrl:
      defaultZone: http://node2:18761/eureka/,http://node3:28761/eureka/
---
# node2
spring:
  profiles: node2
server:
  port: 18761
eureka:
  instance:
    # 指定 profile=node2时，将 node2 注册到 node1 和 node3 上
    hostname: node2
  client:
    serviceUrl:
      defaultZone: http://node1:8761/eureka/,http://node3:28761/eureka/
---
# node3
spring:
  profiles: node3
server:
  port: 28761
eureka:
  instance:
    # 指定 profile=node3时，将 node3 注册到 node1 和 node2 上
    hostname: node3
  client:
    serviceUrl:
      defaultZone: http://node1:8761/eureka/,http://node2:18761/eureka/
```

配置本地 host 后，启动三个节点

> java -jar eureka-server-1.0-SNAPSHOT.jar --spring.profiles.active=node1
java -jar eureka-server-1.0-SNAPSHOT.jar --spring.profiles.active=node2
java -jar eureka-server-1.0-SNAPSHOT.jar --spring.profiles.active=node3

访问 http://127.0.0.1:8761/ 可以发现 EURKA-SERVER 有 3 个实例，这时集群就搭建成功了

## 测试：
```
req: http://127.0.0.1:80/v1/price
res: 1499
req: http://127.0.0.1:8080/v1/create
res: 创建订单成功，订单金额：1499
req: http://127.0.0.1:8088/goods/v1/price
res: 1499
req: http://127.0.0.1:8088/order/v1/create
res: 创建订单成功，订单金额：1499
```

## 添加配置

## 添加依赖
```
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.0.4.RELEASE</version>
    </parent>
    
    <dependencies>
    
        <!-- 服务注册服务端 -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
        </dependency>
    
        <!-- 服务注册客户端 -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
    </dependencies>
    
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>2.0.4.RELEASE</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>Finchley.RELEASE</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
```

## 注意事项

1. 鉴权模块，关注是否存在会话漂移问题，如存在则需要做分布式会话改造
2. 定时任务模块，关注是否存在任务多节点重复执行问题，如存在则需要做定时任务幂等，保证一个业务任务只会执行一次
3. 部分微服务正常注册，部分微服务无法正常注册到 eureka 时，试试显示配置 `eueka.client.enabled` = true，用于覆盖依赖中配置的值 false
4. 依赖本地文件的微服务，需要改造为依赖外部文件系统
