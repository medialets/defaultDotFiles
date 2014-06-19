# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source dircolors
if [ -f ~/.dircolors.ansi-dark ]; then
    eval `dircolors ~/.dircolors.ansi-dark`
    alias solarize-light="dynamic-colors switch solarized-light"
    alias solarize-light2="dynamic-colors switch solarized-light-desaturated"
    alias solarize-dark="dynamic-colors switch solarized-dark"
    alias solarize-dark2="dynamic-colors switch solarized-dark-desaturated"
fi

# Color aliases
alias ls='ls -h --color=auto'
alias ll="ls -lv --group-directories-first --color=auto"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Command extensions
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias wget='wget --no-check-certificate'

# Command replacement if similar but better command exists
which colordiff >/dev/null 2>&1 && alias diff='colordiff'
which htop >/dev/null 2>&1 && alias top='htop'

# Get rid of command not found for common spelling mistakes
alias cd..='cd ..'

# Auto add sudo to commands commonly run via sudo
alias su="sudo su"
alias yum="sudo yum"
alias chef-client="sudo chef-client"

# Fix to get screen to auto name window to hostname in CAPS
if [ "$TERM" == "screen" ]; then
    PROMPT_COMMAND=''`which echo`' -ne "\033k\033\134\033k`echo ${HOSTNAME} | tr [:lower:] [:upper:]`\033\134"'
fi

# Commands/Functions
function create-knownhosts () {
    knife exec -E 'nodes.all {|n| puts `ssh-keyscan #{n.hostname}`}' 2>/dev/null | sed '/^$/d' > ~/.ssh/known_hosts
    chmod 644 ~/.ssh/known_hosts
}
