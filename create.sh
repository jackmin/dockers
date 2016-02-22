#!/bin/sh

docker create --name=work --hostname=work --privileged -v exiumin_data:/exiumin exiumin/devenv
