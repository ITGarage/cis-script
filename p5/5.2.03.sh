#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.3 Ensure permissions on SSH public host key files are configured' 2>&1 | tee --append $logfile
description='- Description:\nAn SSH public key is one of two files used in SSH public key authentication. In this authentication method, a public key is a key that can be used for verifying digital signatures generated using a corresponding private key. Only a public key that corresponds to a private key will be able to authenticate successfully.\n\n- Rationale:\nIf a public host key file is modified by an unauthorized user, the SSH service may be compromised.'

check_command="find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' | xargs stat | grep 'File\|Access: ('"
score_pattern="find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' | xargs stat | grep 'File\|Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)'"

call_action="find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' | xargs chown root:root && find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' | xargs chmod go-wx"

check_if "==" "$check_command" "$score_pattern"
