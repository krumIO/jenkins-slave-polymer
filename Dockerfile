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
    && apt-get install -y \
    nodejs \
    build-essential \
    google-chrome-stable \
    libgconf-2-4 \
    xvfb \
    firefox-esr

#Roll back to npm 4 for certain polymer-cli version issues. This should no longer be necessary
RUN npm install -g npm 

# install Polymer cli (with web-component-tester) & bower globally, keep gulp for fancy tasks. keep bower for the time being. (you shouldn't be using it)
RUN npm install -g --unsafe-perm gulp-cli gulp bower polymer-cli && echo '{ "allow_root": true }' > /root/.bowerrc

#try to fool google-chrome to run without sandbox - from https://github.com/printminion/polymer-tester
RUN mv /usr/bin/google-chrome /usr/bin/google-chrome-orig \
    && echo '#!/bin/bash' > /usr/bin/google-chrome \
    && echo '/usr/bin/google-chrome-orig --no-sandbox --disable-setuid-sandbox --allow-sandbox-debugging "$@"' >> /usr/bin/google-chrome  \
    && chmod +x /usr/bin/google-chrome

USER jenkins-slave