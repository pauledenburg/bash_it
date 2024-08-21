cite about-plugin
about-plugin 'docker helper functions'

function dclear {
  about 'Clear all docker overhead like dangling images, volumes and the likes'
  group 'docker'

  echo "Do you want to move forward with the script? (YES/no)"
  read choice
  
  if [ "$choice" = "no" ]; then
      echo "Exiting the script."
      return
  fi

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

# Function to display matching containers and allow user selection
function deit {
    container_query="$1"
    shift 1
    container_command="${@:-bash}"  # Default to 'bash' if no command is provided

    # Get the list of matching container names
    matching_containers=($(docker ps --format '{{.Names}}' | grep "$container_query"))
    count=${#matching_containers[@]}

    if [ "$count" -eq 0 ]; then
        echo "No containers found with '$container_query' in the name."
        return 1
    elif [ "$count" -eq 1 ]; then
        container_name="${matching_containers[0]}"
        echo "Found container: $container_name"
        echo "Executing: docker exec -it $container_name $container_command"
        docker exec -it "$container_name" $container_command
    else
        echo "Multiple containers found with '$container_query' in the name:"
        for i in "${!matching_containers[@]}"; do
            echo "$((i + 1)). ${matching_containers[i]}"
        done

        while true; do
            read -p "Choose the number of the container you want to use: " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$count" ]; then
                container_name="${matching_containers[$((choice - 1))]}"
                echo "Selected container: $container_name"
                echo "Executing: docker exec -it $container_name $container_command"
                docker exec -it "$container_name" $container_command
                break
            else
                echo "Invalid choice. Please try again."
            fi
        done
    fi
}