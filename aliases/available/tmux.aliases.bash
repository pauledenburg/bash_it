# kill all sessions of tmux
cite about-alias
about-alias 'general aliases'

# kill all active tmux sessions
alias tkas='tmux ls | cut -d " " -f 1 | while read session; do tmux kill-session -t ${session%*:}; done'
