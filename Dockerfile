FROM alpine:latest

RUN apk add --no-cache \
    openjdk11-jdk \
    ;

ADD https://launcher.mojang.com/v1/objects/35139deedbd5182953cf1caa23835da59ca3d7cd/server.jar /usr/share/minecraft/server.jar
ADD server.sh /usr/share/minecraft/

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

CMD ["/usr/share/minecraft/server.sh"]
