- ```
  awk '/DATA BEGIN/, /DATA END/' input.txt
  awk '/DATA BEGIN/{ f = 1 } f; /DATA END/{ f = 0 }' input.txt
  ```
- {{embed ((63777d7e-047c-4438-930c-a59a5d39e32d))}}
- 传var:  `awk '$2=="'${partition_id}'"')`
-