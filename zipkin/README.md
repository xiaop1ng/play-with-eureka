# Zipkin

## Docker

> docker run -d -p 9411:9411 openzipkin/zipkin

## jar

[下载 zipkin](https://search.maven.org/remote_content?g=io.zipkin&a=zipkin-server&v=LATEST&c=exec)

**注意**：默认使用内存作为存储，重启后数据会丢失，一般使用外部数据源存储数据
> java -jar zipkin-server-2.24.2-exec.jar

## use

http://127.0.0.1:9411/zipkin/