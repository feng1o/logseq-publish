- {{renderer :tocgen2, [[]], auto, 1}} #interview #card
  card-last-interval:: 4
  card-repeats:: 2
  card-ease-factor:: 2.22
  card-next-schedule:: 2024-03-02T03:36:51.935Z
  card-last-reviewed:: 2024-02-27T03:36:51.935Z
  card-last-score:: 3
- 1. c++每个对象的[[虚函数]]指针的地址是一样的吗？  是、指向[[虚函数表]]
- 2. [[inline]]函数可以是虚函数吗？ 都会替换吗？
	- 是的，不表现多态，编译期可以内联。
- 3. [[构造函数]]列表初始化和复制初始化区别？
	- 初始化直接初始化数据成员，赋值则先初始化再赋值
	- const对象或引用只能初始化但是不能赋值
- 4. 发送一个数据包要多少次内存拷贝，是深浅拷贝？ 从应用层发出去
-