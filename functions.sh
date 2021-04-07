#! /bin/sh

Uncompress_targz()
{
    local FileName=$1
    local Target=$2
    #[[ -d "${Target}" ]] && rm -rf ${Target}
    echo "Uncompress ${FileName}..."
    tar zxf ${FileName} -C ${Target}
    if [ -n "${Target}" ]; then
        echo "cd ${Target}..."
        pushd ${Target}
    fi
}

red_echo() {
	echo -e "\033[31m$1 \033[0m"
}
green_echo() {
     echo -e "\033[32m$1 \033[0m"
}
yellow_echo(){
     echo -e "\033[33m$1 \033[0m"
}
blue_echo() {
    echo -e "\033[34m$1 \033[0m"
}

white_echo() {
   echo -e "\033[37m$1 \033[0m"
}



