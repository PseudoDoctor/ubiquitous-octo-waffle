#!/bin/bash
# local AMP VM running on cassandra.markghill.com
localHostname='ampVM'
localFQDN='amp.markghill.com'
localIP='10.44.55.27'
# local router public addresses, public IP can change and is unimportant for this script
publicFQDN='hill.onineko.com'
publicIP='174.52.36.2'
# remote addresses
remoteFQDN='guts.onineko.com'
remoteHostname='ubuntu-bionic-1'
# This should be ran on host 'ampVM' as user 'amp'
# Source       amp@ampVM:/home/amp/.ampdata/instances/Riley/Minecraft
# Destination  amp@ubuntu-bionic-1:/home/amp/.ampdata/instances/Minecraft01/Minecraft
# Old command example rsync -avPzu --exclude lost+found guts.onineko.com:/home/amp/.ampdata/instances/Minecraft01/Minecraft/ /home/amp/.ampdata/instances/Riley/Minecraft
rsyncSource=/home/amp/.ampdata/instances/Riley/Minecraft/
rsyncDestination=amp@$remoteFQDN:/home/amp/.ampdata/instances/Minecraft01/Minecraft
# rsync -avPzu
#  -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
#  -v, --verbose               increase verbosity
#  -P                          same as --partial --progress
#    --progress              show progress during transfer
#    --partial               keep partially transferred files
#  -z, --compress              compress file data during the transfer
#  -u, --update                skip files that are newer on the receiver=
rsync -avPzu $rsyncSource $rsyncDestination