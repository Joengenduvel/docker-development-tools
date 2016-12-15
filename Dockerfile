FROM ubuntu

ENV INTELLIJ_URL=https://download.jetbrains.com/idea/ideaIU-2016.3.tar.gz
ENV VS_CODE_URL=https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
ENV DISPLAY=192.168.1.1:0.0

RUN useradd -m -p dev dev

# making sure a display manager and X11 client are installed: https://help.ubuntu.com/community/ServerGUI
RUN apt-get update \
 && apt-get install -yqq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" xauth
 && apt-get install -yqq software-properties-common \
 && apt-add-repository -y ppa:webupd8team/java \
 && apt-get -qq update \
 && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
 && apt-get install -yqq oracle-java8-set-default \
 && apt-get --purge autoremove -y software-properties-common \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
RUN wget --progress=bar:force $INTELLIJ_URL -O /tmp/intellij.tar.gz \
	&& mkdir /opt/intellij \
	&& tar -xzf /tmp/intellij.tar.gz -C /opt/intellij --strip-components=1 \
	&& rm -rf /tmp/*

RUN wget --progress=bar:force $VS_CODE_URL -O /tmp/vscode.deb
RUN dpkg -i /tmp/vscode.deb; exit 0
RUN apt-get install -yf \
 && rm -rf /tmp/*

VOLUME ["/home/dev"]

# USER dev
