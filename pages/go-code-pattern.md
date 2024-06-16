- ```
  var errChan = make(chan error) // global
  type Workder struct {
  	prallel int	
      worker chan struct{}
  }
  
  func (w *Worker) Run(run func()) {
  	select {
  	case w.worker <- struct{}{}:
  		go func() {
  			defer func() {
  				<-w.worker
  			}()
  			run()
  		}()
  	default:
  		run()
  	}
  }
  
  // goroutine并行处理channel
  func find() {
  	//get todolist slice
      for _, iter := range slice {
      	wg.Add(1)
          func do() {
          	defer wg.Done()
              // ...  错误可丢进 errChan
          }
          w.Run(do)
      }
      wg.wait()
  }
  
  // 调用
  func op () {
  	// .... pre op
  	go func() {
  		defer close(errChan)
  		// call func find() op slice
          _, err := find()
  		errChan <- nil
  	}()
  
  	if <-errChan != nil {
  		return err
  	}
      return nil;
  }  
  ```