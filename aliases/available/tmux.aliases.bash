# kill all sessions of tmux
cite about-alias
about-alias 'general aliases'

alias tmux="TERM=screen-256color-bce tmux"
alias tm='tmux'

alias tmscphp='tmux source ~/.tmux/cakephp'
alias tmslog='tmux source ~/.tmux/logging'

# kill all active tmux sessions
alias tkas='tmux ls | cut -d " " -f 1 | while read session; do tmux kill-session -t ${session%*:}; done'
alias tmk='tmux ls | cut -d " " -f 1 | while read session; do tmux kill-session -t ${session%*:}; done'

# list all sessions
alias tml='tmux ls'

# attach to an existing session
alias tma='tmux attach -t '
