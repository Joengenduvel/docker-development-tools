FROM openjdk:jdk-alpine

# TODO: switch back to https when ssl handling works
ENV INTELLIJ_URL=https://download.jetbrains.com/idea/ideaIU-2016.3.tar.gz
#ENV VS_CODE_URL=https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
ENV DISPLAY=192.168.1.1:0.0

# Base X machine
RUN adduser -D dev \
 && addgroup developers \
 && addgroup dev developers \
 && chown -R dev:developers /home/dev

VOLUME ["/home/dev"]

RUN apk update \
 && apk add --no-cache dbus libx11 firefox-esr ca-certificates openssl curl \
 && update-ca-certificates \
 && ttfs=$(apk search -q ttf- | grep -v '\-doc') \
 && apk add $ttfs

# Developer tools
RUN apk add --no-cache git nodejs

RUN curl -L -o /tmp/intellij.tar.gz $INTELLIJ_URL \
	&& tar -xzf /tmp/intellij.tar.gz -C /bin \
	&& ln -s /bin/idea-IU-*/bin/idea.sh /usr/bin/intellij

RUN rm -rf /var/cache/apk/* \
 && rm -rf /tmp/*

RUN chown -R dev:developers /home/dev

USER dev
RUN cd ~
