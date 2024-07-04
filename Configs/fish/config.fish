#screenfetch -w
# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'
#set -gx GZIP "--best"
#set -gx ZSTD "-6"
function make
    command make -j (nproc) $argv
end
function cp
    /usr/bin/cp --reflink=auto $argv
end
