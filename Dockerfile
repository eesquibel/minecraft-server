FROM alpine:latest

RUN apk add --no-cache \
    tini \
    openjdk11-jdk \
    ;

ADD https://papermc.io/api/v1/paper/1.16.4/288/download /usr/share/minecraft/server.jar
ADD server.sh /usr/share/minecraft/

RUN chmod +x /usr/share/minecraft/server.sh

WORKDIR /usr/share/minecraft/

RUN echo "eula=true" > /usr/share/minecraft/eula.txt

VOLUME [ "/usr/share/minecraft/universe" ]

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
