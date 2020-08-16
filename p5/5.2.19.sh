#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.19 Ensure SSH PAM is enabled' 2>&1 | tee --append $logfile
description='- Description:\nUsePAM Enables the Pluggable Authentication Module interface. If set to “yes” this will enable PAM authentication using ChallengeResponseAuthentication and PasswordAuthentication in addition to PAM account and session module processing for all authentication types.\n\n- Rationale:\nWhen usePAM is set to yes, PAM runs through account and session types properly. This is important if you want to restrict access to services based off of IP, time or other factors of the account. Additionally, you can make sure users inherit certain environment variables on login or disallow access to the server'

check_command="sshd -T | grep -i usepam"
score_pattern="sshd -T | grep -i 'usepam yes'"

call_action="sed --in-place "'"'"s/^.*UsePAM.*$/UsePAM yes/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
