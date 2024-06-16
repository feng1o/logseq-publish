- ```
  type ElasticMetricEpxireDays struct {
  |   Result map[string]ElasticMetricOptions `json:"result"`
  |   Status int                             `json:"status"`
  }
  
  type ElasticMetricOptionsx struct {
  |   Options struct {
  |   |   ExpireDays int `json:"expire_day"`
  |   } `json:"options"`
  }
  
  type ElasticMetricOptions struct {                                                                                                                                                                                           
  |   Options struct {
  |   |   ExpireDays interface{} `json:"expire_day"`
  |   } `json:"options"`
  }
  
  
  func getMetricExpireDays(es, inst string) (days int, err error){
  
  	//resp, err := http.Get("http:.242:9200/_metric/7b658c12-d12e-11e8-9136-6c0b84be0ace")
  	resp, err := http.Get("http://"+es + "/_metric/" + inst)
  	if err != nil {
  		fmt.Printf("[alarm] request err, %s", err)
  		return
  	}
  	bodyBytes, err := ioutil.ReadAll(resp.Body)
  	if err != nil {
  		fmt.Println(" read http resp err, %s", err)
  		return
  	}
  
  	fmt.Println("res " , string(bodyBytes))
  	var esExpireday ElasticMetricEpxireDays
  	err = json.Unmarshal(bodyBytes, &esExpireday)
  	if err != nil {
  		return
  	} else if esExpireday.Status != http.StatusOK {
  		err = fmt.Errorf("get ex expireday err %d", esExpireday.Status)
  		return
  	}
  
  
  	x := inst
  	//return esExpireday.Result.(map[string]ElasticMetricOptions)["result"].Options.ExpireDays,nil
  	switch esExpireday.Result[x].Options.ExpireDays.(type) {
  	case string:
  		fmt.Println("string")
  		if v, ok := esExpireday.Result[x].Options.ExpireDays.(string); ok {
  			fmt.Println(" string, v: ", v)
  		}
  	case int64:
  		fmt.Println("int64")
  		if v, ok := esExpireday.Result[x].Options.ExpireDays.(int64); ok {
  			fmt.Println(" int64, v: ", int(v))
  		}
  	case float64:
  		fmt.Println("float64")
  		if v, ok := esExpireday.Result[x].Options.ExpireDays.(float64); ok {
  			fmt.Println(" float64, v: ", int(v))
  		}
  	default:
  		fmt.Println("unknown")
  	}
  	return int(esExpireday.Result[x].Options.ExpireDays.(int)),nil
      
      
      
  {"sn":1,"ls":false,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"sc":0,"w":"还"}]},{"bg":0,"cw":[{"sc":0,"w":"有点"}]},{"bg":0,"cw":[{"sc":0,"w":"眼熟"}]}]}
  func RecResultJsonToPlain() {
      var recResult string
      var dat map[string]interface{}
      json.Unmarshal([]byte(json_str), &dat)
   
      if v, ok := dat["ws"]; ok {
          ws := v.([]interface{})
          for i, wsItem := range ws {
              wsMap := wsItem.(map[string]interface{})
              if vCw, ok := wsMap["cw"]; ok {
                  cw := vCw.([]interface{})
                  for i, cwItem := range cw {
                      cwItemMap := cwItem.(map[string]interface{})
                      if w, ok := cwItemMap["w"]; ok {
                          recResult = recResult + w.(string)
                      }
                  }
              }
          }
      }
      fmt.Println(recResult)
  }
  ```
- ```
  1.断言：
  	value, ok := x.(T)
  		x：一个接口的类型，T：一个具体的类型（可为接口类型）；
  		T 是具体类型struct，检查 x 的动态类型是否等于具体类型 T；成功，返回的结果value是 x 的动态值，其类型是 T。如果 x, ok := x.(T)，那么返回的x就覆盖了x
  		T 是interface，检查 x 的动态类型是否满足 T接口。如成功，x 的动态值不会被提取，返回值是一个类型为 T 的接口值。
          
  2.只能对接口类型的表达式做类型断言
  ```
- golang type assert
	- ![image.png](../assets/image_1663923094840_0.png){:height 151, :width 679}
	- ![image.png](../assets/image_1663923116221_0.png){:height 484, :width 486} ![image.png](../assets/image_1663923128695_0.png){:height 924, :width 372}
	- ![image.png](../assets/image_1663923147453_0.png){:height 505, :width 665}