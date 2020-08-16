#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.16 Ensure SSH LoginGraceTime is set to one minute or less' 2>&1 | tee -a $logfile
description='- Description:\nThe LoginGraceTime parameter specifies the time allowed for successful authentication to the SSH server. The longer the Grace period is the more open unauthenticated connections can exist. Like other session controls in this session the Grace Period should be limited to appropriate organizational limits to ensure the service is available for needed access.\n\nNote: Local site policy may be more restrictive\n\n- Rationale:\nSetting the LoginGraceTime parameter to a low number will minimize the risk of successful brute force attacks to the SSH server. It will also limit the number of concurrent unauthenticated connections While the recommended setting is 60 seconds (1 Minute), set the number based on site policy.'

check_command="sshd -T | grep logingracetime | awk '{print \$2}'"
score_pattern="60"
x="sed --in-place "'"'"s/^.*LoginGraceTime.*$/LoginGraceTime \$value/"'"'" /etc/ssh/sshd_config"

call_action='set_value_gt0 "-le" "$check_command" "$score_pattern" "$x"'

check_if '-le' "$check_command" "$score_pattern"