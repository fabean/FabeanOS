#alias vim='nvim'
#alias bim='nvim'
alias ssh="ssh -A" # forward ssh keys to server
alias cp='cp -iv' # prompt when overwriting and verbose
alias mv='mv -iv' # prompt when overwriting and verbose
#alias ll='ls -FGlAhp'
alias du1='du -h -d 1'
alias ls='lsd'
alias gs='git status'
alias gap='git add -p'
alias git_current_branch="git branch | grep \* | cut -d ' ' -f2"
alias ggpull='git pull origin (git_current_branch)'
alias ggpush='git push origin (git_current_branch)'
alias weather='curl wttr.in'
#alias fox='MOZ_ENABLE_WAYLAND=1 firefox-developer-edition'
alias mux='tmuxinator'
alias rm='trash'
alias vpn-start='wg-quick up ~/Sync/settings-sync/josh-ck-vpn.conf'
alias vpn-stop='wg-quick down ~/Sync/settings-sync/josh-ck-vpn.conf'
#function vpn-start
#  sudo systemctl start openvpn-client@$argv
#end

#function vpn-stop
#  sudo systemctl stop openvpn-client@$argv
#end

#function vpn-status
#  sudo systemctl status openvpn-client@$argv
#end

function notify
  $argv && play ~/Music/zelda-secret.mp3
end

# my path
#export PATH="/home/joshfabean/.n/bin:/home/joshfabean/.local/bin:/usr/local/bin/php:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/home/joshfabean/.cargo/bin:$PATH"
#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/var/lib/flatpak/exports/bin:/home/joshfabean/go/bin:$HOME/.config/composer/vendor/bin:/usr/bin:/usr/bin/modprobe:$HOME/.pub-cache/bin:$PATH"

#npm set prefix ~/.npm
#export PATH="$HOME/.npm/bin:$PATH"
#export PATH="./node_modules/.bin:$PATH"

#export LIBVA_DRIVER_NAME=vdpau
#export EDITOR=nvim
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
#export LC_ALL="en_US.UTF-8"
#export N_PREFIX=/home/joshfabean/.n

function fish_greeting
  echo ""
  echo "Farfetch'd"
  #/home/joshfabean/go/bin/figurine -f "3d.flf" Farfetch\'d
end

function fish_prompt
  powerline-go --shell bare $status
end
