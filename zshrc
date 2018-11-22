# GIT PROMPT FROM OH-MY-ZSH THEME MORTALSCUMBAG

setopt prompt_subst

function git_current_branch() {
    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return # No git repo
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}

}

function my_current_branch() {
  echo $(git_current_branch || echo "(no branch)")
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%B%F{red}(ssh)%f%b"
  fi
}

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%F{red}%f"
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{white}‹%f "
ZSH_THEME_GIT_PROMPT_AHEAD="%B%F{magenta}↑%f%b"
ZSH_THEME_GIT_PROMPT_STAGED="%B%F{green}*%f%b"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%B%F{red}*%f%b"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%B%F{white}*%f%b"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{red}*%f"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %F{white}›%f"

function my_git_prompt() {
  tester=$(git rev-parse --git-dir 2> /dev/null) || return

  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""

  # is branch ahead?
  if $(echo "$(git log origin/$(git_current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi

  # is anything staged?
  if $(echo "$INDEX" | command grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi

  # is anything unstaged?
  if $(echo "$INDEX" | command grep -E -e '^[ MARC][MD] ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi

  # is anything untracked?
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  # is anything unmerged?
  if $(echo "$INDEX" | command grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  if [[ -n $STATUS ]]; then
    STATUS=" $STATUS"
  fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX%B%F{yellow}$(my_current_branch)%f%b$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# MY PROMPT CODE
# Warning: All the x-related stuff fails silent on purpose
# This can make debugging tricky unless you change it.

# Load the Oh My ZSH Emoji Variable Plugin: cloned manually
source /home/kalium/.zsh/plugins/emoji/emoji.plugin.zsh

# Set up completition settings
autoload -Uz compinit
autoload colors; colors

# Autocompletion Settings
# use the cache
# accept some errors
# complete in the middle of words

zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*' max-errors 4
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' hosts off
setopt complete_in_word
autoload -Uz compinit

# Keybindings, use vim mode but also normal stuff
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1

# History file settingss
export HISTFILE=~/.zhistory
export HISTSIZE=1000000
export SAVEHIST=1000000

# Magical History Search settings
setopt extended_history hist_no_store hist_ignore_dups hist_expire_dups_first hist_find_no_dups inc_append_history share_history hist_reduce_blanks hist_ignore_space

COMPLETION_WAITING_DOTS='true'

compinit

# Setup keys for tty and X
sudo loadkeys ~/.config/keymaps/kalium.map -u 2> /dev/null

# caps -> escape, compose -> ralt, r+lshift -> capslock, win+space -> chlang
setxkbmap -layout us,gr -option 'caps:escape' -option 'compose:ralt' -option 'grp:win_space_toggle' -option 'shift:both_capslock'  2> /dev/null

# Default editor is nvim

if [ -f /usr/bin/nvim ]; then
    export EDITOR='nvim'
elif [ -f /usr/bin/vim ]; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

alias truevim=/usr/bin/vim
alias truevi=/usr/bin/vi
alias vim=$EDITOR

export TERMINAL='kitty'

# Check if X running and user level, set appropriate prompt variable
# Assumes that Xorg running means use emoji
# Detecting if you're in a tty is extremely awful and bad
function prompt_type() {

    u=`whoami`

    if pgrep -x "Xorg" > /dev/null; then
        if [[ $u == "root" ]]; then

            echo "⚡:" 

        elif [[ -n $SSH_CONNECTION ]]; then

            echo "Σ:"

        else

            echo "🌺:"

        fi
    else
        if [[ $u == "root" ]]; then

            echo "ρ:"

        elif [[ -n $SSH_CONNECTION ]]; then

            echo "Σ:"

        else 

            echo "»"

        fi
    fi
}

# Set prompt, with git_prompt from above
PROMPT='$(ssh_connection)%B%F{green}%n@%M%f%b$(my_git_prompt) : %~
%B%F{cyan}[%?]%f%b $(prompt_type) '

#aliases
#i3 control aliases
alias leavei3="i3-msg exit"

#Kitty Aliases
alias icat="kitty +kitten icat"

# Joke Aliases
alias rainbow="fortune|cowsay|lolcat -F 0.5"
alias fucking="sudo"
alias cacaplay="mplayer -really-quiet -fs -vo caca"
alias ascend="cd .."
alias descend="cd"
alias abscond="i3-msg exit"
alias aggreive="rm"
alias strife="rm"
alias observe="ls"

# Cheap diceroll
roll(){ echo $((( $RANDOM % $1) +1 )) }

# Music Aliases & Functions
alias cx="cmus-remote -u"
alias cn='cmus-remote -C status | grep " artist \| album \| title" | cut -d " " -f 2-'
alias ch="echo \"cz is last\ncx is pause\ncv is next\ncs is mix\ncn is data\""

cz(){
    cmus-remote -r
    cn
}

cv(){
    cmus-remote -n
    cn
}

chvolume(){
    amixer set Master $1% >/dev/null
}


# File listing
alias ls="ls --color"
alias la="ls -lah --color"
alias ll="ls -lh --color"
alias feh="feh --scale-down"

#tmux aliases because I restart my machine like a plebian
alias tmn="tmux new-session -s"
alias tma='tmux attach-session -t'
alias tml='tmux list-sessions'

#for SSH connections to termux over USB
alias sshtermux='adb forward tcp:8022 tcp:8022 && adb forward tcp:8080 tcp:8080&& mosh localhost -p 8022'

# A bunch of scripts to do video cap in mkv or mp4
alias captop='ffmpeg -f alsa -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -ac 2 quicktopcap.mkv'

alias mpcaptop='ffmpeg -f alsa -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -ac 2 quicktopcap.mp4'

alias capscreen='ffmpeg -f alsa -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0+1920,0 -ac 2 quickscreencap.mkv'

alias mpcapscreen='ffmpeg -f alsa -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0+1920,0 -ac 2 quickscreencap.mp4'

#Searchgrep script
alias grecurse='grep -rnw -e'

# STM32 helper functions
cursegdb(){ #creates gdb with curses UI

    arm-none-eabi-gdb -x gdb.txt -tui $1

}

connectSTM(){ #creates normal gdb

    arm-none-eabi-gdb -x gdb.txt $1

}

alias armAssemble='arm-none-eabi-gcc -g -o main.o main.c'
alias armLink='arm-none-eabi-ld -T stm32f0_linker.ld -o main.elf main.o'
alias ocdstm='sudo openocd -f interface/stlink-v2.cfg -f target/stm32f0x_stlink.cfg'

alias mocp='mocp --theme /usr/share/moc/themes/darkdot_theme'

armBuild(){ #Broken ATM, fix back to assembly
    armAssemble
    armLink
    connectSTM main.elf
}

# Git assistant gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;} #use gitignore.io to make gitignores

# Start tmux with better settings
alias tmux='tmux -2'

# Lock/sleep tty
alias tittysleep='sudo pm-suspend & vlock -a'
alias tittylock='vlock -a'

# Detect and manage TERM variable
#if [[ $TERM != "tmux-256color" ]] ; then

#    export TERM=vte-256color;

#fi

# Export custom PATH variable
export PATH=$PATH:/home/kalium/work/school/raspbian/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:/home/kalium/.local/bin:/home/kalium/opt/scilab/scilab-6.0.1/bin

# Load a DBUS session if not started already
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    ## if not found, launch a new one
    eval " $(dbus-launch --sh-syntax --exit-with-session)"
    echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

# Load zsh syntax highlighting script
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 

# Print a cute fortune
fortune

echo 

