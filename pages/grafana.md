- [02.audit-grafana.txt](../assets/02.audit-grafana_1668682420138_0.txt)
	- tip:: 数据每隔5分钟采集一次, 看不到最近的用time shift； 限制min doc cnt: 1
- <details> <summary>Title</summary>
  <code>
  {"result":{
    "audit_monitor_inst_info" : {
      "time" : {
        "name" : "timeInsert",
        "format" : "epoch_second"
      },
      "tags" : {
        "timestamp" : "date",
        "clusterName" : "string",
        "region" : "string",
        "userName" : "string",
        "instanceName" : "string",
        "product" : "string",
        "appId" : "string",
        "instanceId" : "string",
        "resourceId" : "string",
        "storageType" : "string",
        "storageSize" : "integer",
        "consumer" : "string"
      },
      "fields" : {
        "realSize" : "integer"
      },
      "options" : {
        "default_date_format" : "epoch_second",
        "expire_day" : 360,
        "refresh_interval" : "10s",
        "number_of_shards" : 10,
        "rolling_period" : 15
      }
    }
  }
  
  </code>
  </details>
- influxdb语法
  ```
  SELECT value FROM "vepfs_capacity" WHERE  "ResourceId" =~ /^$instance_id$/  AND $timeFilter GROUP BY *  
  ```
-