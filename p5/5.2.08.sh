#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.8 Ensure SSH HostbasedAuthentication is disabled' 2>&1 | tee --append $logfile
description='- Description:\nThe HostbasedAuthentication parameter specifies if authentication is allowed through trusted hosts via the user of .rhosts, or /etc/hosts.equiv, along with successful public key client host authentication. This option only applies to SSH Protocol Version 2.\n\n- Rationale:\nEven though the .rhosts files are ineffective if support is disabled in /etc/pam.conf, disabling the ability to use .rhosts files in SSH provides an additional layer of protection.'

check_command="sshd -T | grep hostbasedauthentication"
score_pattern="sshd -T | grep -E 'hostbasedauthentication no'"

call_action="sed --in-place "'"'"s/^.*HostbasedAuthentication.*$/HostbasedAuthentication no/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
