#!/bin/bash
RP=/tmp/volume
RPR=/tmp/volume/recordings
DAY_VOLUME_THRESHOLD='0.1'
NIGHT_VOLUME_THRESHOLD='0.045'
H=$(date +%H)

if [ ! -d $RP ]
then
echo "Creating: $RP"
mkdir -p $RP
sudo mount -t tmpfs -o size=10m tmpfs $RP

mkdir -p $RPR
sudo chmod -R 700 $RPR

fi

cd $RPR

if [ "23" == "$H" ] || [ "00" == "$H" ] || [ "01" == "$H" ] || [ "02" == "$H" ] || [ "03" == "$H" ] || [ "04" == "$H" ] || [ "05" == "$H" ] || [ "06" == "$H" ]
then 
while :
do
TIME=`date +%s`
VOLUME=`arecord -qd 5 volt && sox volt -n stat &> volt.d && sed '4q;d' volt.d | awk '{print $3}'`
echo "$VOLUME"

if [ 1 -eq "$(echo "${VOLUME} > ${NIGHT_VOLUME_THRESHOLD}" | bc)" ]
then
echo "NIGHT_VOLUME_THRESHOLD"
paplay ~/Documents/bark.ogg
fi

done
fi

