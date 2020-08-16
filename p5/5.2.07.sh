#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.7 Ensure SSH IgnoreRhosts is enabled' 2>&1 | tee --append $logfile
description='- Description:\nThe IgnoreRhosts parameter specifies that .rhosts and .shosts files will not be used in RhostsRSAAuthentication or HostbasedAuthentication.\n\n- Rationale:\nSetting this parameter forces users to enter a password when authenticating with ssh.'

check_command="sshd -T | grep ignorerhosts"
score_pattern="sshd -T | grep -E 'ignorerhosts yes'"

call_action="sed --in-place "'"'"s/^.*IgnoreRhosts.*$/IgnoreRhosts yes/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
