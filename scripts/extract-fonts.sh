#!/bin/bash

identifier="extract-script"

current_dir=$(pwd)
parent_dir=$(dirname "$current_dir")
store_dir="${parent_dir}/store"
extract_dir="${parent_dir}/output"


debug_info() {
    echo $current_dir
    echo $parent_dir
    echo $store_dir
    echo $extract_dir
}


red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

print_info() {
    echo "${red}$identifier: ${green}$*${reset}" 
}

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
                echo "⛔️ Invalid!, Please answer [y]es or [n]o.";;
        esac
    done

    return $choice
}


#debug_info

print_info $store_dir

mkdir -p $extract_dir
rm -rf $extract_dir/*

find_command="find $store_dir -name '*.zip' -type f"
print_info "Run: \t" $find_command

zip_count=0

OIFS="$IFS"
IFS=$'\n'

count=0
#for file in `find $store_dir -name '*.zip' -type f`; 
for file in `eval $find_command`;
do
    echo "👉 ${green}$file${reset}"
    target=${file%.zip}

    unzip $file -d $extract_dir/${target##*/}
    ((count++))
done


echo "\n"
echo "✅ Done extracting $count files"
echo "👉 Output dir: $extract_dir"
sleep 1

echo
read_confirm "Open output dir?"
ret=$?
if [ $ret == 1 ]
then
    echo
    echo "🎁 Opening the output path..."
    open $extract_dir
    sleep 1
fi


IFS="$OIFS"

print_info "Done..."
echo
