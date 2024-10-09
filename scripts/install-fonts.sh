#!/bin/bash

identifier="insall-script"

current_dir=$(pwd)
parent_dir=$(dirname "$current_dir")
extract_dir="${parent_dir}/output"


if [[ `uname` == 'Darwin' ]]; then
    # MacOS
    font_dir="$HOME/Library/Fonts"
else
    # Linux
    font_dir="$HOME/.local/share/fonts"
    mkdir -p $font_dir
fi


debug_info() {
    echo $current_dir
    echo $parent_dir
    echo $extract_dir
    echo $font_dir
}


red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

print_info() {
    echo "${red}$identifier: ${green}$*${reset}"
}

print_erased() {
    if [ $1 == false ];
    then 
        printf "$2 \033[0K\r"
        #echo "$2"
    else
        echo "$2"
    fi

}

#debug_info

print_info "Fonts dir: \t" $font_dir

find_command="find $extract_dir -name '*.[o,t]tf' -o -name '*.pcf.gz' -type f"
print_info "Run: \t\t" $find_command
echo

OIFS="$IFS"
IFS=$'\n'

count=0
skipped=0
installed=0
new_line=false

for d in $extract_dir/*; do
    print_info "Installing: \t$d"

    if [ -d $d ]; 
    then
        skip=0
        inst=0
        for file in `eval "find \"$d\" -name '*.[o,t]tf' -o -name '*.pcf.gz' -type f"`; do

            file_name="${file##*/}"
            target_file=$font_dir/$file_name
            
            if [ -f $target_file ]; then
                print_erased "$new_line" " ⚠️ \tFile exists: $target_file"
                ((skip++))
                ((skipped++))
            else
                cp "${file}" "${target_file}"
                print_erased "$new_line" " ✅\tSuccessful: $target_file"
                ((inst++))
                ((installed++))
            fi
            
            sleep 0.05

            ((count++))
        done

        echo
        echo "\tSkipped: \t$skip"
        echo "\tInstalled: \t$inst"
    fi

    echo
done


echo

IFS="$OIFS"


echo
echo "---------------------------------------"
print_info "Skipped: \t$skipped"
print_info "Installed: \t$installed"
print_info "Total: \t\t$count"
echo "---------------------------------------"
echo
print_info "Done..."

echo


