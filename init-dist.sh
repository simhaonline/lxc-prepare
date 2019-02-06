#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR/packages

## First update before any install
apt update

## Run distribution specific script
source ${DIR}/distro.sh

## Run pre install scripts and collect package bundles
pkbundles=()
for bundle in $*; do
   cmd=${DIR}/scripts/${bundle}.sh
   [[ -f "$cmd" ]] && source $cmd

   pk=${DIR}/packages/${bundle}
   if [[ -f "$pk" ]]
   then
      pkbundles+=("$bundle")
   fi
done

## Update because apt sources may change
apt update

## Install package bundles
apt upgrade -y
echo "${pkbundles[@]}" | xargs cat | xargs apt install -y

## Execute package dependent scripts if exists
for bundle in $*; do
   cmd=${DIR}/scripts/${bundle}-post.sh
   [[ -f "$cmd" ]] && source $cmd
done