#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.9 Ensure SSH root login is disabled' 2>&1 | tee --append $logfile
description='- Description:\nThe PermitRootLogin parameter specifies if the root user can log in using ssh. The default is no.\n\n- Rationale:\nDisallowing root logins over SSH requires system admins to authenticate using their own individual account, then escalating to root via sudo or su. This in turn limits opportunity for non-repudiation and provides a clear audit trail in the event of a security incident.'

check_command="sshd -T | grep permitrootlogin"
score_pattern="sshd -T | grep -E 'permitrootlogin no'"

call_action="sed --in-place "'"'"s/^.*PermitRootLogin.*$/PermitRootLogin no/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
