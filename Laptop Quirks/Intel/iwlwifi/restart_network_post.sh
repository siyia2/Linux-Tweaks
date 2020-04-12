#!/bin/sh
wait
modprobe iwldvm
wait
modprobe iwlwifi
wait
systemctl restart NetworkManager
wait
iw reg set GR
wait
exit