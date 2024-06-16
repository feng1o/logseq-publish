- `set -euxo pipefail`，它们可以帮助你写出更容易维护也更安全的脚本。这也是Bash脚本的终极调试手段
- [[sed]]
- [[awk]]
- [[echo color]]
- grep ALREADY_EXIST * -nrI
- ```apl
  find [path] [arguments] -exec [command] {} +  # +表示把所有的当做一个参数给命令一次执行，{} \; 这个是每个输入执行一次
  ```