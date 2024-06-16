- {{embed ((63778095-02d7-40fd-9f76-61973b719554))}}
- ```
  这种模式包含6个组件：
      proxy: 定义了客户端要调用的Active Object接口。当客户端调用它的方法是，方法调用被转换成method request放入到scheduler的activation queue之中。
      method request: 用来封装方法调用的上下文
      activation queue:待处理的 method request队列
      scheduler:一个独立的线程，管理activation queue，调度方法的执行
      servant:active object的方法执行的具体实现，
      future:当客户端调用方法时，一个future对象会立即返回，允许客户端可以获取返回结果。
  ```