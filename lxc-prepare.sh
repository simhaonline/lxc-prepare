#!/bin/bash

CONTAINER=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DISTRO=$(lxc config get $CONTAINER image.os)
INITDIR=$(realpath $DIR/$DISTRO/init)

## Check if mounted disk already set
INIT_SCRIPTS=$(lxc config device list $CONTAINER | grep 'init_scripts')
if [[ -z "$INIT_SCRIPTS" ]]
then
    lxc config device add $CONTAINER init_scripts disk source=$INITDIR path=/opt/init
fi

shift
## Set other config values

## Idmap should be defined in profile otherwise should be set like this
# lxc config set $CONTAINER raw.idmap "both 1000 1000"

## Set container templates here if any

## Check if container is running
RUNNING=$(lxc info $CONTAINER | grep 'Status: Stopped')
if [[ ! -z "$RUNNING" ]]
then
    lxc start $CONTAINER
fi

## Make init script available for container
cp $DIR/init-dist.sh $INITDIR/init.sh

## Run container's init script
lxc exec $CONTAINER /opt/init/init.sh "$@"

## Unset init mount settings
lxc config device remove $CONTAINER init_scripts
