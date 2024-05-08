cite about-plugin
about-plugin 'docker helper functions'

function dclear {
  about 'Clear all docker overhead like dangling images, volumes and the likes'
  group 'docker'

  echo ""
  echo "Pruning: Remove all unused containers, networks, images (both dangling and unreferenced) and volumes"
  docker system prune --all --force

  echo ""
  echo "Clear images"
  docker images --no-trunc | grep '<none>' \
    | awk '{ print $3 }' \
    | xargs docker rmi

  echo ""
  echo "Clear dead containers"
  docker ps --filter status=dead --filter status=exited -aq \
    | xargs docker rm -v

  echo ""
  echo "Remove dangling volumes"
  docker volume ls -qf dangling=true | xargs docker volume rm

  echo ""
  echo "Done"
  echo ""
}

function dbash {
  about 'goes into the bash shell of the specified running container'
  group 'docker'

  echo "Executing bash on container $1"
  docker exec -it $1 bash
}


function docker-bash-root {
  about 'goes into the bash shell of the specified running container as root user'
  group 'docker'

  echo "Executing bash on container $1"
  docker exec -it -u root $1 bash
}

