# Minecraft Server
A simple, vanilla *Minecraft* server running in a docker container.

## Minimum
`docker run --detach --publish 25565:25565 jignate/minecraft-server`

* `--detach` - Run container in background
* `--publish 25565:25565` - Maps the host port (first number) to the container's port (second number)
* `jignate/minecraft-server` - Server image hosted at Docker Hub

## With a container name
`docker run --name my-server --detach --publish 25565:25565 jignate/minecraft-server`

## Persistent storage
`docker run --volume /path/to/host/storage:/usr/share/minecraft/universe --detach --publish 25565:25565 jignate/minecraft-server`

## Set World Name
`docker run --env WORLD="My World" --detach --publish 25565:25565 jignate/minecraft-server`

## Memory Options
`docker run --env MEMORY_START="1G" --env MEMORY_START="2G" --detach --publish 25565:25565 jignate/minecraft-server`

## Start with interactive server shell
`docker run --interactive --tty --publish 25565:25565 jignate/minecraft-server`

## Attach to running minecraft server shell
Start with interactive, but also detach
`docker run --detach --interactive --tty --publish 25565:25565 --name my-container-name jignate/minecraft-server`

Re-attach to issue console commands
`docker attach my-container-name`

## Open shell in running container
`docker exec --interactive --tty my-container-name /bin/sh`

## Additional Environment Variables
* `UNIVERSE` - Minecraft universe directory on container (where world directories are stored)
    * Default: `/usr/share/minecraft/universe`
* `PORT` - Minecraft server port number
    * Default: `25565`
    * Advise changing the host listen port in the publish syntax instead, i.e. `--publish 1337:25565` to publish on port 1337
* `EXTRA` - Additional options to append to the command line arguments when starting the server
    * Default: `--bonusChest`
