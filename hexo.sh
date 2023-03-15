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
    echo "ubuntu"
    sudo apt update
    sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt -y install nodejs
    sudo apt -y install nginx

    sudo apt install -y  pandoc tmux rsync g++ gdb vim git 
    #sudo apt -y install npm
else
    echo "for aliyun ecs"
    cd ~
    yum install -y git 
    git clone https://gitee.com/cpp-njuer-org/book
    #cd ~/book/install/ecs/
    #cp ./AliYun.repo /etc/yum.repos.d
    #cp ./epel.repo /etc/yum.repos.d
    #cd ~
    sudo yum install -y npm nginx pandoc tmux rsync g++ gdb vim git 
fi

cd ~
#cp book/install/.vimrc.local ~/.vimrc
#yum install -y npm nginx pandoc tmux rsync g++ gdb vim git 
#wget https://cpp.njuer.org/tmux && mv tmux ~/.tmux.conf
cp ~/book/install/.tmux.conf ~

sudo service nginx start

git clone https://gitee.com/cpp-njuer-org/book
if [ "$os" = "ubuntu" ];then
    cp  book/install/.vimrc ~/.vimrc
    cat book/install/.vimrc.local >> ~/.vimrc.local
else
    cat book/install/.vimrc.local >> ~/.vimrc
fi



sudo npm install hexo-cli -g --registry=https://registry.npm.taobao.org

hexo init blog

cd blog
sudo npm install --registry=https://registry.npm.taobao.org
sudo npm install hexo-deployer-git --save --registry=https://registry.npm.taobao.org

cd ~


cd ~/blog && sudo hexo new "post"

#vim ~/blog/source/_posts/post.md
sudo hexo clean && sudo hexo g

#hexo server
if [ "$os" = "ubuntu" ];then
    sudo rsync -avhP ~/blog/public/  /var/www/html/ --delete
else
    sudo rsync -avhP ~/blog/public/  /usr/share/nginx/html/ --delete
fi


cd ~
echo "#临时博客  
-在浏览器中访问http://ECS公网IP地址
-若使用虚拟机安装运行，则浏览器输入http://127.0.0.1
"
