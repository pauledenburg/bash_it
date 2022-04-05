cite 'about-alias'
about-alias 'common docker abbreviations'

# Aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias db='docker build'
alias dimg='docker images'
alias de='docker exec -it'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drmfa='docker rm -f $(docker ps -aq)'
alias drmi='docker rmi'
alias drmia='docker rmi $(docker images -q -f dangling=true)'
alias drmc='docker ps -aq --no-trunc | xargs docker rm'
alias deit='docker exec -it'
alias dclean='docker images --no-trunc | grep "<none>" | awk "{ print $3 }" | xargs docker rmi; docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v; docker volume ls -qf dangling=true | xargs docker volume rm'

# docker compose
alias dc='docker compose'
alias dcu='docker compose up'
alias dcup='docker compose up'
alias dcs='docker compose stop'
alias dcstop='docker compose stop'
alias dcps='docker compose ps'
alias dcdown='docker compose down'
alias dcrm='docker compose rm'
