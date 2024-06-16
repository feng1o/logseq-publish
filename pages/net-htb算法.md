- [htb算法简析+例子，基本介绍了怎么出包的](https://www.cnblogs.com/acool/p/7779159.html)
	- ```
	  htb是如何决策哪个类出包的？
	  1.htb算法从类树的底部开始往上找CAN_SEND状态的class.如果找到某一层有CAN_SEND状态的类则停止.
	  
	  
	  2.如果该层中有多个class处于CAN_SEND状态则选取优先级最高(priority最小)的class.如果最高优先级还是有多个class,
	  那就在这些类中轮训处理.每个类每发送自己的quantum个字节后,轮到下一个类发送.
	  
	  3.上面有讲到只有leafclass才可以缓存网络包,innerclass是没有网络包的.如果步骤1,2最终选到了innerclass怎么处理？
	  既然是innerclass,肯定有自己的subclass.innerclass会顺着树往下找,找到一个子孙leafclass.并且该leafclass处于
	  MAY_BORROW状态,将自己富余的令牌借给该leafclass让其出包.同样的道理,可能会有多个子孙leafclass处于MAY_BORROW状态,
	  这里的处理跟步骤2是一样的.
	  
	  多个子类共享父类带宽也就体现在这里了.假设父类富余了10MB, 子类1的quantum为30000,子类2的quantum为20000.
	  那么父类帮子类1发送30000byte,再帮子类2发送20000byte.依次循环.最终效果就是子类1借到了6MB,子类2借到了4MB.因此上文说,
	  当子类之间共享带宽时,rate/quantum共同决定它们分得的带宽.rate处于CAN_SEND状态时能发送多少字节,quantum决定处于
	  MAY_BORROW状态时可借用令牌发送多少字节.	
	  ```