- [doc](https://www.cnblogs.com/bakari/p/8560437.html)
- namespace 实现了 6 项资源隔离，基本上涵盖了一个小型操作系统的运行要素，包括主机名、用户权限、文件系统、网络、进程号、[[进程间通信]]
- 查看当前进程下有哪些 namespace 隔离，可以查看文件 /proc/[pid]/ns
- ```cpp
  int clone(int (*child_func)(void *), void *child_stack, int flags, void *arg);
  ```