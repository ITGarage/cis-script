#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.22 Ensure SSH MaxSessions is limited' 2>&1 | tee --append $logfile
description='- Description:\nThe MaxSessions parameter specifies the maximum number of open sessions permitted from a given connection.\n\nNote: Local site policy may be more restrictive.\n\n- Rationale:\nTo protect a system from denial of service due to a large number of concurrent sessions, use the rate limiting function of MaxSessions to protect availability of sshd logins and prevent overwhelming the daemon.'

check_command="sshd -T | grep -i maxsessions | awk '{print \$2}'"
score_pattern="10"
x="sed --in-place "'"'"s/^.*MaxSessions.*$/MaxSessions \$value/"'"'" /etc/ssh/sshd_config"

call_action='set_value_gt0 "-le" "$check_command" "$score_pattern" "$x"'

check_if "==" "$check_command" "$score_pattern"
