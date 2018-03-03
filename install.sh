#!/usr/bin/bash
# Many thanks to https://github.com/mathiasbynens/dotfiles

ignore_files=(".git" "install.sh" "README.md")

git pull origin master

function Sync() {
    local opt=""
    for f in "${ignore_files[@]}" ; do
        opt="${opt} --exclude $f"
    done
    opt="${opt} -avh --no-perms"

    # run rsync . -> $HOME
    rsync ${opt} . ~ 
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
   Sync 
   # copy plug.vim
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

