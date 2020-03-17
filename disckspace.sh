#!/bin/bash


THRESHOLD=60
mailto="root"
HOSTNAME=$(hostname)

for path in `/bin/df -H | grep -vE 'Filesystem|tmpfs|cdrom' | awk '{print $5}' | sed 's/%//g'`
do
   
    if [ $path -ge $THRESHOLD  ]
    then 
   
        df -kh | grep $path >> /tmp/temp
    fi
done

VALUE=`cat /tmp/temp | wc -1`

       if [  $VALUE -ge 1 ] 
       then
           mail -s "$HOSTNAME Disk Usage is Critical"  
#$mailto << /tmp/temp
       fi
