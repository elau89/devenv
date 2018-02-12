#!/bin/bash

echo "Calling installer in Docker environment"

# Set .gitconfig user from gituser.txt
if [ -f "gituser.txt" ]; then
    cat gituser.txt >> ${HOME}/.gitconfig
fi

# Install pygments on the user account
pip install --user pygments

echo "Installing and updating vim plugins..."
mkdir -p ${HOME}/.vim/bundle
./dein_installer.sh ${HOME}/.vim/bundle
TERM=dumb ./oh-my-zsh_installer.sh
cp -fr custom .oh-my-zsh/
vim --not-a-term -c ":q!" &> /dev/null
echo "Vim plugins installed and updated."

rm -fr dein_installer.sh \
    oh-my-zsh_installer.sh \
    custom \
    installer.sh \
    gituser.txt
