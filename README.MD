# Minecraft Server
A simple, vanilla *Minecraft* server running in a docker container.

## Minimum
`docker run --publish 25565:25565 minecraft-server`

## With a container name
`docker run --publish 25565:25565 --name my-server minecraft-server`

## Persistent storage
`docker run --volume /path/to/host/storage:/usr/share/minecraft/universe --publish 25565:25565 minecraft-server`

## Set World Name
`docker run --env WORLD="My World" --publish 25565:25565 minecraft-server`

## Memory Options
`docker run --env MEMORY_START="1G" --env MEMORY_START="2G" --publish 25565:25565 minecraft-server`

## Start with interactive server shell
`docker run --interactive --tty --publish 25565:25565 minecraft-server`

## Attach to running minecraft server shell
`docker attach container-name`

## Additional Environment Variables
* `UNIVERSE` - Minecraft universe directory on container (where world directories are stored)
    * Default: `/usr/share/minecraft/universe`
* `PORT` - Minecraft server port number
    * Default: `25565`
    * Advise changing the host listen port in the publish syntax instead, i.e. `--publish 1337:25565` to publish on port 1337
* `EXTRA` - Additional options to append to the command line arguments when starting the server
    * Default: `--bonusChest`
