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
alias dclean="docker images --no-trunc | grep '<none>' | awk '{print \$3}' | while read img; do echo \"removing image \${img}\"; docker rmi -f \${img}; done; docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v; docker volume ls -qf dangling=true | xargs docker volume rm; docker image prune -f; docker container prune -f"

# docker compose
alias dc='docker-compose'
alias dcdev='docker-compose -f docker-compose-dev.yml'
alias dcdown='docker-compose down'
alias dcps='docker-compose ps'
alias dcrm='docker-compose rm'
alias dcs='docker-compose stop'
alias dcstop='docker-compose stop'
alias dctest='docker-compose -f docker-compose-test.yml'
alias dcu='docker-compose up'
alias dcup='docker-compose up'

# kubernetes
alias mk='minikube'
alias mkctl='minikube kubectl --'
