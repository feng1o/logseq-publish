id:: 63777d7e-047c-4438-930c-a59a5d39e32d
```
sed -n '/DATA BEGIN/, /DATA END/p' input.txt
sed -n '/DATA BEGIN/, /DATA END/{ /DATA END/!p }' input.txt  # 不打印data END这行
sed -n '/DATA BEGIN/, /DATA END/{ /DATA BEGIN/! { /DATA END/! p } }' input.txt
```
