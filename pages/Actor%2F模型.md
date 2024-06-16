title:: Actor/模型

- Actor模型share nothing   ----   MapReduce就是一种典型的Actor模式
- 不管任何并发模型其实都离不开的数据之间的交互，都需要通信，reactor，proactor 这两种模型都是通过共享内存来进行通信，而 actor 强调的是通过通信来共享内存，actor 强调的是没有共享，所有的线程之间都是消息传递来实现通信