function FastVim {
    vim -X --noplugin "$@"
}

function ROVim {
    FastVim -R "$@"
}

function RecurseDirectories {
    find . -type d -exec bash -c "cd {} && $@" \;
}

function BuildLocal {
    # Used for quick, local builds that may use the pthread library
    g++ -std=c++14 -static -Wl,--whole-archive -lpthread -Wl,--no-whole-archive "$@"
}

function PromptCommand {
    return
}
