- 也是基于事件驱动的一种并发模型，但 protacor 是异步的，在 IO 操作时，proactor 并发模型能够和操作系统之间解耦，由操作系统内核完成读写操作之后主动发送完成事件，这也是和 reactor 的最大区别
  title:: Proactor