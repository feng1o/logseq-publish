- 1. <a class=ask>  nvme看util不准?</a> <span class=" bg-green white  subw hblack hover"> [[2022-08-22 Mon]] </span>
	- 这IO不太准的，即使单盘util 100%也不能说明到了上限;   svrtm也不准，是通过一段时间ios/时间，计算的，并行度高的时候反而svrtm小 [doc](https://brooker.co.za/blog/2014/07/04/iostat-pct.html)
	- iostat的util使用率，代表着磁盘的繁忙程度。对于机械磁盘HDD，可以反应性能指标；对于SSD（支持并行IO），无法反应性能指标 [doc](https://blog.51cto.com/wendashuai/2511043)
- 2.  <a class=ask>avgqu-sz和繁忙</a> 排队队列，越长await时间肯定越大
  3. - <a class=ask>avgrq-sz</a>  表示多少个pattern扇区512bytes，是大IO还是小IO; 大IO那需要的单次工作也会变大
  4. - <a class=ask>await多大合适</a>  包括io时间和kernerl中的wait时间 [doc](http://linuxperf.com/?p=156)
- [[jquota]]