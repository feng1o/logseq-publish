[k8s包管理器](https://helm.sh/zh/docs/chart_best_practices/templates/):: [[$sub8-red]]==helm通常采用中心chart repository仓库+helm客户端的形式进行chart包的管理和应用（部署、升级、回滚等)==

	- ```bash
	  @mac:~/Documents/k8s/helm#tree testHelm
	  testHelm
	  ├── Chart.yaml
	  ├── charts
	  ├── templates
	  │   ├── NOTES.txt
	  │   ├── _helpers.tpl
	  │   ├── deployment.yaml
	  │   ├── hpa.yaml
	  │   ├── ingress.yaml
	  │   ├── service.yaml
	  │   ├── serviceaccount.yaml
	  │   └── tests
	  │       └── test-connection.yaml
	  └── values.yaml
	  ```
- [[#red]]==helm chart模板==： `helm install --dry-run --debug .`  可调式  [doc](https://helm.sh/zh/docs/chart_template_guide/getting_started/)
	- 变量 ::  {{ .Release.Name / .Values.xx | quote 管道引用""  }}，release是helm的内置对象
	- 模板控制流:: if else、with、range...
	- [[#red]]==命名模板==
		- ```
		  {{- define "mychart.labels" }}
		    labels:
		      from: helm
		      date: {{ now | htmlDate }}
		  {{- end }}
		  ```
		- 该模板嵌入到现有的 ConfigMap 中，然后使用`template`关键字{{- template "mychart.labels"   .(.表示作用域)}}
			- 一般不用template，[用include + indent](https://www.zhaowenyu.com/helm-doc/template-function/chart-include.html) `{{ include "xxxx.app" . | indent 2}}`，来解决对其问题
		- partial文件::  _helpers.tpl
			- templates 目录下面除了`NOTES.txt`文件和以下划线`_`开头命令的文件之外，都会被当做 kubernetes 的资源清单文件，而这个下划线开头的文件不会被当做资源清单外，还可以被其他 chart 模板中调用，这个就是 Helm 中的`partials`文件
- [helm hooks](https://helm.sh/zh/docs/chart_best_practices/templates/)
	- Hook 在资源清单中的 metadata 部分用 annotations 的方式进行声明：比如pre-install/post-install、post-delete...post-rollback
- ((64a8227f-be62-49a3-9e49-9d81ef21ff3d))
- chart 是 Helm 的应用打包格式。chart包含一系列文件，这些文件描述了 Kubernetes 部署应用时所需要的资源，比如 
  Service、Deployment、PersistentVolumeClaim、Secret、ConfigMap。也可以是部署整个应用，比如包含db、app等。chart将这些文件放在预定义目录中结构中，通常真个chart打包成tar，包含版本信息，便于 helm部署
-
-