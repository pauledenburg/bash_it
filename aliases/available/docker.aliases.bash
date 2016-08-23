cite 'about-alias'
about-alias 'common docker abbreviations'

# Aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dimg='docker images'
alias de='docker exec -it'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drmi='docker rmi'
alias drmia='docker rmi $(docker images -q -f dangling=true)'
alias db='docker build'

# docker compose
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcup='docker-compose up'
alias dcs='docker-compose stop'
alias dcstop='docker-compose stop'
