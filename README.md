# Docker images for Counter-Strike:Source dedicated servers

Images are available on [Docker Hub](https://hub.docker.com/r/tractr/counter-strike-source-servers).

## Base image

Built from [foxylion/steam-css](https://hub.docker.com/r/foxylion/steam-css) with additional configuration.

### Start the image with all options

```bash
docker run -d --name css-server-27015 \
           -p 27015:27015 -p 27015:27015/udp -p 1200:1200 \
           -p 27005:27005/udp -p 27020:27020/udp -p 26901:26901/udp \
           -e RCON_PASSWORD="mypassword" \
           -e CSS_PASSWORD="csspassword" \
           -e CSS_PORT="27015" \
           -e CSS_TV_PORT="27020" \
           -e CSS_CLIENT_PORT="27005" \
           -e CSS_TICKRATE="100" \
           -e CSS_MAXPLAYERS="16" \
           -e CSS_STARTMAP="de_dust2" \
           -e CSS_HOSTNAME="My server name" \
           -e CSS_SVLAN="1" \
           -e CSS_BOTS_FILL="8" \
           tractr/counter-strike-source-servers:latest
```

### Available environment variables

| Name              | Description                               | Default Value                   |
|-------------------|-------------------------------------------|---------------------------------|
| `RCON_PASSWORD`   | RCON password                             | Random password                 |
| `CSS_PASSWORD`    | Server password                           |                                 |
| `CSS_PORT`        | Server port                               | `27015`                         |
| `CSS_TV_PORT`     | TV port                                   | `27020`                         |
| `CSS_CLIENT_PORT` | Client port                               | `27005`                         |
| `CSS_TICKRATE`    | Server tickrate                           | `100`                           |
| `CSS_MAXPLAYERS`  | Max players                               | `16`                            |
| `CSS_STARTMAP`    | Start map                                 | `de_dust2`                      |
| `CSS_HOSTNAME`    | Server name                               | `Counter-Strike: Source Server` |
| `CSS_SVLAN`       | LAN server                                | `0`                             |
| `CSS_BOTS_FILL`   | Add bots to reach a min number of players | `0`                             |

### Custom mapcycle.txt

```
-v /path/to/mapcycle.txt:/home/steam/css/cstrike/cfg/mapcycle.txt
```

### Modified server.cfg

The default server.cfg can also be overridden, but you can also only override some specific settings, therefore use the following pattern

```
-v /path/to/my-server.cfg:/home/steam/css/cstrike/cfg/my-server.cfg
```

### More information

Check the original [image on GitHub](https://github.com/foxylion/docker-steam-css) for more details.

## Hide and Seek

Built from [foxylion/steam-css](https://hub.docker.com/r/foxylion/steam-css) with [Hide and Seek](https://forums.alliedmods.net/showthread.php?p=2647181) plugin.

### Configuration

Available configurations are listed [here](https://github.com/blackdevil72/SM-Hide-and-Seek).

You should set `sm_hns_enable 1` in the `server.cfg` file.

## Build the image

```bash
docker build . --tag tractr/counter-strike-source-servers:latest --target classic
```

```bash
docker build . --tag tractr/counter-strike-source-servers:hide-and-seek --target hide-and-seek
```

### Build and push all images

```bash
docker build . --tag tractr/counter-strike-source-servers:latest --target classic && \
docker push tractr/counter-strike-source-servers:latest && \
docker build . --tag tractr/counter-strike-source-servers:classic --target classic && \
docker push tractr/counter-strike-source-servers:classic && \
docker build . --tag tractr/counter-strike-source-servers:hide-and-seek --target hide-and-seek && \
docker push tractr/counter-strike-source-servers:hide-and-seek
```
