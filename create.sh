#!/bin/sh

docker create -w /exiumin/src --name=work --hostname=work --privileged -v exiumin_data:/exiumin exiumin/devenv
