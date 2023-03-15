
#! /bin/bash

trim() {
    str=""

    if [ $# -gt 0 ]; then
        str="$1"
    fi
    echo "$str" | sed -e 's/^[ \t\r\n]*//g' | sed -e 's/[ \t\r\n]*$//g'
}

os=$(trim $(cat /etc/os-release 2>/dev/null | grep ^ID= | awk -F= '{print $2}'))
cd ~
if [ "$os" = "ubuntu" ];then
    echo "ubuntu"
    yum install -y git 
    git clone https://gitee.com/cpp-njuer-org/book
 
    sudo apt install -y  tmux rsync g++ gdb vim git zsh
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
    sudo yum install -y tmux rsync g++ gdb vim git zsh
fi

cd ~
cp ~/book/install/.tmux.conf ~

sh -c "$(wget -O- https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh)"
cat>>~/.zshrc<<EOF
alias ta='tmux attach-session -t 0 || tmux ' 
EOF
source ~/.zshrc
