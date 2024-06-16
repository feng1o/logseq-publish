- ```
  for x range slice { a = &x}, x的地址不会变是最后一个，需临时变量后去
  ```
- ##### 1. is pointer to interface, not interface #interview
	- interface不可传指针，comment:: 主要是接收器 [doc](https://stackoverflow.com/questions/44370277/type-is-pointer-to-interface-not-interface-confusion) **为了方便记忆，可以这样去理解：实现了接收者是值类型的方法，就会自动实现[[$red]]==接收者是指针类型==的方法。而实现了指针类型的方法，不会自动生成对应的值类型方法。这点在给接口赋值时需要注意。**一定要检查类型的方法是值接收者还是指针接收者
	- ![image.png](../assets/image_1663234757764_0.png){:height 252, :width 474}
	- tip:: 实现了值类型接收器的方法，也实现了指针类型； 反之不行。顾interface一般是不会用指针  
	  [这里分析](https://golang.design/go-questions/interface/receiver/)为什么值类型接收者不能调用某个方法？ 实际上是吧一个obj赋值给interface(那就是这个ojb是否实现了interface?比如可能定义了一个值类型接收器的方法，那指针的也有，就可以传任何类型的，但是只定义了指针类型接收器方法，值类型就不行，因为值类型的没实现对应方法就不是这个interface)
- 2. [为什么map要make，new呢？](https://studygolang.com/topics/11907) #interview
	- tip:: 其实没太大区别，new只是返回任何类型的*T指针，可简单理解为提供了一个语法直接可以初始化一个指向对象指针的变量？
- 3. [map底层实现？ todo](https://yangxikun.com/golang/2019/10/07/golang-map.html)
- id:: 6388344b-7aa5-43ec-bb59-203abc567cf9
  4. [[go-slice]]  <a href=https://polarisxu.studygolang.com/posts/go/action/interview-slice-json/ class="pefect alg-3stars">go中的json slice问题，json发序列默认值问题</a>
- id:: 63f859a9-3219-4740-897a-774254c56dd9
  5.性能问题:: [[sync.pool]]   一句话总结：保存和复用临时对象，减少内存分配，降低 GC 压力。 [doc-参考](https://geektutu.com/post/hpg-sync-pool.html)
	- [[sync.Pool]] 用于存储那些被分配了但是没有被使用，而未来可能会使用的值。这样就可以不用再次经过内存分配，可直接复用已有对象，减轻 GC 的压力，从而提升系统的性能。
- 6.uintptr和unsafe.point区别 #interview
  id:: 640d674f-4808-4ce6-ac6e-35c69c46eb31
	- unsafe.Pointer只是单纯的通用指针类型，用于转换不同类型指针，它不可以参与指针运算；
	- 而uintptr是用于指针运算的，GC 不把 uintptr 当指针，也就是说 uintptr 无法持有对象， uintptr 类型的目标会被回收；
	- unsafe.Pointer 可以和 普通指针 进行相互转换；
	- unsafe.Pointer 可以和 uintptr 进行相互转换。
- card-last-interval:: 9.28
  card-repeats:: 3
  card-ease-factor:: 2.32
  card-next-schedule:: 2024-03-07T09:37:09.717Z
  card-last-reviewed:: 2024-02-27T03:37:09.717Z
  card-last-score:: 3
  7. 空struct{}有什么用？ #interview #card
	- 空结构体 struct{} 实例不占据任何的内存空间。一是节省资源，二是空结构体本身就具备很强的语义，即这里不需要任何值，仅作为占位符
		- map实现set，比如map[string]struct{} --- 这样可以节约空间，即时bool也要1byte
		- 不发送数据的channel  `chan struct{}`
		- 仅包含方法的结构体  type xxx struct{}
- card-last-interval:: 9.28
  card-repeats:: 3
  card-ease-factor:: 2.32
  card-next-schedule:: 2024-03-07T09:37:21.244Z
  card-last-reviewed:: 2024-02-27T03:37:21.244Z
  card-last-score:: 3
  8. init函数作用、原理 #interview #card
	- 初始化不能采用初始化表达式初始化的变量。
	- 程序运行前的注册。
	- 实现sync.Once功能。
	- 特点
		- init函数先于main函数自动执行，不能被其他函数调用；
		- init函数没有输入参数、返回值；
		- 每个包可以有多个init函数；
		- **包的每个源文件也可以有多个init函数**，这点比较特殊；
		- 同一个包的init执行顺序，golang没有明确定义，编程时要注意程序不要依赖这个执行顺序。
		- 不同包的init函数按照包导入的依赖关系决定执行顺序。
- card-last-interval:: 8.32
  card-repeats:: 3
  card-ease-factor:: 2.08
  card-next-schedule:: 2024-03-06T10:38:56.455Z
  card-last-reviewed:: 2024-02-27T03:38:56.455Z
  card-last-score:: 3
  9. go的局部变量是在堆上还是栈上？函数返回局部变量的指针是否安全？  #interview #card
	- [[逃逸分析]] ((641027d6-0404-4730-a70f-1b1e3f21004b))
	- 这也是其区分c++的一个点，
	-
- card-last-interval:: 8.32
  card-repeats:: 3
  card-ease-factor:: 2.08
  card-next-schedule:: 2024-03-06T10:37:31.718Z
  card-last-reviewed:: 2024-02-27T03:37:31.718Z
  card-last-score:: 3
  10. go的两个interface可以比较吗？ #interview #card
	- 空interface是不可以直接比较的。 但是空interface实例可比，什么类都可以给interface。  但是可以reflect反射比较操作
- card-last-interval:: 8.32
  card-repeats:: 3
  card-ease-factor:: 2.08
  card-next-schedule:: 2024-03-06T10:38:49.288Z
  card-last-reviewed:: 2024-02-27T03:38:49.288Z
  card-last-score:: 3
  11. [go两个nil是相等的吗](https://static.kancloud.cn/qq5202056/gomianshi/2657210)？ #interview #card
	- Go中两个Nil可能不相等。
	- 接口(interface) 是对非接口值(例如指针，struct等)的封装，内部实现包含 2 个字段，类型 T 和 值 V。一个接口等于 nil，当且仅当 T 和 V 处于 unset 状态（T=nil，V is unset）。
	- 两个接口值比较时，会先比较 T，再比较 V。 接口值与非接口值比较时，会先将非接口值尝试转换为接口值，再比较。
	- ```
	  func main() {
	  	var p *int = nil
	  	var i interface{} = p
	  	fmt.Println(i == p) // true
	  	fmt.Println(p == nil) // true
	  	fmt.Println(i == nil) // false
	  }
	  ```
	- 这个例子中，将一个nil非接口值p赋值给接口i，此时,i的内部字段为(T=*int, V=nil)，i与p作比较时，将 p 转换为接口后再比较，因此`i == p`，p 与 nil 比较，直接比较值，所以`p == nil`。
	- 但是当 i 与nil比较时，会将nil转换为接口(T=nil, V=nil),与i(T=*int, V=nil)不相等，因此`i != nil`。因此 V 为 nil ，但 T 不为 nil 的接口不等于 nil。
	- card-last-score:: 3
	  card-repeats:: 3
	  card-next-schedule:: 2024-03-06T10:38:52.719Z
	  card-last-interval:: 8.32
	  card-ease-factor:: 2.08
	  card-last-reviewed:: 2024-02-27T03:38:52.720Z
	  12. 简述 Go 语言GC(垃圾回收)的工作原理 #interview #card
		- ((641027d6-eca2-4e26-a264-3403c6768eb0))
		- {{embed ((641027d6-a4b0-49ec-a951-a4486cbfce0c))}}
- card-last-interval:: 8.32
  card-repeats:: 3
  card-ease-factor:: 2.08
  card-next-schedule:: 2024-03-06T10:38:59.704Z
  card-last-reviewed:: 2024-02-27T03:38:59.704Z
  card-last-score:: 3
  13. [非接口的任意类型 T() 都能够调用 *T 的方法吗？反过来呢](https://gfw.go101.org/article/unofficial-faq.html#method-set-relation)？  #interview #card
	- 一个`T`类型的值可以调用为`*T`类型声明的方法，但是仅当此T的值是[[$red]]==可寻址==(addressable) 的情况下。编译器在调用指针属主方法前，会自动取此T值的地址。因为[[$red]]==不是任何T值都是可寻址==的，所以并非任何T值都能够调用为类型`*T`声明的方法。
	- 反过来，一个`*T`类型的值可以调用为类型T声明的方法，这是因为解引用指针总是合法的。事实上，你可以认为对于每一个为类型 T 声明的方法，编译器都会为类型T自动隐式声明一个同名和同签名的方法
	- 所以很合理的， `*T`的方法集总是`T`方法集的超集，但反之不然。
	- 哪些值是不可寻址的呢？
	  	字符串中的字节；
	    	map 对象中的元素（slice 对象中的元素是可寻址的，slice的底层是数组）；
	    	常量；
	    	包级别的函数等
- card-last-interval:: 8.32
  card-repeats:: 3
  card-ease-factor:: 2.08
  card-next-schedule:: 2024-03-06T10:39:07.203Z
  card-last-reviewed:: 2024-02-27T03:39:07.203Z
  card-last-score:: 3
  14. [[channel]]问题 ？ ((641027d6-e2de-4235-94ac-556b58e14f9c)) #interview #card 
  无缓冲的 channel 和有缓冲的 channel 的区别？
- card-last-interval:: 9.28
  card-repeats:: 3
  card-ease-factor:: 2.32
  card-next-schedule:: 2024-03-07T09:39:33.538Z
  card-last-reviewed:: 2024-02-27T03:39:33.538Z
  card-last-score:: 3
  15.  Go 可以限制运行时操作系统线程的数量吗？ #interview #card
	- 默认1w.
	- `GOMAXPROCS` 限制的是同时执行用户态 Go 代码的操作系统线程的数量，但是对于被系统调用阻塞的线程数量是没有限制的。`GOMAXPROCS`
	   的默认值等于 CPU 的逻辑核数，同一时间，一个核只能绑定一个线程，然后运行被调度的协程。因此对于 CPU 
	  密集型的任务，若该值过大，例如设置为 CPU 逻辑核数的 2 倍，会增加线程切换的开销，降低性能。对于 I/O 
	  密集型应用，适当地调大该值，可以提高 I/O 吞吐率
- 16. [编译注释](https://segmentfault.com/a/1190000016743220)pragma:: //go:noinline 内联  go:nosplit 栈溢出检查跳过  go:noescap 逃逸检查结束释放all、减少gc压力
- 17. Go的mutex有几种模式？ 饥饿模式starvation，普通模式。饥饿模式更公平，丢到队列尾部，静止自旋释放cpu。触发条件，当一个mutex等待超过1ms就进入饥饿模式，如果获得锁并且是最后一个goroutine就会进入普通模式，[quote](https://blog.csdn.net/qq_37102984/article/details/115322706)
-