icon:: 
color:: "#BDB76B"

- {{renderer :tocgen2, [[]], auto, 2}}
- collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.font-bold.blue.opacity-40"all.interview"]
  :query (and "interview" (and (not "alias")))
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show?  false
  :collapsed? true
  }
  #+END_QUERY
- #### 0. doc
	- [github-interview](https://github.com/huihut/interview#cc)
- #### 1. alg
  background-color:: blue
	- [[interview-alg]]
	- [hw](https://www.nowcoder.com/exam/oj/ta?page=1&tpId=37&type=37)    [nk-hw](https://www.nowcoder.com/exam/oj/ta?page=1&tpId=37&type=37)
- #### 2. linux
  background-color:: gray
	- [[linux]]
		- [[进程线程]]
- #### 3. 协议
  background-color:: yellow
	- [[TCP重传机制]]
- #### 4. lang
  background-color:: pink
	- [[cpp]]
		- [[cpp-caveat]]
	- [[golang]]
		- [[goroutine]]
- #### 5.db
	- [[MySQL 45]]
	- [[MySQL锁]]
	-
- Agenda
	- DONE init >[2023-03-14 00:00 - 20:59](#agenda://?start=1678723200000&end=1678798740000&allDay=false)
	  :LOGBOOK:
	  CLOCK: [2023-03-14 Tue 19:51:43]--[2023-03-14 Tue 19:51:43] =>  00:00:00
	  CLOCK: [2023-03-14 Tue 19:51:44]--[2023-03-14 Tue 19:51:45] =>  00:00:01
	  :END: