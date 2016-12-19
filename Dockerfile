FROM openjdk:jdk-alpine

# TODO: switch back to https when ssl handling works
ENV INTELLIJ_URL=http://download.jetbrains.com/idea/ideaIU-2016.3.tar.gz
#ENV VS_CODE_URL=https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
ENV DISPLAY=192.168.1.1:0.0

RUN adduser -D dev \
 && addgroup developers \
 && addgroup dev developers
VOLUME ["/home/dev"]

RUN apk update \
 && apk add dbus \
 && apk add libx11 \
 && apk add firefox-esr \
 && apk add curl ca-certificates \
 && update-ca-certificates

#add True Type Fonts
RUN ttfs=$(apk search -q ttf- | grep -v '\-doc') \
 && apk add $ttfs

RUN wget $INTELLIJ_URL -O /tmp/intellij.tar.gz \
	&& tar -xzf /tmp/intellij.tar.gz -C /bin \
	&& ln -s /bin/idea*/bin/idea.sh /bin/intellij

RUN rm -rf /var/cache/apk/* \
 && rm -rf /tmp/*

USER dev
WORKDIR ~
