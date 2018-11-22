#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# MY PROMPT
# Warning: All the x-related stuff fails silent on purpose
# This can make debugging tricky unless you change it.

HISTCONTROL=ignoreboth
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

export EDITOR='vim'

PROMPT='%B%F{green}%n@%M%f%b$(my_git_prompt) : %~
%B%F{cyan}[$?]%f%b » '

PS1='\u@\h : \W
[$?]» '

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] : \[\033[01;34m\]\w\[\033[00m\]
[$?] » '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h : \W
[$?] » '


fi
unset color_prompt force_color_prompt

#aliases

alias ls="ls --color"
alias la="ls -lah --color"
alias ll="ls -lh --color"

alias ascend="cd .."
alias descend="cd"
alias abscond="exit"
alias aggreive="rm"
alias strife="rm"
alias observe="ls"

roll(){

    echo $((( $RANDOM % $1) +1 ))

}

#tmux aliases because I restart my machine like a pleb
alias tmn="tmux new-session -s"
alias tma='tmux attach-session -t'
alias tml='tmux list-sessions'

#Searchgrep script
alias grecurse='grep -rnw -e'

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

alias tmux='tmux -2'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
