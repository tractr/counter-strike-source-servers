FROM foxylion/steam-css:latest as classic

# Override entrypoint
ADD ./entrypoint.sh entrypoint.sh
CMD ["./entrypoint.sh"]

# Override configs
COPY --chown=steam:steam ./config/server.cfg /home/steam/css/cstrike/cfg/server.cfg

FROM classic as hide-and-seek

RUN wget https://github.com/blackdevil72/SM-Hide-and-Seek/releases/download/1.6.0/css_hide_and_seek_1.6.0.zip -O hns.zip \
    && unzip hns.zip \
    && rm hns.zip

# Move all files contained in ./css_hide_and_seek_1.6.0/upload\ to\ server/ to /home/steam/css/cstrike and merge folders
RUN cp -r css_hide_and_seek_1.6.0/upload\ to\ server/* /home/steam/css/cstrike/ \
    && rm -rf css_hide_and_seek_1.6.0

# Copy hide and seek configs
COPY --chown=steam:steam ./config/hide-and-seek.cfg /home/steam/css/cstrike/cfg/hide-and-seek.cfg

# Add line to server.cfg to load hide-and-seek.cfg
RUN echo "exec hide-and-seek.cfg" >> /home/steam/css/cstrike/cfg/server.cfg

FROM classic as gun-game

# https://forums.alliedmods.net/showthread.php?t=93977
# Copy mod files
COPY bin/sm_gungame-1.2.16.0.zip sm_gungame.zip
RUN unzip sm_gungame.zip -d /home/steam/css/cstrike/ \
    && rm sm_gungame.zip

# Copy maps
RUN wget https://tractr-lan-games-assets.s3.amazonaws.com/counter-strike-source/maps/gg_alleycat.bsp -O /home/steam/css/cstrike/maps/gg_alleycat.bsp
RUN wget https://tractr-lan-games-assets.s3.amazonaws.com/counter-strike-source/maps/gg_autumn.bsp -O /home/steam/css/cstrike/maps/gg_autumn.bsp
RUN wget https://tractr-lan-games-assets.s3.amazonaws.com/counter-strike-source/maps/gg_block9.bsp -O /home/steam/css/cstrike/maps/gg_block9.bsp
RUN wget https://tractr-lan-games-assets.s3.amazonaws.com/counter-strike-source/maps/gg_canyon.bsp -O /home/steam/css/cstrike/maps/gg_canyon.bsp
RUN wget https://tractr-lan-games-assets.s3.amazonaws.com/counter-strike-source/maps/gg_factory.bsp -O /home/steam/css/cstrike/maps/gg_factory.bsp
RUN wget https://tractr-lan-games-assets.s3.amazonaws.com/counter-strike-source/maps/gg_overpass.bsp -O /home/steam/css/cstrike/maps/gg_overpass.bsp

# Copy gun game configs
COPY --chown=steam:steam ./config/gun-game.cfg /home/steam/css/cstrike/cfg/gun-game.cfg
COPY --chown=steam:steam ./config/gun-game.mapcycle.txt /home/steam/css/cstrike/cfg/mapcycle.txt

# Add line to server.cfg to load gun-game.cfg
RUN echo "exec gun-game.cfg" >> /home/steam/css/cstrike/cfg/server.cfg
