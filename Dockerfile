FROM java:8

MAINTAINER Roland Berger <roland.berger@exasoft.ch>

ENV AGENT_DIR  /opt/buildAgent
ENV AGENT_USER teamcity

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# add user
RUN  adduser --disabled-password --gecos '' $AGENT_USER
#    && adduser $AGENT_USER sudo \
#    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ADD docker-entrypoint.sh /docker-entrypoint.sh

VOLUME $AGENT_DIR
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 9090



