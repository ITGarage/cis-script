#!/usr/bin/env bash
rsync --recursive --links /home/ef/cis-script usrv:/home/ef/cis-backup/"$(date +"%Y-%m-%d-%H-%M")"/
# rsync --recursive --progress /home/ef/cis-script usrv:/home/ef/cis-backup/"$(date +"%Y-%m-%d")"/"$(date +"%H")"/"$(date +"%M")"/
# crontab -e */5 * * * * /home/ef/cis-script/test/rsync.sh
# date=$(date +"%Y-%m-%d")
# hour=$(date +"%H")
# minute=$(date +"%M")
# rsync --rsync-path="mkdir -p /home/ef/cis-backup/"$day"/"$hour"/"$minute"/" && rsync --recursive --progress /home/ef/cis-script usrv:/home/ef/cis-backup/"$day"/"$hour"/"$minute"/

# rsync --rsync-path="mkdir -p usrv:/home/ef/cis-backup/"$(date +"%Y-%m-%d")"/"$(date +"%H")"/"$(date +"%M")"/" && rsync --recursive /home/ef/cis-script usrv:/home/ef/cis-backup/"$(date +"%Y-%m-%d")"/"$(date +"%H")"/"$(date +"%M")"/