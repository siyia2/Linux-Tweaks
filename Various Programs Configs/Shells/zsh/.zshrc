# Greeting, delete it if you dont want any
echo 'Welcome To The Terminal!'
echo 'Package Managers: "pacman", "yay" (aur)'
echo 'Basic Functions: "-Ss" (search), "-S" (install), "-R" (remove)'
echo " "
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/siyia/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Plugins in use&settings
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white
ZSH_HIGHLIGHT_STYLES[path]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=white
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=magenta
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[builtin]=fg=green
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=green
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=green
# Prompt config
PS1="%B%F{cyan}%n%F{magenta}@%F{cyan}%m%F{magenta}@%F{cyan}%~ %1 %#: "
# Custom Key Bindings
bindkey "\e" "kill-line"
