# Tripviss Monitoring

## Prerequisites

*   [Docker](https://docs.docker.com/engine/docker-overview/) >= `v17.05.0-ce`
*   [Docker Compose](https://docs.docker.com/compose/overview/) >= `v1.14.0`

## Preparation

Note: The command examples below are for a Ubuntu 16.04 host.

1.  Enable metrics in Docker.

    ```sh
    sudo apt-get install -y jq

    { sudo cat /etc/docker/daemon.json 2>/dev/null || echo '{}'; } | jq '. + {"experimental": true, "metrics-addr": "0.0.0.0:9323"}' | sudo tee /etc/docker/daemon.json.tmp && sudo mv /etc/docker/daemon.json.tmp /etc/docker/daemon.json

    sudo systemctl restart docker
    ```

## How to run

1.  Prepare the `docker-compose.override.yml` file.

    You may copy from the default template file (`docker-compose.override.yml.dist`), then modify as necessary.

2.  Pull the images.

    ```sh
    docker-compose pull
    ```

3.  Create and run the services.

    1.  In a development environment, it is easier to just use Docker Compose.

        ```sh
        docker-compose up -d
        ```

    2.  In a production environment, the services should be deployed using Docker Engine's [swarm mode](https://docs.docker.com/engine/swarm/).

        1.  Generate a combined Docker Compose file:

            ```sh
            docker-compose config --resolve-image-digests > docker-stack.prod.yml
            ```

            Then manually apply any changes as necessary.

        2. Deploy!

            ```sh
            docker stack deploy -c docker-stack.prod.yml tripvissmonitoring
            ```
