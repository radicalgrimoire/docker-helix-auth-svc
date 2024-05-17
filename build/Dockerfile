FROM ubuntu:22.04
LABEL maintainer "ueno.s <ueno.s@gamestudio.co.jp>"

# Add external files
ADD files/run.sh /usr/local/bin/run.sh

ARG P4NAME=master
ARG P4TCP=1666
ARG P4USER=super
ARG P4PASSWD=Passw0rd
ARG P4CASE=0
ARG P4HOME=/opt/perforce/servers

ENV P4NAME=$P4NAME \
    P4TCP=$P4TCP \
    P4PORT=ssl:$P4TCP \
    P4USER=$P4USER \
    P4PASSWD=$P4PASSWD \
    P4HOME=$P4HOME \
    P4ROOT=$P4HOME/$P4NAME \
    CASE_INSENSITIVE=$P4CASE

ENV DEBIAN_FRONTEND noninteractive

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update -y && apt-get install -y wget gnupg less language-pack-ja-base language-pack-ja tzdata curl jq git openssl sudo vim wget unzip cron logrotate init systemd build-essential npm nodejs node-gyp apt-utils build-essential curl git

ARG USERNAME=perforce
ARG GROUPNAME=perforce
ARG UID=1000
ARG GID=1000
ARG PASSWORD=perforce

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo 'export LANG=ja_JP.UTF-8' >> ~/.bashrc ;\
    echo 'export LANGUAGE="ja_JP:ja"' >> ~/.bashrc

RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - ;\
echo "deb http://package.perforce.com/apt/ubuntu jammy release" > /etc/apt/sources.list.d/perforce.sources.list

RUN curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -

RUN apt-get update -y    
RUN apt-get upgrade -y
RUN apt remove libnode-dev -y
RUN apt autoremove -y
RUN apt install -y nodejs
RUN apt install -y helix-auth-svc
RUN npm i -g pm2

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN apt autoremove -y




 
EXPOSE 3000

CMD ["/usr/local/bin/run.sh"]
