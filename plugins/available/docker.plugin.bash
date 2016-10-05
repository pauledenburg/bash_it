cite about-plugin
about-plugin 'docker helper functions'

function docker-bash {
  about 'goes into the bash shell of the specified running container'
  group 'docker'

  echo "Executing bash on container $1"
  docker exec -it $1 bash
}


