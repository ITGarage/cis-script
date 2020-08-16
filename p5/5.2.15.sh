#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.15 Ensure SSH Idle Timeout Interval is configured' 2>&1 | tee --append $logfile
description='- Description:\nThe two options ClientAliveInterval and ClientAliveCountMax control the timeout of ssh sessions.\n  \u2022 ClientAliveInterval sets a timeout interval in seconds after which if no data has been received from the client, sshd will send a message through the encrypted channel to request a response from the client. The default is 0, indicating that these messages will not be sent to the client\n  \u2022 ClientAliveCountMax sets the number of client alive messages which may be sent without sshd receiving any messages back from the client.\nIf this threshold is reached while client alive messages are being sent, sshd will disconnect the client, terminating the session.\nThe default value is 3.\n    \u00b0 The client alive messages are sent through the encrypted channel\n    \u00b0 Setting ClientAliveCountMax to 0 disables connection termination\nExample: If the ClientAliveInterval is set to 15 seconds and the ClientAliveCountMax is set to 3, the client ssh session will be terminated after 45 seconds of idle time.\n\nNote: Local site policy may be more restrictive.\n\n- Rationale:\nHaving no timeout value associated with a connection could allow an unauthorized user access to another user'"'"'s ssh session (e.g. user walks away from their computer and doesn'"'"'t lock the screen). Setting a timeout value reduces this risk.\n  \u2022 The recommended ClientAliveInterval setting is 300 seconds (5 minutes)\n  \u2022 The recommended ClientAliveCountMax setting is 3\n  \u2022 The ssh session would send three keep alive messages at 5 minute intervals. If no response is received after the third keep alive message, the ssh session would be terminated after 15 minutes.'

check_command=""
score_pattern=""

call_action=""
# TODO: idea to past 2 arguments
check_if "==" "$check_command" "$score_pattern"
