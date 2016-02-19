#!/bin/sh

docker create --name=work --hostname=work --privileged -v /lib/:/lib/ -v /usr/lib/:/usr/lib/ -v /usr/bin/docker:/bin/docker -v /var/run/docker.sock:/var/run/docker.sock exiumin/devenv
