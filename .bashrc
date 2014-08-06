## GETTING ENVIRONMENT NAME
if grep -q -E "^[ \t]*node_name" /etc/chef/client.rb ; then
    node_name="$(grep -E "^[ \t]*node_name" /etc/chef/client.rb | cut -d\" -f 2)"
    ENV=$( echo ${node_name} | rev | cut -d . -f 3 | rev)
    PS1HOST=$( echo ${node_name} | cut -d . -f 1)
else
    ENV=$( hostname -f | cut -d . -f 2)
    PS1HOST="\h"
fi

COLOR_ENV=''
COLO_DIR=''
if [[ "$ENV" =~ "stg" ]]; then
    ENV="${COLOR_DIR}[${COLOR_ENV} STAGING ${COLOR_DIR}]"
elif [[ "$ENV" =~ "qa" ]] ;then
    ENV="${COLOR_DIR}[${COLOR_ENV} QA ${COLOR_DIR}]"
elif [[ "$ENV" =~ "dev" ]] ;then
    ENV="${COLOR_DIR}[${COLOR_ENV} DEV ${COLOR_DIR}]"
elif [[ "$ENV" =~ "site3" ]] ;then
    ENV="${COLOR_DIR}[${COLOR_ENV} SITE3 ${COLOR_DIR}]"
elif [[ "$ENV" =~ "site4" ]] ;then
    ENV="${COLOR_DIR}[${COLOR_ENV} SITE4 ${COLOR_DIR}]"
elif [[ "$ENV" =~ "site1" ]] ;then
    ENV="${COLOR_DIR}[${COLOR_ENV} SITE1 ${COLOR_DIR}]"
else
    ENV="${COLOR_DIR}[${COLOR_ENV} U_NEW_HERE ${COLOR_DIR}]"
fi


if [ "$PS1" ]; then
    case $TERM in
        xterm*)
                if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
                        PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
                else
                PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
                fi
                ;;
        screen)
                if [ -e /etc/sysconfig/bash-prompt-screen ]; then
                        PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
                else
                PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\033\\"'
                fi
                ;;
        *)
                [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
            ;;
    esac
    # Turn on checkwinsize
    shopt -s checkwinsize
    PS1="[\u@\h $ENV \W]\\$ "
fi

