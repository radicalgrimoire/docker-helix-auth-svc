#!/bin/bash

if [ ! -d "/tmp/check" ]; then

mkdir /tmp/check
  pushd /opt/perforce
  wget https://github.com/perforce/helix-authentication-service/archive/refs/tags/2020.2.zip
  unzip 2020.2.zip
  rm -Rf /opt/perforce/2020.2.zip
  chown -R perforce:perforce /opt/perforce/helix-authentication-service-2020.2
  mv /opt/perforce/helix-authentication-service-2020.2 /opt/perforce/helix-auth-svc
  pushd /opt/perforce/helix-auth-svc
  sudo -E -u perforce bash install.sh -n
  popd
  echo `date` > /tmp/check/first_`date +%Y%m%d_%H%M%S`

else
  echo `date` > /tmp/check/second_`date +%Y%m%d_%H%M%S`
  
fi

exec "$@"
