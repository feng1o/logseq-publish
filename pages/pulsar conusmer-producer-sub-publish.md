# Pulsar的生产者、消费者、订阅和订阅模式
- Pulsar是建立在发布订阅模式上的，Producer将消息发布到Topic，Consumer订阅Topic，处理接收消息，并在处理完成时发送确认(ACK)
## [](https://blog.frognew.com/2021/10/learning-apache-pulsar-05.html#消费者consumer) 消费者(Consumer)
- Consumer也是一个连接到Pulsar Broker(或Pulsar 
  Proxy)上的进程，是从Broker接收消息的进程，Consumer成功处理了一条消息后需要向Broker发送确认(ACK)，以让Broker知道消息已经被接收和处理，如果Broker在预先设置的时间范围内没有收到确认(ACK)，
  Broker可以将消息重新发送订阅该Topic的Consumer
- Consume成功处理了消息，需要发送确认给Broker，通知Broker可以丢弃这个条消息了。
  消息的确认可以一个接一个，也可以累积确认(cumulative ack)。累积确认时，Consumer只需要确认最后一条它收到的消息。 所有之前（包含此条）的消息都将被确认，都不会被再次重发给那个消费者。
## 订阅和订阅模式

一旦创建订阅，即使Consumer已断开连接，Pulsar仍然可以保存所有消息。 只有在Consumer确认消息被成功处理后，保留下来的消息才会被丢弃。
 `订阅是命名好的配置规则，指导消息如何投递给消费者` 。

Consumer订阅Topic的时候，通过 `订阅模式` 来控制消息的使用模式，指定如何将消息投递给一个组一个的或多个的Consumer。
一个Topic可以同时支持多个订阅，同一个Topic上的不同订阅可以使用不同的订阅模式。

Pulsar支持4种订阅模式:
	- exclusive(独占模式):: 适用于全局有序消费的场景
	- failover(故障转移模式，也叫灾备模式)
	- shared(共享模式):: 通过 round robin 轮询机制（也可以自定义）分发给不同的消费者
	- key-shared(基于key的共享模式)
- ## 消息重试与死信机制
- 重试 Topic 是一种为了确保消息被正常消费而设计的 Topic 。当某些消息第一次被消费者消费后，没有得到正常的回应，则会进入重试 Topic 中，当重试达到一定次数后，停止重试，投递到死信 Topic 中。