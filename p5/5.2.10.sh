#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.10 Ensure SSH PermitEmptyPasswords is disabled' 2>&1 | tee --append $logfile
description='- Description:\nThe PermitEmptyPasswords parameter specifies if the SSH server allows login to accounts with empty password strings.\n\n- Rationale:\nDisallowing remote shell access to accounts that have an empty password reduces the probability of unauthorized access to the system.'

check_command="sshd -T | grep permitemptypasswords"
score_pattern="sshd -T | grep -E 'permitemptypasswords no'"

call_action="sed --in-place "'"'"s/^.*PermitEmptyPasswords.*$/PermitEmptyPasswords no/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
