function set-docker-host
    command -sq docker
    and command -sq jq
    or return 1

    set -l host (
      docker context ls --format '{{ . | json }}' |
        jq -sr '.[] | select(.Current == true) | .DockerEndpoint'
    )
    or return 1

    set -gx DOCKER_HOST $host
end
