#!/bin/sh
wait
modprobe -r iwldvm
wait
modprobe -r iwlwifi
wait

exit