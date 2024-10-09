#!/bin/bash

# main_script.sh
# this is a driver script
# invoke scripts based on inputs
# invoke the following scripts

current_dir=$(pwd)
parent_dir=$(dirname "$current_dir")
store_dir="${parent_dir}/store"
extract_dir="${parent_dir}/output"


read_confirm() {
    choice=-1
    while true; do
        echo
        read -n 1 -r -p "$1 [y]es, [n]o: " confirm
        echo 

        case $confirm in
            y|Y ) 
                choice=1
                break;;
            n|N ) 
                choice=0
                break;;
            * ) 
                echo "⛔️ Invalid!, Please answer [y]es or [n]o";;
        esac
    done

    return $choice
}

extract_script="extract-fonts.sh"
install_script="install-fonts.sh"

OIFS="$IFS"
IFS=$'\n'

sh print_info.sh 

read_confirm "Extract *.zip files?"
ret=$?
if [ $ret == 1 ] 
then
    echo
    echo "Extracting Fonts \t🎉 \n"
    sh $extract_script 
else
    echo "Skipping"
fi

read_confirm "Install Fonts?"
ret=$?
if [ $ret == 1 ]
then
    echo
    echo "Installing Fonts \t🚀 \n"
    sh $install_script 
    sleep 1
fi

IFS="$OIFS"

echo "Main: Exiting" 


