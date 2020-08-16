#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.20 Ensure SSH AllowTcpForwarding is disabled' 2>&1 | tee --append $logfile
description='- Description:\nSSH port forwarding is a mechanism in SSH for tunneling application ports from the client to the server, or servers to clients. It can be used for adding encryption to legacy applications, going through firewalls, and some system administrators and IT professionals use it for opening backdoors into the internal network from their home machines.\n\n- Rationale:\nLeaving port forwarding enabled can expose the organization to security risks and backdoors.\nSSH connections are protected with strong encryption. This makes their contents invisible to most deployed network monitoring and traffic filtering solutions. This invisibility carries considerable risk potential if it is used for malicious purposes such as data exfiltration. Cybercriminals or malware could exploit SSH to hide their unauthorized communications, or to exfiltrate stolen data from the target network'

check_command="sshd -T | grep -i allowtcpforwarding"
score_pattern="sshd -T | grep -i 'allowtcpforwarding no'"

call_action="sed --in-place "'"'"s/^.*AllowTcpForwarding.*$/AllowTcpForwarding no/"'"'" /etc/ssh/sshd_config"

check_if "==" "$check_command" "$score_pattern"
