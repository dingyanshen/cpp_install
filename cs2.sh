 #! /bin/bash

cd ~
yum install -y git vim g++ tmux
git clone https://gitee.com/cpp-njuer-org/codeserver
#cp codeserver/code-server-4.0.2-linux-amd64.tar.gz  ./
cat codeserver/code-server-4.0.2-linux-amd64.tar.gz.0* | tar xvzf -
#cd code-server-4.0.2-linux-amd64
echo "#vscode 网页版  
-在浏览器中访问http://ECS公网IP地址>:8080。密码为123456
"
export PASSWORD=123456 && ./code-server-4.0.2-linux-amd64/code-server --host 0.0.0.0 --port 8080

