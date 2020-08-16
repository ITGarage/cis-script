#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.5 Ensure SSH X11 forwarding is disabled' 2>&1 | tee --append $logfile
description='- Description:\nThe X11Forwarding parameter provides the ability to tunnel X11 traffic through the connection to enable remote graphic connections.\n\n- Rationale:\nDisable X11 forwarding unless there is an operational requirement to use X11 applications directly. There is a small risk that the remote X11 servers of users who are logged in via SSH with X11 forwarding could be compromised by other users on the X11 server.\n\nNote that even if X11 forwarding is disabled, users can always install their own forwarders.'

check_command="sshd -T | grep x11forwarding"
score_pattern="sshd -T | grep -E 'x11forwarding no'"

call_action="sed --in-place "'"'"s/^.*X11Forwarding.*$/X11Forwarding no/"'"'" /etc/ssh/sshd_config"
# TODO: maybe sed --in-place "'"'"s/^X11Forwarding.*$/X11Forwarding no/"'"'" /etc/ssh/sshd_config
check_if "==" "$check_command" "$score_pattern"
