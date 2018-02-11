#!/bin/bash

echo "Calling installer in Docker environment"

# Set .gitconfig user from gituser.txt
if [ -f "gituser.txt" ]; then
    cat gituser.txt >> ${HOME}/.gitconfig
fi
