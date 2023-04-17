#!/bin/sh

modprobe -r iwldvm
wait
modprobe -r iwlwifi
wait
modprobe iwldvm
wait
modprobe iwlwifi
wait
systemctl restart NetworkManager
wait
exit
