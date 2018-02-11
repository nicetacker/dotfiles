#!/usr/bin/bash
# Many thanks to https://github.com/mathiasbynens/dotfiles

ignore_files=(".git" "install.sh" "README.md")

git pull origin master

function Install() {
    local opt=""
    for f in "${ignore_files[@]}" ; do
        opt="${opt} --exclude $f"
    done
    opt="${opt} -avh --no-perms"

    if [[ "$1" != "run" ]]; then
        opt="${opt} --dry-run"
    fi;

    # run rsync . -> $HOME
    rsync ${opt} . ~ 
}

if [ "$1" != "--run" -a "$1" != "-r" ]; then
    Install
    echo ""
    echo "Dry run mode."
    echo "For actually copy files, please execute following command."
    echo "${0} --run"
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        Install run
    fi
fi


