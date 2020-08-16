#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.2 Ensure permissions on SSH private host key files are configured' 2>&1 | tee -a $logfile
description='- Description:\nAn SSH private key is one of two files used in SSH public key authentication. In this authentication method, The possession of the private key is proof of identity. Only a private key that corresponds to a public key will be able to authenticate successfully. The private keys need to be stored and handled carefully, and no copies of the private key should be distributed.\n\n- Rationale:\nIf an unauthorized user obtains the private SSH host key file, the host could be impersonated.'

check_command="find /etc/ssh -xdev -type f -name 'ssh_host_*_key' | xargs stat | grep 'File:\|Access: ('"
score_pattern="find /etc/ssh -xdev -type f -name 'ssh_host_*_key' | xargs stat | grep 'File:\|Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)'"

call_action="find /etc/ssh -xdev -type f -name 'ssh_host_*_key' | xargs chown root:root && find /etc/ssh -xdev -type f -name 'ssh_host_*_key' | xargs chmod 0600"

check_if "==" "$check_command" "$score_pattern"
