#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured' 2>&1 | tee -a $logfile
description='- Description:\nThe /etc/ssh/sshd_config file contains configuration specifications for sshd. The command below sets the owner and group of the file to root.\n\n- Rationale:\nThe /etc/ssh/sshd_config file needs to be protected from unauthorized changes by non-privileged users.'

check_command="stat /etc/ssh/sshd_config | grep 'File:\|Access: ('"
score_pattern="stat /etc/ssh/sshd_config | grep 'File:\|Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)'"

call_action="chown root:root /etc/ssh/sshd_config && chmod og-rwx /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
