#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.18 Ensure SSH warning banner is configured' 2>&1 | tee --append $logfile
description='- Description:\nThe Banner parameter specifies a file whose contents must be sent to the remote user before authentication is permitted. By default, no banner is displayed.\n\n- Rationale:\nBanners are used to warn connecting users of the particular site'"'"'s policy regarding connection. Presenting a warning message prior to the normal user login may assist the prosecution of trespassers on the computer system.'

check_command="sshd -T | grep banner"
score_pattern="sshd -T | grep 'banner /etc/issue.net'"

call_action=""
# TODO: call action text from https://help.ubuntu.com/community/SSH/OpenSSH/Configuring#Display_a_Banner
check_if "==" "$check_command" "$score_pattern"
