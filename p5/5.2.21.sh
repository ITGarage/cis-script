#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.21 Ensure SSH MaxStartups is configured' 2>&1 | tee --append $logfile
description='- Description:\nThe MaxStartups parameter specifies the maximum number of concurrent unauthenticated connections to the SSH daemon.\n\nNote: Local site policy may be more restrictive.\n\n- Rationale:\nTo protect a system from denial of service due to a large number of pending authentication connection attempts, use the rate limiting function of MaxStartups to protect availability of sshd logins and prevent overwhelming the daemon.'

check_command="sshd -T | grep -i maxstartups"
score_pattern="sshd -T | grep -i 'maxstartups 10:30:100'"

call_action="sed --in-place "'"'"s/^.*MaxStartups.*$/MaxStartups 10:30:100/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
