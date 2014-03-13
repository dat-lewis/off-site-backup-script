#!/bin/bash
# off-site backup script v1.1 (13.03.2014)
# author: daniel "lws" nimmervoll
# debian-blog.org | nimmervoll.eu

# options; edit this section so it fits your needs!
DVC='sde1'                # external drive device, eg. /dev/sde1
MNTPNT='/mnt/off-site'    # mount point for external drive
BCKPLCTN='/srv/DATA'      # location which should be synced with external drive
WTTM='10'                 # wait time for devices, use higher value on older drives
EXCLDLST='--exclude-from=/root/exclude.txt' # patch to the exclude list file for rsync, comment it out if not needed

# color settings, no need to change!
RST='\e[0m'       # reset everything
GRN='\e[0;32m'    # green color
RD='\e[0;31m'     # red color
BLNK='\e[5m'      # blink, for the waiting indicator

# mount external drive
echo -en "1/6 Mounting Device: /dev/$DVC ${BLNK}..."
mount /dev/$DVC $MNTPNT >/dev/null
echo -e "${RST}\r1/6 Mounting Device: ${GRN}DONE!${RST}                          "

# wait a bit so the drive can mount correctly
echo -en "2/6 Waiting for Device ${BLNK}..."
sleep $WTTM
echo -e "${RST}\r2/6 Waiting for Device ..."

# check if device is mounted, if not abort this script
echo -en "3/6 Device mounted: ${BLNK}..."
mount | grep /dev/$DVC >/dev/null
   if [ "$?" -eq "0" ]; then
        echo -e "\r${RST}3/6 Device mounted: ${GRN}YES!${RST}                    " 
   else
        echo -e "${RST}\r3/6 Device mounted: ${RD}FAILED! ... aborting${RST}     "
        exit 1
   fi

# sync locations via rsync
echo -en "4/6 Rsync: running ${BLNK}..."
rsync $EXCLDLST -gloptru $BCKPLCTN $MNTPNT
echo -e "\r${RST}4/6 Rsync: ${GRN}DONE!${RST}                                    "

# wait a bit so the drive can finish everything
echo -en "5/6 Waiting for Device ${BLNK}..."
sleep $WTTM
echo -e "\r${RST}5/6 Waiting for Device ..."

# unmount external device
umount /dev/$DVC >/dev/null
echo -en "6/6 Unmounting Device: /dev/$DVC ${BLNK}..."

# check if device is unmounted, if not report error
mount | grep /dev/$DVC >/dev/null
   if [ "$?" -eq "0" ]; then
        echo -e "${RST}\r6/6 Unmounting Device: ${RD}Mounted! Check logs${RST}   "
   else
        echo -e "${RST}\r6/6 Unmounting Device: ${GRN}DONE!${RST}                "
   fi
