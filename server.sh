#!/bin/sh

echo JAVA_XMS=${JAVA_XMS}
echo JAVA_XMX=${JAVA_XMX}
echo PORT=${PORT}
echo UNIVERSE=${UNIVERSE}
echo WORLD=${WORLD}
echo EXTRA=${EXTRA}

chown -R papermc:papermc /usr/share/minecraft
chmod -R ug+rwX /usr/share/minecraft

cd /usr/share/minecraft/

su-exec papermc /usr/bin/java $JAVA_XMS $JAVA_XMX -jar /usr/share/minecraft/server.jar \
    --nogui \
    --port ${PORT} \
    --universe "${UNIVERSE}" \
    --world "${WORLD}" \
    ${EXTRA}
