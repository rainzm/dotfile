# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/rain/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles


# tmux
# alias tmux='TERM=screen-256color tmux -2'
# alias tmuxinator='TERM=screen-256color tmuxinator'
# alias tmux='TERM=screen-256color tmux'
alias tmux="TERM=screen-256color-bce tmux"

# python
# export PYTHONPATH=/Users/rain/code/python/cloud/yunion/server:/Users/rain/code/python

# vim
# alias vim="/usr/local/Cellar/vim/8.1.1750/bin/vim"
alias vim="~/software/nvim-osx64/bin/nvim"
export PATH=$PATH:/Applications/MacVim.app/Contents/bin/

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f --exclude .git --exclude vendor'

# ctrl+s
stty -ixon


# Go
export GOPATH=/Users/rain/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GO111MODULE=on
# export GOPROXY=https://goproxy.cn,direct
export PATH=$PATH:$GOPATH/src/yunion.io/x/onecloud/_output/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk/Contents/Home

# onecloud
alias gcmod="git checkout -- go.mod"
alias goone="cd $GOPATH/src/yunion.io/x/onecloud"
alias syone="cd $GOPATH/src/yunion.io/x&&rsync -avzP --delete onecloud  dev:/root/go/src/yunion.io/x/ --exclude onecloud/_output --exclude onecloud/pkg/generated&&cd -"
alias syone1="cd $GOPATH/src/yunion.io/x&&rsync -avzP --delete onecloud  dev1:/root/go/src/yunion.io/x/ --exclude onecloud/_output --exclude onecloud/pkg/generated&&cd -"
alias synp="cd ~/code/go/yunion&&rsync -avzP --delete notifyplugins  dev:/root/code/go/yunion --exclude notifyplugins/_output&&cd -"
alias syplay="cd ~/code/&&rsync -avzP --delete playbook dev:/root/code&&cd -"
# source /Users/rain/plugin/rc_admin
export PATH=$PATH:/usr/local/kubebuilder/bin/

# onecloud-service-operator
alias gooso="cd /Users/rain/code/go/yunion/onecloud-service-operator"
alias syoso="cd /Users/rain/code/go/yunion&&rsync -avzP --delete onecloud-service-operator dev:/root/code/go/yunion/ &&cd -"
alias syoso1="cd /Users/rain/code/go/yunion&&rsync -avzP --delete onecloud-service-operator dev1:/root/code/go/yunion/ --exclude onecloud-service-operator/_output &&cd -"

# notebook
alias vimnote="cd /Users/rain/Documents/NoteBook&&vim"

# climc 
source <(climc --completion zsh)
climcenv() {
    cd ~/.climc
    file=`ls | grep "$1"` 
    source $file
    cd -
}

title() {
    echo -e "\033];$1\007"
}

# export BAT_THEME=gruvbox
export BAT_THEME=Tomorrow-Night

# debug
alias tele="telepresence --namespace onecloud --run /bin/zsh --swap-deployment"

# export COLORTERM="truecolor"

# sed
export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH

export DISABLE_AUTO_TITLE="true"

# kubectl
alias ksi="kubectl set image"
alias ksid="kubectl set image deployment"
alias krrd="kubectl rollout restart deployment"
export KUBE_EDITOR="/Users/rain/software/nvim-osx64/bin/nvim"

# rust
export PATH=$PATH:$HOME/.cargo/bin

# x11
export DISPLAY=":0"

export LUA_PATH="~/.vim/lua/?.lua;;"
export GITHUB_NAME="rainzm"

# kubectl completion
# if [ $commands[helm] ]; then source <(helm completion zsh); fi
# [[ -s "/Users/rain/.gvm/scripts/gvm" ]] && source "/Users/rain/.gvm/scripts/gvm"
