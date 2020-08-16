#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.1.8 Ensure cron is restricted to authorized users' 2>&1 | tee -a $logfile
description='- Description:\nConfigure /etc/cron.allow to allow specific users to use this service. If /etc/cron.allow does not exist, then /etc/cron.deny is checked. Any user not specifically defined in this file is allowed to use cron. By removing the file, only users in /etc/cron.allow are allowed to use cron.\n\nNotes:\n  \u2022 Other methods, such as systemd timers, exist for scheduling jobs. If another method is used, cron should be removed, and the alternate method should be secured in accordance with local site policy\n  \u2022 Even though a given user is not listed in cron.allow, cron jobs can still be run as that user\n  \u2022 The cron.allow file only controls administrative access to the crontab command for scheduling and modifying cron jobs\n\n- Rationale:\nOn many systems, only the system administrator is authorized to schedule cron jobs. Using the cron.allow file to control who can run cron jobs enforces this policy. It is easier to manage an allow list than a deny list. In a deny list, you could potentially add a user ID to the system and forget to add it to the deny files.'

check_command="stat /etc/cron.deny && stat /etc/cron.allow"
score_pattern=""
# TODO: create score pattern
call_action="rm /etc/cron.deny && touch /etc/cron.allow && chown root:root /etc/cron.allow && chmod g-wx,o-rwx /etc/cron.allow"

check_if "==" "$check_command" "$score_pattern"
