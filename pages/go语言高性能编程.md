icon:: 🌈

- [go高性能编程-online-doc](https://geektutu.com/post/hpg-sync-pool.html)   [7days实现geeRPC](https://geektutu.com/post/geerpc.html)  [7days实现geeORM](https://geektutu.com/post/geeorm.html)
- 性能分析
	- benchmark、pprof
- 常用数据结构
	- 字符串拼接::
	- 切片:: 注意切片的gc、打的slice被一个小的截取，用copy更好，慎重
	- for和range:: range是复制，所以小的struct obj或者没去区别，但是打的struct range会很慢
	- 内存对齐:: 合理的[[内存对齐]]可以提高内存读写的性能，并且便于实现变量操作的原子性。unsafe.Sizeof(demo1{})
		- unsafe.Alignof
- [并发编程](https://geektutu.com/post/hpg-mutex.html)
	-
-