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
    service_query="$1"
    shift 1
    container_command="${@:-sh}"  # Default to 'sh' if no command is provided

    # Get the list of matching container names
    matching_services=($(docker ps --format '{{.Names}}' | grep "$service_query"))
    count=${#matching_services[@]}

    if [ "$count" -eq 0 ]; then
        echo "No containers found with '$service_query' in the name."
        return 1
    elif [ "$count" -eq 1 ]; then
        service_name="${matching_services[0]}"
        echo "Found container: $service_name"
        echo "Executing: docker exec -it $service_name $container_command"
        docker exec -it "$service_name" $container_command
    else
        echo "Multiple containers found with '$service_query' in the name:"
        for i in "${!matching_services[@]}"; do
            echo "$((i + 1)). ${matching_services[i]}"
        done

        while true; do
            read -p "Choose the number of the container you want to use: " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$count" ]; then
                service_name="${matching_services[$((choice - 1))]}"
                echo "Selected container: $service_name"
                echo "Executing: docker exec -it $service_name $container_command"
                docker exec -it "$service_name" $container_command
                break
            else
                echo "Invalid choice. Please try again."
            fi
        done
    fi
}

function dsps {
    service_query="$1"
    shift 1

    # Get the list of matching container names
    matching_services=($(docker service ls --format '{{.Name}}' | grep "$service_query"))
    count=${#matching_services[@]}

    if [ "$count" -eq 0 ]; then
        echo "No services found with '$service_query' in the name."
        return 1
    elif [ "$count" -eq 1 ]; then
        service_name="${matching_services[0]}"
        echo "Found service: $service_name"
        echo "Executing: docker service ps $service_name"
        docker service ps "$service_name"
    else
        echo "Multiple services found with '$service_query' in the name:"
        for i in "${!matching_services[@]}"; do
            echo "$((i + 1)). ${matching_services[i]}"
        done

        while true; do
            read -p "Choose the number of the service you want to use: " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$count" ]; then
                service_name="${matching_services[$((choice - 1))]}"
                echo "Selected container: $service_name"
                echo "Executing: docker exec -it $service_name $container_command"
                docker service ps "$service_name"
                break
            elif [[ "$choice" =~ ^[qQ]+$ ]]; then
                echo "Exiting the script."
                break
            else
                echo "Invalid choice. Please try again."
            fi
        done
    fi
}

# Drain a node in a Docker Swarm: e.g. move all running services to other nodes
function dndrain {
    node_query="$1"
    shift 1

    echo ""
    echo "Choose the Docker Swarm Node of which you want to move all running containers to other nodes."
    echo ""

    # Get the list of matching node names
    matching_nodes=($(docker node ls --format '{{.Hostname}}' | grep "$node_query"))
    count=${#matching_nodes[@]}

    if [ "$count" -eq 0 ]; then
        echo "No nodes found with '$node_query' in the name."
        return 1
    elif [ "$count" -eq 1 ]; then
        node_name="${matching_nodes[0]}"
        node_id=$(docker node ls --format '{{.ID}}\t{{.Hostname}}' | grep "$node_name" | cut -f1)
        echo "Found node: $node_name (ID: $node_id)"

        drainNode "$node_id"
    else
        echo "Multiple nodes found with '$node_query' in the name:"
        for i in "${!matching_nodes[@]}"; do
            echo "$((i + 1)). ${matching_nodes[i]}"
        done

        while true; do
            read -p "Choose the number of the node you want to drain: " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$count" ]; then
                node_name="${matching_nodes[$((choice - 1))]}"
                node_id=$(docker node ls --format '{{.ID}}\t{{.Hostname}}' | grep "$node_name" | cut -f1)
                echo ""
                echo "Selected node: $node_name (ID: $node_id)"
                drainNode "$node_id"
                break
            elif [[ "$choice" =~ ^[qQ]+$ ]]; then
                echo "Exiting the script."
                break
            else
                echo "Invalid choice. Please try again."
            fi
        done
    fi
}

function drainNode {
    node_id=$1

    echo ""
    echo "Current status"
    docker node ps "$node_id" --format "table {{.ID}}\t{{.Name}}\t{{.DesiredState}}\t{{.CurrentState}}\t{{.Error}}"
    echo ""

    echo ""
    read -p "Are you sure you want to move all running containers away from this node? [yN]" choice
    case "${choice:0:1}" in
        y|Y )
            echo "Executing: docker node update --availability drain $node_id"
            docker node update --availability drain "$node_id"

            echo ""
            echo "All containers have been moved away from the node."
            echo ""

            echo ""
            echo "Ensure that all containers have been shutdown on the node:"
            echo ""

            docker node ps "$node_id" --format "table {{.ID}}\t{{.Name}}\t{{.DesiredState}}\t{{.CurrentState}}\t{{.Error}}"

            ;;
        * )
            echo "Exiting the script."
            return
            ;;
    esac
}

