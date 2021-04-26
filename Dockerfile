 # This is DEBIAN
FROM krumware/jenkins-swarm-slave-docker:3.25

USER root

# add NodeJS and Chrome sources	
RUN apt-get install -y curl \	
    && curl -sL https://deb.nodesource.com/setup_10.x | bash -

# install packages
RUN apt update \
    && apt-get install -y \
    && apt-get install -y curl \
    && apt-get install -y nodejs

RUN groupadd docker
# RUN apt-get install sudo -y && usermod -aG sudo jenkins-slave

ENV DOCKERVERSION=18.09.8
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz \
  && usermod -aG docker jenkins-slave

# USER jenkins-slave