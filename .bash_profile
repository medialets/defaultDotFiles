# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

if which vim >/dev/null 2>&1 ; then
    EDITOR=vim
else
    EDITOR=vi
fi

export PATH
export EDITOR
