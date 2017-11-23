# Remove prepared aliases from lib
unalias please
unalias which-command

# General aliases
alias findswp='find . -name "*.sw[l,m,n,o,p]"'
alias psef='ps -ef | grep'
alias tmux-reload='tmux detach -a'

# grep aliases
alias grep='grep --color=auto -nI'
alias fgrep='fgrep --color=auto -nI'
alias egrep='egrep --color=auto -nI'
alias rgrep='grep --color=auto -nIR'

alias greph='grep --color=auto -IR --include=*.{h,hh,hpp}'
alias grepc='grep --color=auto -IR --include=*.{c,cc,cpp,cxx}'
alias greps='grep --color=auto -IR --include=*.{h,hh,hpp,c,cc,cpp,cxx}'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias la='ls -A'
alias ll='ls -l'
