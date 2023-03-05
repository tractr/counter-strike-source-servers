FROM foxylion/steam-css:latest as classic

# Override entrypoint
ADD ./entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
CMD ["./entrypoint.sh"]

FROM classic as hide-and-seek

RUN wget https://github.com/blackdevil72/SM-Hide-and-Seek/releases/download/1.6.0/css_hide_and_seek_1.6.0.zip -O hns.zip \
    && unzip hns.zip \
    && rm hns.zip

# Move all files contained in ./css_hide_and_seek_1.6.0/upload\ to\ server/ to /home/steam/css/cstrike and merge folders
RUN cp -r css_hide_and_seek_1.6.0/upload\ to\ server/* /home/steam/css/cstrike/ \
    && rm -rf css_hide_and_seek_1.6.0

