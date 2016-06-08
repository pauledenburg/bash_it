cite 'about-alias'
about-alias 'common docker abbreviations'

# Aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drmi='docker rmi'
alias drmia='docker rmi $(docker images -q -f dangling=true)'
