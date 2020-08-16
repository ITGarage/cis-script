#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.1.6 Ensure permissions on /etc/cron.monthly are configured' 2>&1 | tee -a $logfile
description='- Description:\nThe /etc/cron.monthly directory contains system cron jobs that need to run on a monthly basis. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.\n\nNote: Other methods, such as systemd timers, exist for scheduling jobs. If another method is used, cron should be removed, and the alternate method should be secured in accordance with local site policy.\n\n- Rationale:\nGranting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.'

check_command="stat /etc/cron.monthly/ | grep 'File:\|Access: ('"
score_pattern="stat /etc/cron.monthly/ | grep 'File:\|Access: (0700/drwx------)  Uid: (    0/    root)   Gid: (    0/    root)'"

call_action="chown root:root /etc/cron.monthly/ && chmod og-rwx /etc/cron.monthly/"

check_if "==" "$check_command" "$score_pattern"
