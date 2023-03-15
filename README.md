# Qt for WebAssembly

https://wiki.qt.io/Qt_for_WebAssembly

Emscripten是一个工具链，作用是通过LLVM来编译生成asm.js、WebAssembly字节码，目的是让你能够在网页中接近最快的速度运行C和C++，并且不需要任何插件。



#从git克隆项目至本地
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
git pull

#安装Qt5.15对应的1.39.8版本
sudo ./emsdk install 1.39.8
sudo ./emsdk activate  1.39.8
或//之后要安装多个版本共存 sudo ./emsdk activate --embedded 1.39.8
 
#应用版本修改环境变量
source ./emsdk_env.sh

#qt安装时要选择WebAssembly选项，或在qt维护工具里补选安装WebAssembly。

#qt里emscripten sdk配置在 工具-选项-设备-WebAssembly下面 填入git clone过来的本地目录地址如/home/user/emsdk
#点击应用，让Qt Creator 识别到emscripten的编译器


#注：若要在命令行下省略路径名，直接使用emcc，则可把路径加入.zshrc

cat >> ~/.zshrc<<EOF
export PATH=/home/user/emsdk:/home/user/emsdk/upstream/emscripten:/home/user/emsdk/node/14.18.2_64bit/bin:$PATH
export EMSDK=/home/user/emsdk                                                                          
export EM_CONFIG=/home/user/emsdk/.emscripten
export EMSDK_NODE=/home/user/emsdk/node/14.18.2_64bit/bin/node
EOF

# qt使用WebAssembly

代码不需要改变，只要在构建套件处选择带WebAssembely字样的套件如qt5.15.2WebAssembely。编译运行时，点左下角debug选择如qt5.15.2WebAssembely套件，再点左下三角形运行。
编译运行后，在debug目录，ln -s 项目名.html index.html 再将debug目录下所有东西传入网站目录即可，如ubuntu系统nginx下的/var/www/html ,如centos系统下的/usr/share/nginx/html/ 即可用浏览器使用ip在网上访问你的qt c++ 程序。












---------------------------------------------
#ubuntu安装环境
#安装C++的编译环境
sudo apt-get install build-essential
 
#安装libgl相关库
sudo apt-get insatll libgl1-mesa-dev libglu1-mesa-dev
 
#安装其他相关库
sudo apt-get install libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libx11-xcb-dev libxcb-glx0-dev libxkbcommon-x11-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev
 
#安装python环境
sudo apt-get install python
 
#安装jdk环境
sudo apt-get install openjdk-8-jdk
