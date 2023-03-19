function set-docker-host
    command -sq docker
    and command -sq jq
    or return 1

    set -l host (docker context inspect --format '{{ .Endpoints.docker.Host }}')
    or return 1

    set -gx DOCKER_HOST $host
end
