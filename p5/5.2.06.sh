#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.6 Ensure SSH MaxAuthTries is set to 4 or less' 2>&1 | tee -a $logfile
description='- Description:\nThe MaxAuthTries parameter specifies the maximum number of authentication attempts permitted per connection. When the login failure count reaches half the number, error messages will be written to the syslog file detailing the login failure.\n\nNote: Local site policy may be more restrictive.\n\n- Rationale:\nSetting the MaxAuthTries parameter to a low number will minimize the risk of successful brute force attacks to the SSH server. While the recommended setting is 4, set the number based on site policy.'

check_command="sshd -T | grep maxauthtries | awk '{print \$2}'"
score_pattern="4"
x="sed --in-place "'"'"s/^.*MaxAuthTries.*$/MaxAuthTries \$value/"'"'" /etc/ssh/sshd_config"

call_action='set_value_gt0 "-le" "$check_command" "$score_pattern" "$x"'

check_if '-le' "$check_command" "$score_pattern"
