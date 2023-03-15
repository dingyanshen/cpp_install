#! /bin/bash

trim() {
    str=""

    if [ $# -gt 0 ]; then
        str="$1"
    fi
    echo "$str" | sed -e 's/^[ \t\r\n]*//g' | sed -e 's/[ \t\r\n]*$//g'
}

os=$(trim $(cat /etc/os-release 2>/dev/null | grep ^ID= | awk -F= '{print $2}'))
if [ "$os" = "ubuntu" ];then
    echo "local ubuntu"
    cd ~
    sudo apt install  -y mongodb-server  
else
    echo "for aliyun ecs"
    cd ~
    yum -y install  git 
    #配置MongoDB的yum源
    cat > /etc/yum.repos.d/mongodb-org.repo<<EOF
[mongodb-org] 
name = MongoDB Repository
baseurl = https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.6/x86_64/
gpgcheck = 1 
enabled = 1 
gpgkey = https://www.mongodb.org/static/pgp/server-3.6.asc
EOF

yum list

#下载数据库软件
yum -y install  mongodb-org  


fi





systemctl start mongod
#下载leanote软件
git clone https://gitee.com/cpp-njuer-org/leanote_bin.git
#get https://nchc.dl.sourceforge.net/project/leanote-bin/2.6.1/leanote-linux-amd64-v2.6.1.bin.tar.gz

#解压
tar -zxvf leanote_bin/leanote-linux-amd64-v2.6.1.bin.tar.gz -C ./
#配置 把app.secret该项的值改为时间字符串，避免安全问题
# vim leanote/conf/app.conf  将app.secret该项的值改为任意字符串
sed -i "1,99s/app.secret/app.secret =$(date +%s%N)     # /g" leanote/conf/app.conf
#初始化
sudo mongorestore -h localhost -d leanote --dir ~/leanote/mongodb_backup/leanote_install_data/

#leanote 启动
sudo nohup bash ~/leanote/bin/run.sh > ~/leanote/run.log 2>&1 &
#在浏览器中访问http://ECS公网IP地址>:9000。默认管理用户为admin，密码为abc123。
#也可在下载的客户端里 填自建服务 http://ip:9000 用户为admin，密码为abc123。

echo "#leanote  
-在浏览器中访问http://ECS公网IP地址>:9000。默认管理用户为admin，密码为abc123。
-也可在下载的客户端里 填自建服务 http://ip:9000 用户为admin，密码为abc123。
"






#用空指令写的注释 关于如何数据备份与在新机器上恢复
:<<EOF 

在原机器上备份leanote数据
sudo mongodump --port 27017 --db leanote -o ~/leanoteBackUp/

将备份数据拷贝到新机器上
sudo scp -r ~/leanoteBackUp root@xx.x.xxx.xx:/root

回去新机器上，先关闭leanote服务，直接杀进程
sudo ps aux|grep leanote 查看最左边进程号
sudo kill -9 进程号

恢复备份数据
sudo mongorestore -h 127.0.0.1:27017 -d leanote ~/leanoteBackUp/leanote  # -u=root -p=xxxx

重新启动leanote服务
sudo nohup bash ~/leanote/bin/run.sh > ~/leanote/run.log 2>&1 &

EOF
