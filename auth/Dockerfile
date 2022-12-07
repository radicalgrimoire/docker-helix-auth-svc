FROM ghcr.io/radicalgrimoire/docker-helix-auth-svc/helix-auth-svc:latest

LABEL maintainer "ueno.s <ueno.s@gamestudio.co.jp>"

COPY files/ecosystem.config.js /opt/perforce/helix-auth-svc/ecosystem.config.js
COPY files/run.sh /usr/local/bin/run.sh

EXPOSE 3000

