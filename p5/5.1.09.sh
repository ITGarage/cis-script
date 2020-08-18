#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.1.9 Ensure at is restricted to authorized users' 2>&1 | tee -a $logfile
description='- Description:\nConfigure /etc/at.allow to allow specific users to use this service. If /etc/at.allow does not exist, then /etc/at.deny is checked. Any user not specifically defined in this file is allowed to use at. By removing the file, only users in /etc/at.allow are allowed to use at.\n\nNote: Other methods, such as systemd timers, exist for scheduling jobs. If another method is used, at should be removed, and the alternate method should be secured in accordance with local site policy\n\n- Rationale:\nOn many systems, only the system administrator is authorized to schedule at jobs. Using the at.allow file to control who can run at jobs enforces this policy. It is easier to manage an allow list than a deny list. In a deny list, you could potentially add a user ID to the system and forget to add it to the deny files.'

check_command="stat /etc/at.deny && stat /etc/at.allow"
score_pattern=""

stat /etc/at.allow | grep 'File:\|Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/   root)'

# TODO: create score pattern
call_action="rm /etc/at.deny && touch /etc/at.allow && chown root:root /etc/at.allow && chmod g-wx,o-rwx /etc/at.allow"

check_if "==" "$check_command" "$score_pattern"
