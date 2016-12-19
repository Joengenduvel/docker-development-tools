FROM openjdk:jdk-alpine

# TODO: switch back to https when ssl handling works
ENV INTELLIJ_URL=http://download.jetbrains.com/idea/ideaIU-2016.3.tar.gz
#ENV VS_CODE_URL=https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
ENV DISPLAY=192.168.1.1:0.0

RUN useradd -m -p dev dev
VOLUME ["/home/dev"]

apk update
apk add dbus
apk add libx11
apk add firefox-esr

#add True Type Fonts
ttfs=$(apk search -q ttf- | grep -v '\-doc')
apk add $ttfs

wget $INTELLIJ_URL -O /tmp/intellij.tar.gz \
	&& tar -xzf /tmp/intellij.tar.gz -C /bin \
	&& ln -s /bin/idea*/bin/idea.sh /bin/intellij \
	&& rm -rf /tmp/*

USER dev

SHELL ["bash"]
