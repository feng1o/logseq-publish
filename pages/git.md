- [[CR]]
  collapsed:: true
	- ```
	  LGTM：Looks Good To Me「对我来说，还不错」表示认可这次PR，同意merge合并代码到远程仓库
	  ASAP：As Soon As Possible「尽快」
	  ACK：Acknowledgement「承认，确认，同意」i.e. agreed/accepted change
	  NACK/NAK：Negative acknowledgement「不同意」 i.e. disagree with change and/or concept
	  RFC：Request For Comments「请求进行讨论」 i.e. I think this is a good idea, lets discuss
	  WIP：Work In Progress 「进展中」常见词汇，这里作为 Best Practice 单独提出来，主要针对改动较多的 PR，可以先提交部分，标题或 Tag 加上 WIP，表示尚未完成，这样别人可以先 review 已提交的部分
	  AFAIK/AFAICT：As Far As I Know / Can Tell 「据我所知；就我所知」
	  IIRC：If I Recall Correctly「如果我没有记错的话」
	  IANAL：I am not a lawyer , but I smell licensing issues「我不是律师，不过感觉到了法律问题」
	  IMO：In My Opinion 「在我看来」
	  TL;DR：Too Long; Didn’t Read 「太长懒得看」README 文档常见。
	  PR/MR：Pull Request/Merge Request「合并请求」
	  CR：Code Review 「代码审查」
	  PTAL：Please Take A Look.「你来瞅瞅？」用来提示别人来看一下
	  TBR：To Be Reviewed「提示维护者进行 review」
	  TBD：To Be Done(or Defined/Discussed/Decided/Determined). 「未完成，将被做」根据语境不同意义有所区别，但一般都是还没搞定的意思。
	  TBH：To Be Honest 「老实说」
	  atm：at the moment 「现阶段」
	  
	  以下是大家补充的：
	  
	  u1s1：Have One Say One「有一说一」 
	  LMAO：Laugh My Ass Off「笑到我屁股都要掉了」
	  RTFM：Read The Fucking Manual「请认真阅读手册」
	  IMO -- Orz -> IMHO：In My Humble Opinion「依鄙人所见」 
	  FYI：For Your Information「供你参考」
	  
	  ditto
	  ```
- commit建议
	- > feat：新功能（feature）。
	  fix/to： fix：产生diff并自动修复此问题。适合于一次提交直接修复问题 to：只产生diff不自动修复此问题。适合于多次提交。最终修复问题提交时使用fix
	  docs：  style：  refactor：  perf  test    chore：构建过程或辅助工具的变动。
	  revert：回滚到上一个版本。
	  merge：代码合并。
	  sync：同步主线或分支的Bug。
- fatal: No configured push destination. 每次需要指定origin  master; git push -u origin  master即可更新
- windows和linux的换行问题：导致文件都改了，需要push；比如wsl系统里就有这个问题
	- git config --global core.filemode false
	- git config --global core.autocrlf true
- [git-first/next/pre-last](https://mp.weixin.qq.com/s/7HYl2XjONrEVBvZbcIPSCA)
  id:: 655437e4-54f2-4132-9226-8ca2396e53bb
- [[git-src-code]]