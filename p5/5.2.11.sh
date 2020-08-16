#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.11 Ensure SSH PermitUserEnvironment is disabled' 2>&1 | tee --append $logfile
description='- Description:\nThe PermitUserEnvironment option allows users to present environment options to the ssh daemon.\n\n- Rationale:\nPermitting users the ability to set environment variables through the SSH daemon could potentially allow users to bypass security controls (e.g. setting an execution path that has ssh executing trojan'"'"'d programs).'

check_command="sshd -T | grep permituserenvironment"
score_pattern="sshd -T | grep -E 'permituserenvironment no'"

call_action="sed --in-place "'"'"s/^.*PermitUserEnvironment.*$/PermitUserEnvironment no/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
