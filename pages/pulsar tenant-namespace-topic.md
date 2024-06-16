- Pulsar被设计为一个多租户系统，租户可以跨集群分布，每个租户都可以有单独的认证和授权机制，可以针对租户设置存储配额、消息生存时间TTL和隔离策略。
  Pulsar的多租户功能使其可以为组织中的不同部门、不同团队提供安全且独占的消息服务，允许不同部门、不同团队之间共享
-
- ![image.png](../assets/image_1663212251262_0.png){:height 246, :width 440}
## 租户(Tenant)

租户可以跨集群分布，表了组织中特定的业务单元，产品线、核心功能，这些由组织不同的部门或团队负责。每个租户都可以有单独的认证和授权机制，可以针对租户设置存储配额、消息生存时间TTL和隔离策略。
## [](https://blog.frognew.com/2021/10/learning-apache-pulsar-04.html#命名空间namespace) 命名空间(Namespace)

命名空间是租户的管理单元，每个租户下可以创建多个命名空间。可以通过在命名空间上设置的配置策略来管理该命名空间下的Topic，这样就可以在命名空间的级别上为该命名空间的所有Topic设置访问权限、调整复制设置、管理跨集群跨地域的消息复制，控制消息过期时间。
- ## 主题(Topic)和分区主题(Partitioned Topic)
- topic是虚拟的，实际上比如topic有3个分区，写入是`my-topic-parition0 my-topic-partion1  my-topic-partition2`
- partition:: 是逻辑概念，实际存储单位是分片 segment
- 在Pulsar中所有消息的读取和写入都是和Topic进行，Pulsar的Topic本身并不区分 `发布订阅模式` 或者 `生产消费模式(独占, 一个消息只能被一个消费者消费)` ，Pulsar是依赖于各种 `订阅类型` 来控制消息的使用模式。
- ## [doc](https://blog.frognew.com/2021/10/learning-apache-pulsar-04.html#topic的url持久化topic和非持久化topic) Topic的URL，持久化Topic和非持久化Topic
  
  Pulsar Topic默认是持久化的，即会保存还没确认的消息到BookKeeper集群的bookies节点中。持久化Topic的消息数据可以在broker重启或者订阅者出问题的，故障转移之后继续存在。
  Pulsar还支持非持久性topic，这些topic的消息从不持久化存储到磁盘，只存在于内存中，当使用非持久topic分发时，关闭Broker或者关闭订阅者，非持久化Topic上所有的瞬时消息都会丢失，客户端可能会出现丢失消息的情况。