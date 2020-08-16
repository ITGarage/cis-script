#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.1.1 Ensure cron daemon is enabled and running' 2>&1 | tee -a $logfile
description='- Description:\nThe cron daemon is used to execute batch jobs on the system.\n\nNote: Other methods, such as systemd timers, exist for scheduling jobs. If another method is used, cron should be removed, and the alternate method should be secured in accordance with local site policy.\n\n- Rationale:\nWhile there may not be user jobs that need to be run on the system, the system does have maintenance jobs that may include security monitoring that have to run, and cron is used to execute them.'

check_command="systemctl is-enabled cron &&  systemctl status cron | grep 'Active' | awk '{print \$2 \$3}'"
score_pattern="systemctl is-enabled cron | grep 'enabled' &&  systemctl status cron | grep 'Active: active (running)' | awk '{print \$2 \$3}' | grep 'active(running)'"

call_action="systemctl --now enable cron"

check_if "==" "$check_command" "$score_pattern"
