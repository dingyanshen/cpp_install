# ubuntu  安装一系列软件

# # 换apt软件源 

```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
sudo sed -i 's/cn.archive.ubuntu.com/mirrors.nju.edu.cn/g' /etc/apt/sources.list
sudo sed -i 's/archive.ubuntu.com/mirrors.nju.edu.cn/g' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirrors.nju.edu.cn/g' /etc/apt/sources.list

sudo apt update
```

# # curl wget 下载工具

```
sudo apt install -y curl wget
```

# # tmux 终端分屏工具
```
#下载 配置
sudo apt install -y tmux git
cd ~ && git clone https://gitee.com/cpp-njuer-org/book
cd ~ &&  cp ~/book/install/.tmux.conf ~

```

# # zsh oh-my-zsh Shell工具
```
#下载 配置

sudo apt install -y zsh
sh -c "$(wget -O- https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh)"
echo "alias ta='tmux attach-session -t 0 || tmux ' " >> .zshrc
#注销重登后 可用ta进入tmux session0 .前缀按键pre= ctrl+a, pre+c创建新面板,pre+"分屏,pre+k选上面,pre+j选下面,pre+1选择第一,pre+n选择第n,pre+d脱离会话，ta返回会话。 
```
# # caps lock -> ctrl
sudo apt install -y gnome-tweak-tool
左下角-优化-键盘和鼠标-其它布局选项-大写锁定行为-大写锁定也是ctrl键


# # sougou 方便输入中文
```
#https://pinyin.sogou.com/linux/help.php
#下载链接会时不时更新 可用浏览器点开网页 https://pinyin.sogou.com/linux/  下载
sudo apt update
sudo apt install -y fcitx
#点击左下角菜单选择语言支持，将语言选择为fcitx
sudo cp /usr/share/applications/fcitx.desktop /etc/xdg/autostart/
sudo apt purge -y ibus
sudo dpkg -i 下载/sogoupinyin_3.4.0.9700_amd64.deb 
sudo apt install -y libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2
sudo apt install -y libgsettings-qt1
#注销重登或reboot

```

# # git gcc g++ gdb build-essential
```
sudo apt install -y git gdb cmake ctags g++ g++-10
sudo apt install -y  build-essential

```


# # vim
```
#vim-gtk 支持剪切板
sudo apt install -y vim-gtk
#可安装spf13 vim插件 若连外网不方便 直接下载解压这里编译好的文件
#浏览器打开 https://box.nju.edu.cn/d/acaf1abcec314a788c2c/ 下载两个文件vim_user.tar.gz vim_root.tar.gz
tar xvzf 下载/vim_user.tar.gz -C /home/user
sudo tar xvzf 下载/vim_root.tar.gz -C /root

```

```

#若你的用户名不是user而是owner，如下操作改变文件链接
$ rm .vimrc.before
$ ln -s /home/owner/.spf13-vim-3/.vimrc.before ./
$ rm .vimrc.bundles
$ ln -s /home/owner/.spf13-vim-3/.vimrc.bundles ./

```





# # vscode
```
sudo sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main">>/etc/apt/sources.list.d/vscode.list' 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo apt-get update
sudo apt-get install -y code

```

# # chrome
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb 

```


# # 给pip改源 pip.conf存到$HOME/.config/pip/pip.conf 

```
sudo apt install -y  python3-pip
mkdir -p ~/.config/pip
cat >> ~/.config/pip/pip.conf<<EOF
[global]
index-url = https://mirrors.nju.edu.cn/pypi/web/simple
format = columns
EOF

```



# # terminal-leetcode. 可用命令行刷leetcode 用不到就不装

```
pip install terminal-leetcode 
pip install testresources
echo "export PATH=./:\$HOME/bin:\$HOME/.local/bin:/usr/local/bin:\$PATH   ">>.zshrc

mkdir -p ~/.config/leetcode/snippet
cat > ~/.config/leetcode/config.cfg<<EOF
[leetcode]
ext=cpp
tmux_support=true
EOF

cat > ~/.config/leetcode/snippet/after<<EOF

int main() {
    Solution s;

    return 0;
}
EOF


cat > ~/.config/leetcode/snippet/before<<EOF
#include <iostream>
#include <vector>
using namespace std;
EOF



#chrome登录一下 leetcode.com . 终端里敲leetcode即可 jk1234选题 l进入题目 e编辑代码 s提交验证代码

```


# # tex-live. 用于写latex的工具 用不到可以不装
```
#wget https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/texlive2021-20210325.iso
wget https://mirrors.nju.edu.cn/CTAN/systems/texlive/Images/texlive2021-20210325.iso
sudo mount texlive2021-20210325.iso  /mnt
sudo /mnt/install-tl
#按I开始安装 很久 20分钟

cat>>~/.zshrc<<EOF
export PATH=/usr/local/texlive/2021/bin/x86_64-linux:\$PATH
export MANPATH=/usr/local/texlive/2021/texmf-dist/doc/man:\$MANPATH
export INFOPATH=/usr/local/texlive/2021/texmf-dist/doc/info:\$INFOPATH
EOF
```

# # mupdf 可用vim模式控制的pdf浏览器 用不到可以不装
```
sudo apt install -y mupdf

```

# # 在pdf上绘图版手写
```
sudo apt install -y xournal

```


# # 录屏工具 OBS用不到可以不装

```
sudo apt install -y ffmpeg

#After installing FFmpeg, install OBS Studio using:

sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install  -y obs-studio
```

