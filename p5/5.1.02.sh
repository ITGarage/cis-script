#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.1.2 Ensure permissions on /etc/crontab are configured' 2>&1 | tee -a $logfile
description='- Description:\nThe /etc/crontab file is used by cron to control its own jobs. The commands in this item make sure that root is the user and group owner of the file and that only the owner can access the file.\n\nNote: Other methods, such as systemd timers, exist for scheduling jobs. If another method is used, cron should be removed, and the alternate method should be secured in accordance with local site policy.\n\n- Rationale:\nThis file contains information on what system jobs are run by cron. Write access to these files could provide unprivileged users with the ability to elevate their privileges. Read access to these files could provide users with the ability to gain insight on system jobs that run on the system and could provide them a way to gain unauthorized privileged access.'

check_command="stat /etc/crontab | grep 'File:\|Access: ('"
score_pattern="stat /etc/crontab | grep 'File:\|Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)'"

call_action="chown root:root /etc/crontab && chmod og-rwx /etc/crontab"

check_if "==" "$check_command" "$score_pattern"
