#!/bin/bash

current_dir=$(pwd)
parent_dir=$(dirname "$current_dir")
store_dir="${parent_dir}/store"
extract_dir="${parent_dir}/output"


# use
# figlet -f banner "FONTS" > banner.txt
# to produce the banner
banner="${current_dir}/banner.txt"

echo_banner() {
    if [ -f $banner ]
    then
        cat $banner
    else
        echo "FONTS"
    fi
}

echo_info() {
    echo "-------------------------------------"
    echo "current_dir: \t$current_dir"
    echo 
    echo "parent_dir: \t$parent_dir"
    echo "store_dir: \t$store_dir"
    echo "extract_dir: \t$extract_dir"
    echo "banner: \t$banner"
    echo "-------------------------------------"
}


echo ""
echo_banner
echo_info


