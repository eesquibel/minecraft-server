FROM alpine:latest

RUN apk add --no-cache \
    tini \
    openjdk17-jre-headless \
	libudev-zero-dev \
    ;

ARG SERVER_JAR_URL=https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

ADD $SERVER_JAR_URL /usr/share/minecraft/server.jar
ADD server.sh /usr/share/minecraft/

RUN chmod +x /usr/share/minecraft/server.sh

WORKDIR /usr/share/minecraft/

RUN /usr/bin/java -jar server.jar --nogui --initSettings

RUN echo "eula=true" > /usr/share/minecraft/eula.txt

VOLUME [ "/usr/share/minecraft/universe" ]

ARG MEMORY_START=2G
ARG MEMORY_MAX=4G
ARG PORT=25565
ARG UNIVERSE=/usr/share/minecraft/universe
ARG WORLD=world
ARG EXTRA="--bonusChest"

ENV JAVA_XMS="-Xms${MEMORY_START}"
ENV JAVA_XMX="-Xmx${MEMORY_MAX}"
ENV PORT=${PORT}
ENV UNIVERSE=${UNIVERSE}
ENV WORLD=${WORLD}
ENV EXTRA=${EXTRA}

EXPOSE ${PORT}

WORKDIR /usr/share/minecraft/

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/usr/share/minecraft/server.sh"]
