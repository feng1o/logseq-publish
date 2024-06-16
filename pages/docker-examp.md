- ```bash
  docker run -p 3306:3306 --name mysql5.7 -v /data/docker/mysql/conf/:/etc/mysql/conf.d -v /data/docker/mysql/log/:/var/logs/mysql -v /data/docker/mysql/data:/var/lib/mysql  -e MYSQL_ROOT_PASSWORD=123456  -d mysql:5.7  --character-set-server=utf8mb4  --collation-server=utf8mb4_unicode_ci
  ```
-