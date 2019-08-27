 # This is DEBIAN
FROM csanchez/jenkins-swarm-slave:latest

USER root

# add NodeJS and Chrome sources
RUN apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google.list

# install packages
RUN apt update \
    && apt-get install -y

RUN groupadd docker && usermod -aG docker jenkins-slave
# RUN apt-get install sudo -y && usermod -aG sudo jenkins-slave

ENV DOCKERVERSION=18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

# USER root