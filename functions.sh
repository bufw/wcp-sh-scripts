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



