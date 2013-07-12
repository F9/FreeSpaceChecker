#!/bin/sh
df -H | grep -vE '^Filesystem|tmpfs|cdrom|tmpfs|none|rootfs|none|sda1|mmcblk0p1' | awk '{ print $5 " " $1 }' | while
read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 95 ]; then
      echo "Running out of space \"$partition ($usep%)\" on $(hostname)
      as on $(date)" |
      wget http://www.9lli.it/warez/sendmail.php?msg=low_space_on_$partition
      rm sendmail.php?msg=low_space_on_*
   fi
done
