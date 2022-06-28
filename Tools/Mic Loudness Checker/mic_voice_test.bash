#!/bin/bash
RP=/tmp/volume
RPR=/tmp/volume/recordings
DAY_VOLUME_THRESHOLD='0.2'
NIGHT_VOLUME_THRESHOLD='0.1'
H=$(date +%H)

if [ ! -d $RP ]
then
echo "Creating: $RP"
mkdir -p $RP

mkdir -p $RPR
chmod -R 700 $RPR

fi

cd $RPR

for (( ; ; ))
do
while :
do
if [ "22" == "$H" ] || [ "21" == "$H" ] || [ "20" == "$H" ] || [ "19" == "$H" ] || [ "18" == "$H" ] || [ "17" == "$H" ] || [ "16" == "$H" ] || [ "15" == "$H" ] || [ "14" == "$H" ] || [ "13" == "$H" ] || [ "12" == "$H" ] || [ "11" == "$H" ] || [ "10" == "$H" ] || [ "09" == "$H" ] || [ "08" == "$H" ] || [ "07" == "$H" ] 
then
TIME=`date +%s`
VOLUME=`arecord -qd 5 volt && sox volt -n stat &> volt.d && sed '4q;d' volt.d | awk '{print $3}'`
echo "$VOLUME"

if [ 1 -eq "$(echo "${VOLUME} > ${DAY_VOLUME_THRESHOLD}" | bc)" ]
then
echo "DAY_VOLUME_THRESHOLD"
paplay ~/Music/bark.ogg
fi

fi

if [ "23" == "$H" ] || [ "00" == "$H" ] || [ "01" == "$H" ] || [ "02" == "$H" ] || [ "03" == "$H" ] || [ "04" == "$H" ] || [ "05" == "$H" ] || [ "06" == "$H" ]
then
TIME=`date +%s`
VOLUME=`arecord -qd 5 volt && sox volt -n stat &> volt.d && sed '4q;d' volt.d | awk '{print $3}'`
echo "$VOLUME"

if [ 1 -eq "$(echo "${VOLUME} > ${NIGHT_VOLUME_THRESHOLD}" | bc)" ]
then
echo "NIGHT_VOLUME_THRESHOLD"
paplay ~/Music/bark.ogg
fi

fi
sleep 1;
done

done
