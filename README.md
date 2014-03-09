off-site-backup-script
======================

Use
----

I use this script to make my weekly offsite backup to my external drive which I then bring back to my parents. Maybe someone looks for something similar so have fun with it.

Installation
----

Download the script and run the following command

```
chmod +x offsite-backup.sh
```

Note: this is just so the colored output works.

Configuration
----

Change the following settings for your needs

```
DVC='sde1'                # external drive device, eg. /dev/sde1
MNTPNT='/mnt/off-site'    # mount point for external drive
BCKPLCTN='/srv/DATA'      # location which should be synced with external drive
WTTM='10'                 # wait time for devices, use higher value on older drives
```

Run the script
----

Simply run the script via

```
./offsite-backup.sh
```

and get a cup of coffee.

Tested
----

I tested the script ob Debian and Ubuntu, but It should work with other systems aswell