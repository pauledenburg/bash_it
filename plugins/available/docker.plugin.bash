cite about-plugin
about-plugin 'docker helper functions'

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

