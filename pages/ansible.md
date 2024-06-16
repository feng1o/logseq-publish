- [ansible quick run](https://www.cnblogs.com/f-ck-need-u/p/7567417.html)
- ansbile模块
	- [[package]]
		- ansible localhost -m setup | grep ansible_pkg_mgr  可查询系统使用什么管理包、比如yum、dnf、apt
		- 比如使用localhost安装:  ansible localhost -m package -a "name=openssl-devel state=present"
	- ```
	  ansible-playbook -i /opt/install-mount-419eab75/install/client_nodelist /opt/install-mount-419eab75/install/playbook_install_cluster.yml
	  
	  vim /root/install-dir/ibm-spectrum-scale-install-infra/roles/zimon/node/tasks/yum/install.yml # 这个yum里安装的内容
	  TASK [zimon/node : install | (3 yum)  Install GPFS Zimon packages 
	        scale_install_all_packages: 
	         ['/usr/lpp/mmfs/127.x.0.1/zimon_rpms/rhel8//gpfs.gss.pmcollector-5.1.7-1.el8.x86_64.rpm', '/usr/lpp/mmfs/127.x.0.1/zimon_rpms/rhel8//gpfs.gss.pmsensors-5.1.7-1.el8.x86_64.rpm']
	         scale_disable_gpgcheck 
	               "no"
	  
	  包管理器使用的是dnf
	  
	    # 从本地文件安装包
	    - name: install nginx from a local file
	      yum:
	        name: /usr/local/src/nginx-release-centos-6-0.el6.ngx.noarch.rpm
	        state: present
	      ignore_errors: True
	      yum repolist enabled -v
	   
	   ansible  all-hosts -i   /opt/install-mount-419eab75/install/client_nodelist  -m shell -a "ls /"
	  ```
