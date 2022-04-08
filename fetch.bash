#!/bin/bash

input=$(cat pkg_list.txt)
query=$(aur-out-of-date -pkg $input)
while read p; do
    echo "$p"
    if [[ $p =~ "OUT-OF-DATE" ]]; then
        #Get name and new version
        name=$(grep -oP "(?<=\[)(.+?)(?=\])" <<< $p | awk NR==2)
        version=$(awk '{ print $(NF-1) }' <<< $p)

        #Bump the PKGBUILD in yay's cache
        DIR="~/.cache/yay/"$name""
        if [ -d "$DIR" ]; then
            cd $DIR
        else
            cd ~/.cache/yay/
            git clone https://aur.archlinux.org/$name.git
            cd $name
        fi
        sed -E "s#(pkgver=).*#\1$version#" -i PKGBUILD
        updpkgsums
        makepkg --printsrcinfo > .SRCINFO
        git diff
        git add .SRCINFO PKGBUILD
        git commit -v -m "$version"
        git remote set-url origin ssh://aur@aur.archlinux.org/$name.git
        git push
    fi
done <<< $query
