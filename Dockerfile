FROM alpine:latest

RUN apk add --no-cache \
    tini \
    openjdk21-jre \
    libudev-zero-dev \
    su-exec \
    ;

ARG PAPER_JAR_URL=https://api.papermc.io/v2/projects/paper/versions/1.20.4/builds/408/downloads/paper-1.20.4-408.jar
ARG MOJANG_JAR_URL=https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

ADD $PAPER_JAR_URL /usr/share/minecraft/server.jar
ADD $MOJANG_JAR_URL /usr/share/minecraft/cache/mojang_1.20.4.jar
ADD server.sh /usr/share/minecraft/

RUN chmod +x /usr/share/minecraft/server.sh

WORKDIR /usr/share/minecraft/

RUN echo "eula=true" > /usr/share/minecraft/eula.txt

VOLUME [ "/usr/share/minecraft/universe" ]

RUN addgroup -S papermc && adduser -S papermc -G papermc

RUN chmod -R ug+rw /usr/share/minecraft
RUN chown -R papermc:papermc /usr/share/minecraft

ARG MEMORY_START=2G
ARG MEMORY_MAX=4G
ARG PORT=25565
ARG UNIVERSE=/usr/share/minecraft/universe
ARG WORLD=world
ARG EXTRA

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
