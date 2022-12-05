FROM ghcr.io/radicalgrimoire/docker-helix-auth-svc/helix-auth-svc:9

LABEL maintainer "ueno.s <ueno.s@gamestudio.co.jp>"

COPY files/ecosystem.config.cjs /opt/perforce/helix-auth-svc/ecosystem.config.cjs
COPY files/run.sh /usr/local/bin/run.sh

EXPOSE 3000

