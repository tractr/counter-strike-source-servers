FROM foxylion/steam-css:latest as classic

# Override entrypoint
ADD ./entrypoint.sh entrypoint.sh
CMD ["./entrypoint.sh"]

# Override configs
COPY --chown=steam:steam ./config/server.cfg /home/steam/css/cstrike/cfg/server.cfg

# Remove unwated plugins
RUN rm /home/steam/css/cstrike/addons/sourcemod/plugins/gem_damage_report.smx
COPY --chown=steam:steam ./config/sm_quakesounds.cfg /home/steam/css/cstrike/cfg/sourcemod/sm_quakesounds.cfg

FROM classic as hide-and-seek

# Copy maps
COPY ./config/hide-and-seek/maps-to-download.txt maps-to-download.txt
RUN wget -i maps-to-download.txt -P /home/steam/css/cstrike/maps/
RUN rm maps-to-download.txt

# Install hide and seek mod
RUN wget https://github.com/blackdevil72/SM-Hide-and-Seek/releases/download/1.6.0/css_hide_and_seek_1.6.0.zip -O hns.zip \
    && unzip hns.zip \
    && rm hns.zip
# Move all files contained in ./css_hide_and_seek_1.6.0/upload\ to\ server/ to /home/steam/css/cstrike and merge folders
RUN cp -r css_hide_and_seek_1.6.0/upload\ to\ server/* /home/steam/css/cstrike/ \
    && rm -rf css_hide_and_seek_1.6.0

# Copy hide and seek configs
COPY --chown=steam:steam ./config/hide-and-seek/server/* /home/steam/css/cstrike/cfg/

# Add line to server.cfg to load hide-and-seek.cfg
RUN echo "exec hide-and-seek.cfg" >> /home/steam/css/cstrike/cfg/server.cfg

FROM classic as gun-game

# Copy maps
COPY ./config/gun-game/maps-to-download.txt maps-to-download.txt
RUN wget -i maps-to-download.txt -P /home/steam/css/cstrike/maps/
RUN rm maps-to-download.txt

# Copy mod files
# https://forums.alliedmods.net/showthread.php?t=93977
COPY bin/sm_gungame-1.2.16.0.zip sm_gungame.zip
RUN unzip -o sm_gungame.zip -d /home/steam/css/cstrike/ \
    && rm sm_gungame.zip

# Copy GGDM mod
# https://forums.alliedmods.net/showthread.php?t=103242
COPY bin/sm_ggdm-1.8.0.zip sm_ggdm.zip
RUN unzip -o sm_ggdm.zip -d /home/steam/css/cstrike/ \
    && rm sm_ggdm.zip

# Copy Disable round end
# https://forums.alliedmods.net/showthread.php?t=80662
COPY --chown=steam:steam bin/bot_endround.smx /home/steam/css/cstrike/addons/sourcemod/plugins/bot_endround.smx

# Team change
# https://forums.alliedmods.net/showthread.php?t=197780
COPY bin/sm_teamchange-1.0.zip sm_teamchange.zip
RUN unzip -o sm_teamchange.zip -d /home/steam/css/cstrike/ \
    && rm sm_teamchange.zip

# Copy gun game configs
COPY --chown=steam:steam ./config/gun-game/server/* /home/steam/css/cstrike/cfg/
COPY --chown=steam:steam ./config/gun-game/plugin/* /home/steam/css/cstrike/cfg/gungame/css/

# Add line to server.cfg to load gun-game.cfg
RUN echo "exec gun-game.cfg" >> /home/steam/css/cstrike/cfg/server.cfg
