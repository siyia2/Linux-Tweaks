# Greeting, delete it if you dont want any
echo 'Welcome To The Terminal!'
echo 'Package Managers: "pacman", "yay" (aur)'
echo 'Basic Functions: "-Ss" (search), "-S" (install), "-R" (remove)'
echo 'Remove Orphans: ↩ as Root "pacman -Qtdq | pacman -Rns -"'
echo " "
# Lines configured by zsh-newuser-install
umask 077
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/siyia/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Plugins in use&settings
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[path]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=white
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=magenta
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=yellow
# Prompt config
PS1="%B%F{green}%n%F{magenta}@%F{green}%m%F{magenta}@%F{green}%~ %1 %#: "
# Custom Key Bindings
bindkey "\e" vi-kill-line
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey "\e[5~" history-substring-search-up
bindkey "\e[6~" history-substring-search-down

alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'
alias electron="electron --ozone-platform=wayland" 
alias make='make -j$(nproc)'
alias cp='cp --reflink=auto'
