- golang里可能需要指定package [example](https://www.tizi365.com/archives/386.html)
- ```
  syntax = "proto3";
  
  package tpb;
  
  option go_package = "/go_t";
  
  // 
  message req_vars{
          int32       req_seq = 1;  
          string      name = 2;
  }
  ```
- > 注意：[1,15]之内的标识号在编码的时候会占用一个字节。[16,2047]之内的标识号则占用2个字节。所以应该为那些频繁出现的消息元素保留 [1,15]之内的标识号。切记：要为将来有可能添加的、频繁出现的字段预留一些标识号。
  reserved 2, 15, 9 to 11; // 保留2，15，9到11这些标识号
- pb2: 里有显示required和optional， 3里已都去掉，默认是optional的；  2里有hasXXX方法，3无