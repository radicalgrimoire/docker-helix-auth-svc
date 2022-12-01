FROM ubuntu:focal
LABEL maintainer "ueno.s <ueno.s@gamestudio.co.jp>"

# Add external files
COPY files/run.sh /usr/local/bin/run.sh

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

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update -y \
    && apt-get install -y wget gnupg less language-pack-ja-base language-pack-ja tzdata curl jq git openssl sudo vim wget unzip cron logrotate init systemd

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo 'export LANG=ja_JP.UTF-8' >> ~/.bashrc ;\
    echo 'export LANGUAGE="ja_JP:ja"' >> ~/.bashrc

RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - ;\
    echo "deb http://package.perforce.com/apt/ubuntu focal release" >> /etc/apt/sources.list.d/perforce.list

RUN apt-get update && apt-get -y install helix-auth-svc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

HEALTHCHECK \
    --interval=2m \
    --timeout=30s \
    CMD p4 -p ssl:1666 info -s > /dev/null || exit 1

CMD ["/usr/local/bin/run.sh"]