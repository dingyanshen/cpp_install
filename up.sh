#!/usr/bin/env bash

echo "
# 上传文件到南大 box.nju.edu.cn
# chmod +x ./up.sh
# up.sh -u 学号 -p 密码 -h https://box.nju.edu.cn -f 文件名 -d / -r 资料库网址中间repo形如e77e99c3-c692-42b5-a00e-fe35572c4d10 -t on
"


## ubuntu
#apt install -y jq
## centos
## yum install -y jq
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
    sudo apt install -y jq
   else
    echo "aliyun ecs"
    sudo yum install -y jq
fi


# this script depend on jq,check it first
RED='\033[0;31m'
NC='\033[0m' # No Color
if ! command -v jq &> /dev/null
then
    echo -e "${RED}jq could not be found${NC}, installed and restart plz!\n"
    exit
fi


usage () { echo "Usage : $0 -u <username> -p <password> -h <seafile server host> -f <upload file path> -d <parent dir default value is /> -r <repo id> -t <print debug info switch off/on,default off>"; }

# parse args
while getopts "u:p:h:f:d:r:t:" opts; do
   case ${opts} in
      u) USER=${OPTARG} ;;
      p) PASSWORD=${OPTARG} ;;
      h) HOST=${OPTARG} ;;
      f) FILE=${OPTARG} ;;
      d) PARENT_DIR=${OPTARG} ;;
      r) REPO=${OPTARG} ;;
      t) DEBUG=${OPTARG} ;;
      *) usage; exit;;
   esac
done

# those args must be not null
if [ ! "$USER" ] || [ ! "$PASSWORD" ] || [ ! "$HOST" ] || [ ! "$FILE" ] || [ ! "$REPO" ]
then
    usage
    exit 1
fi

# optional args,set default value

[ -z "$DEBUG" ] && DEBUG=off

[ -z "$PARENT_DIR" ] && PARENT_DIR=/

# print vars key and value when DEBUG eq on
[[ "on" == "$DEBUG" ]] && echo -e "USER:${USER} PASSWORD:${PASSWORD} HOST:${HOST} FILE:${FILE} PARENT_DIR:${PARENT_DIR} REPO:${REPO} DEBUG:${DEBUG}"

# login and get token
TOKEN=$(curl -s --location --request POST "${HOST}/api2/auth-token/" --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode "username=${USER}" --data-urlencode "password=${PASSWORD}" | jq -r ".token")

[ -z "$TOKEN" ] && echo -e "${RED}login seafile faild${NC}, call your administrator plz!\n" && exit 1

# gen upload link 
UPLOAD_LINK=$(curl -s --header "Authorization: Token ${TOKEN}" "${HOST}/api2/repos/${REPO}/upload-link/?p=${PARENT_DIR}" | jq -r ".")

[ -z "$UPLOAD_LINK" ] && echo -e "${RED}get upload link faild${NC}, call your administrator plz!\n" && exit 1

# upload file
UPLOAD_RESULT=$(curl -s --header "Authorization: Token ${TOKEN}" -F file="@${FILE}" -F filename=$(basename ${FILE}) -F parent_dir="${PARENT_DIR}" -F replace=1 "${UPLOAD_LINK}?ret-json=1")

[ -z "$UPLOAD_RESULT" ] && echo -e "${RED}faild to upload ${FILE}${NC}, call your administrator plz!\n" && exit 1

# print upload result
[[ "on" == "$DEBUG" ]] && echo -e "TOKEN:${TOKEN} UPLOAD_LINK:${UPLOAD_LINK} UPLOAD_RESULT:${UPLOAD_RESULT}"



## ubuntu
#apt install -y jq
## centos
## yum install -y jq
#chmod +x ./up.sh

#./up.sh -u <username> -p <password> -h <seafile server host> -f <upload file path> -d <parent dir default value is /,must be start with /> -r <repo id> -t <print debug info switch off/on,default off>
#复制代码

#参数说明

#-u seafile 用户名
#-p seafile 密码
#-h seafile 地址，xxx.xxx.com
#-f 需要上传的文件路径，比如/tmp/test.zip
#-d 上传目录，必须是/开头
#-r 资料库id
#-t 是否开启debug模式，如果是on 则会打印参数，否则啥都不打印

# 上传到南大 box.nju.edu.cn
#  up.sh -u 学号 -p 密码 -h https://box.nju.edu.cn -f 文件名 -d / -r 资料库网址中间repo形如e77e99c3-c692-42b5-a00e-fe35572c4d10 -t on
