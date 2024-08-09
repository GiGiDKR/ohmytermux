
# ALIAS TERMUX #

alias setalias="nano $HOME/.oh-my-zsh/custom/aliases.zsh"
alias getalias='bat $HOME/.oh-my-zsh/custom/aliases.zsh'
alias l='eza -1 --icons'
alias ls='eza --icons'
alias ll='eza -lF -a  --icons --total-size  --no-permissions  --no-time --no-user'
alias la='eza --icons -lgha --group-directories-first'
alias lt='eza --icons --tree'
alias lta='eza --icons --tree -lgha'
alias dir='eza -lF --icons'
alias ..='cd ..'
alias q='exit'
alias c='clear'
alias md='mkdir'
alias cat='bat '
alias apt='nala '
alias install='nala install -y '
alias uninstall='nala remove -y '
alias update='nala update'
alias upgrade='nala upgrade -y'
alias search='nala search '
alias list='nala list --upgradeable'
alias show='nala show'
alias n='nano'
alias prop='nano $HOME/.termux/termux.properties'
alias gc='git clone'
alias tmx='cd $HOME/.termux'
alias cm='chmod +x'
alias push="git pull && git add . && git commit -m 'mobile push' && gît push'"
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"
