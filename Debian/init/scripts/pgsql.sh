#!/usr/bin/env bash

apt-get install wget curl ca-certificates lsb-release -y
RELEASE=$(lsb_release -cs)
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ ${RELEASE}"-pgdg main | tee  /etc/apt/sources.list.d/pgdg.list
