FROM java:8-jre

WORKDIR /home/

ADD assets/* ./
ADD configs/* ./
ADD plugins plugins
ADD spigot-*.jar server.jar
ADD start.sh start.sh

ENV MC_LEVEL_NAME=world
ENV MC_VIEW_DISTANCE=8
ENV MC_ENABLE_NETHER=false
ENV MC_ENABLE_END=false
ENV MC_ENABLE_PVP=true
ENV MC_DEFAULT_GAMEMODE=2
ENV MC_DIFFICULTY=0
ENV MC_MAX_PLAYERS=100
ENV MC_SERVER_NAME=test{UpperCharacter}
ENV MC_SERVER_SET=development-server

ENV MC_MIN_RAM=256M
ENV MC_MAX_RAM=512M

CMD ["bash","start.sh"]