function dnactivate {
    node_query="$1"
    shift 1

    # Get the list of matching node names
    matching_nodes=($(docker node ls --format '{{.Hostname}}' | grep "$node_query"))
    count=${#matching_nodes[@]}

    if [ "$count" -eq 0 ]; then
        echo "No nodes found with '$node_query' in the name."
        return 1
    elif [ "$count" -eq 1 ]; then
        node_name="${matching_nodes[0]}"
        node_id=$(docker node ls --format '{{.ID}}\t{{.Hostname}}' | grep "$node_name" | cut -f1)
        echo "Found node: $node_name (ID: $node_id)"
        activateNode "$node_id"
    else
        echo ""
        echo "Current status"
        docker node ls --format '{{.Hostname}}\t{{.Status}}\t{{.Availability}}'
        echo ""

        echo "Multiple nodes found with '$node_query' in the name:"
        for i in "${!matching_nodes[@]}"; do
            echo "$((i + 1)). ${matching_nodes[i]}"
        done

        while true; do
            read -p "Choose the number of the node you want to activate: " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$count" ]; then
                node_name="${matching_nodes[$((choice - 1))]}"
                node_id=$(docker node ls --format '{{.ID}}\t{{.Hostname}}' | grep "$node_name" | cut -f1)
                echo "Selected node: $node_name (ID: $node_id)"

                activateNode "$node_id"
                break
            elif [[ "$choice" =~ ^[qQ]+$ ]]; then
                echo "Exiting the script."
                break
            else
                echo "Invalid choice. Please try again."
            fi
        done
    fi
}

function activateNode {
    node_id=$1
    echo "Executing: docker node update --availability active $node_id"
    docker node update --availability active "$node_id"

    echo ""
    echo "Node has been activated."
    echo ""

    echo ""
    echo "Current status"
    docker node ls --format '{{.Hostname}}\t{{.Status}}\t{{.Availability}}'
    echo ""
}

# List the running containers on a specific node in a Docker Swarm
function dnps {
    node_query="$1"
    shift 1

    echo ""
    echo "Docker Node PS"
    echo ""

    # Get the list of matching node names
    matching_nodes=($(docker node ls --format '{{.Hostname}}' | grep "$node_query"))
    count=${#matching_nodes[@]}

    if [ "$count" -eq 0 ]; then
        echo "No nodes found with '$node_query' in the name."
        return 1
    elif [ "$count" -eq 1 ]; then
        node_name="${matching_nodes[0]}"
        echo ""
        echo "Found node: $node_name"
        echo "Executing: docker node ps $node_name"
        echo ""
        docker node ps "$node_name"
    else
        echo "Multiple nodes found with '$node_query' in the name:"
        for i in "${!matching_nodes[@]}"; do
            echo "$((i + 1)). ${matching_nodes[i]}"
        done

        echo "* Show all"

        while true; do
            read -p "Choose the number of the node you want to inspect: " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$count" ]; then
                node_name="${matching_nodes[$((choice - 1))]}"
                echo "Selected node: $node_name"
                echo "Executing: docker node ps $node_name"
                docker node ps "$node_name"
                break
            elif [[ "$choice" == '*' ]]; then
              for node in "${matching_nodes[@]}"; do
                echo ""
                echo "-----------------------------------------------"
                echo "Node: $node"
                echo "-----------------------------------------------"
                docker node ps "$node"
                break
              done
            elif [[ "$choice" =~ ^[qQ]+$ ]]; then
                echo "Exiting the script."
                break
            else
                echo "Invalid choice. Please try again."
            fi
        done
    fi
}
