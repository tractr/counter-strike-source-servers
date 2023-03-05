# Docker images for Counter-Strike:Source dedicated servers

Images are available on [Docker Hub](https://hub.docker.com/r/tractr/counter-strike-source-servers).

## Hide and Seek

Built from [foxylion/steam-css](https://hub.docker.com/r/foxylion/steam-css) with [Hide and Seek](https://forums.alliedmods.net/showthread.php?p=2647181) plugin.

### Configuration

Available configurations are listed [here](https://github.com/blackdevil72/SM-Hide-and-Seek).

You should set `sm_hns_enable 1` in the `server.cfg` file.

Checkout the original image for more details: [foxylion/steam-css](https://hub.docker.com/r/foxylion/steam-css).

## Build the image

```bash
docker build . --tag tractr/counter-strike-source-servers:hide-and-seek --target hide-and-seek
```

### Build and push all images

```bash
docker build . --tag tractr/counter-strike-source-servers:hide-and-seek --target hide-and-seek && \
docker push tractr/counter-strike-source-servers:hide-and-seek
```
