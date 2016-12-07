FROM ubuntu

ENV INTELLIJ_URL=https://download.jetbrains.com/idea/ideaIU-2016.3.tar.gz
ENV VS_CODE_URL=https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
ENV DISPLAY=192.168.1.1:0.0

VOLUME ["/root"]

RUN apt-get update \
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

RUN apt-get install libxss1 \
 && wget --progress=bar:force $VS_CODE_URL -O /tmp/vscode.deb \
 && dpkg -i /tmp/vscode.deb; exit 0 \
 && apt-get install -f \
 && rm -rf /tmp/*
