declare CUSTOM_FUNCTIONS_SCRIPT="$ZSH_CUSTOM/custom-functions.zsh"

if [ -f $CUSTOM_FUNCTIONS_SCRIPT ]; then
    source $CUSTOM_FUNCTIONS_SCRIPT
else
    echo "$CUSTOM_FUNCTIONS_SCRIPT not found.  Server aliases not set."
fi
