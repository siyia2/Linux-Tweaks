#!/bin/bash

device_found=false

# Check if /dev/sdb exists
if [ -b /dev/sdb ] && [ ! -b /dev/sdb1 ]; then
    echo "Running ntfsfix on /dev/sdb"
    # Run ntfsfix in the background
    nohup sudo ntfsfix -d /dev/sdb > /dev/null 2>&1 &
    nohup bash -c "sleep 1; notify-send 'NTFS Fix' 'ΠΕΡΙΜΕΝΕΤΕ ΜΕΡΙΚΑ ΔΕΥΤΕΡΟΛΕΠΤΑ ΜΕΧΡΙ ΝΑ ΟΛΟΚΛΗΡΩΘΕΙ Η ΕΠΙΣΚΕΥΗ'" > /dev/null 2>&1 &
    # Delay notification by 10 seconds and run in background
    nohup bash -c "sleep 10; notify-send 'NTFS Fix' 'ntfsfix ran successfully on /dev/sdb.'" > /dev/null 2>&1 &
    device_found=true
fi

# Check if /dev/sdb1 exists
if [ -b /dev/sdb1 ]; then
    echo "Running ntfsfix on /dev/sdb1"
    # Run ntfsfix in the background
    nohup sudo ntfsfix -d /dev/sdb1 > /dev/null 2>&1 &
    nohup bash -c "sleep 1; notify-send 'NTFS Fix' 'ΠΕΡΙΜΕΝΕΤΕ ΜΕΡΙΚΑ ΔΕΥΤΕΡΟΛΕΠΤΑ ΜΕΧΡΙ ΝΑ ΟΛΟΚΛΗΡΩΘΕΙ Η ΕΠΙΣΚΕΥΗ'" > /dev/null 2>&1 &
    # Delay notification by 10 seconds and run in background
    nohup bash -c "sleep 10; notify-send 'NTFS Fix' 'ntfsfix ran successfully on /dev/sdb1.'" > /dev/null 2>&1 &
    device_found=true
fi

# If neither /dev/sdb nor /dev/sdb1 exists
if [ "$device_found" = false ]; then
    nohup bash -c "sleep 10; notify-send 'NTFS Fix' 'Neither /dev/sdb nor /dev/sdb1 exists.'" > /dev/null 2>&1 &
fi

