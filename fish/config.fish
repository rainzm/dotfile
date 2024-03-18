set -U FZF_DEFAULT_COMMAND "fd --type f --exclude .git --exclude vendor"
set fish_color_valid_path
set -x EDITOR "nvim"

set fish_color_command blue

function vim -d 'vi alias for nvim'
    nvim $argv
end

function goone -d 'go main project'
    cd $HOME/code/go/wcloud/backend
end

function syone -d 'sync main project'
    cd $HOME/code/go/wcloud&&rsync -avzP --delete backend dev:~/code/go/wcloud/ --exclude backend/_output --exclude backend/pkg/generated&&cd -
end

function proxy -d "set proxy" -a state
    if test $state = "on"
        export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
        # set -x https_proxy "http://127.0.0.1:7890"
        # set -x http_proxy "http://127.0.0.1:7890"
        # set -x all_proxy "socks5://127.0.0.1:7890"
    else
        unset https_proxy http_proxy all_proxy
    end
end

set -x LUA_PATH "/Users/rain/.luarocks/share/lua/5.1/?.lua;/Users/rain/.luarocks/share/lua/5.1/?/init.lua;;"
set -x LUA_CPATH "/Users/rain/.luarocks/lib/lua/5.1/?.so;;"
set -x GITHUB_NAME rainzm
set -x GITLAB_USER zhengyu

# Go
set -x GOPATH /Users/rain/go
set -x GOBIN $GOPATH/bin
set -x PATH $PATH:$GOBIN
# export GOPROXY=https://goproxy.cn,direct

# nvm
set -x PATH "/Users/rain/.local/share/nvm/v18.18.1/bin" $PATH

set -x BAT_THEME Tomorrow-Night
set -x KUBE_EDITOR nvim
# set -gx DYLD_LIBRARY_PATH /opt/homebrew/Cellar/imagemagick/7.1.1-21/lib

# sed
set -x PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH

# node and npm

set -x XDG_CONFIG_HOME "$HOME/.config"

if test -z "$(lsof -i:9257)"
    nohup /Users/rain/code/rust/rime-ls/target/release/rime_ls --listen 127.0.0.1:9257 >/dev/null 2>/dev/null &
end
