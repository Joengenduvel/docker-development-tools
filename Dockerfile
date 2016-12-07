FROM ubuntu

ENV INTELLIJ_URL=https://download.jetbrains.com/idea/ideaIU-2016.3.tar.gz

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
