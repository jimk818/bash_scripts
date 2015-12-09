#!/bin/bash
# ------------------------------------------------------------------
# [jimk818] check_service_mem.sh
#
#           This script will check system memory used by a service
#           running on servers. 
#           This script can serve as a basic monitoring as it will 
#           send an alert email out once the memory reaches the soft 
#           limit.
# ------------------------------------------------------------------


output="Checking service MEM usage on servers..."
servicename="service_name"
memsoftlimit=30
memhardlimit=32

for i in server{1..7};
       do
       mem=`ssh $i ps axu | grep $servicename | grep -v grep | awk '{ printf "%.0f",$5/1024/1024; }'`
       if [[ "$mem" -ge "$memlimit" ]]
       then
          message="WARNING: MEM on "$i" approaching hard limit of "$memhardlimit" GB"
          echo -e "Current memory usage on "$i": "$mem" GB" | mailx -s "$message" email_receipient_1 -c email_receipient_1
       fi
done

exit
