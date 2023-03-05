#!/bin/bash
set -e
trap '' TERM INT HUP

# Ensure CSS is up to date
if [ "$1" == "update" ]; then
	./steamcmd.sh +login anonymous +force_install_dir ./css +app_update 232330 validate +quit
fi

if [ -d /home/steam/htdocs ]; then
	echo "Copying htdocs..."
	mkdir -p /home/steam/htdocs/cstrike
	cp -fR /home/steam/css/cstrike/maps /home/steam/htdocs/cstrike
	cp -fR /home/steam/css/cstrike/sound /home/steam/htdocs/cstrike
fi

# Set default values for environment variables
export RCON_PASSWORD=${RCON_PASSWORD:-"$(pwgen -s 16 1)"}
export CSS_PASSWORD=${CSS_PASSWORD:-""}
export CSS_PORT=${CSS_PORT:-"27015"}
export CSS_TV_PORT=${CSS_TV_PORT:-"27020"}
export CSS_CLIENT_PORT=${CSS_CLIENT_PORT:-"27005"}
export CSS_TICKRATE=${CSS_TICKRATE:-"100"}
export CSS_MAXPLAYERS=${CSS_MAXPLAYERS:-"16"}
export CSS_STARTMAP=${CSS_STARTMAP:-"de_dust2"}
export CSS_HOSTNAME=${CSS_HOSTNAME:-"Counter-Strike: Source Server"}
export CSS_SVLAN=${CSS_SVLAN:-"0"}
export CSS_BOTS_FILL=${CSS_BOTS_FILL:-"0"}

cd css
./srcds_run -game cstrike +exec server.cfg +hostname "$CSS_HOSTNAME" +sv_password "$CSS_PASSWORD" +rcon_password "$RCON_PASSWORD" +map "$CSS_STARTMAP" +sv_lan "$CSS_SVLAN" +maxplayers "$CSS_MAXPLAYERS" -port "$CSS_PORT" -tv_port "$CSS_TV_PORT" -clientport "$CSS_CLIENT_PORT" -tickrate "$CSS_TICKRATE" -bot_quota "$CSS_BOTS_FILL"
