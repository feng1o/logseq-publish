- ```cpp
  // for file lock
  #define RD_LOCK(fd) \
      LOCK_OP((fd), F_SETLKW, F_RDLCK)
  #define WR_LOCK(fd) \
      LOCK_OP((fd), F_SETLKW, F_WRLCK)
  #define UNLOCK(fd) \
      LOCK_OP((fd), F_SETLK, F_UNLCK)
  #define LOCK_OP(fd, cmd, type) \
  ({\
      struct flock lock; \
      lock.l_type = (type); \
      lock.l_start = 0; \
      lock.l_whence = SEEK_SET; \
      lock.l_len = 0; \
      int iret = fcntl((fd), (cmd), &lock);\
      iret; })
  
  inline void handler(int s)
  {
          LogMsg("[flock] in handler, do nothing\n");
          return;
  }
  
  template<typename T>
  int do_try_lock(T *t, const char *fname, int (T::*fn)(), int timeout) {
          int ret = 0;
          int fd;
          struct sigaction act, oact;
          memset(&act, 0, sizeof(act));
          memset(&oact, 0, sizeof(oact));
  
          if ((fd = open(fname, O_CREAT|O_RDWR, 0666)) == -1) {
                  LogError("open failed, %s \n", fname);
                  return EC::PROCESS_LOCK_ERR;
          }
          act.sa_handler = handler;
          sigemptyset(&act.sa_mask);
          act.sa_flags = 0;
          sigaction(SIGALRM, &act, &oact);
  
          LogMsg("[flock] timeout = %d \n", timeout);
          int sec = alarm(timeout);
          if (WR_LOCK(fd) == 0) {
                  alarm(sec);
                  sigaction(SIGALRM, &oact, NULL);
                  LogMsg("[flock] lock %s ok\n", fname);
                  ret = (t->*fn)();
                  UNLOCK(fd);
          } else {
                  alarm(sec);
                  sigaction(SIGALRM, &oact, NULL);
                  LogError("[flock] lock %s err.", fname);
                  SetErrorReturnErrorF(EC::PROCESS_LOCK_ERR, "install base lock dev err");
          }
          return ret;
  }
  
  ret = do_try_lock<CreateNode>(this, tmpLockFile.c_str(), &CreateNode::do_install_base, timeout);
  ```