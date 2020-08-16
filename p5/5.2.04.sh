#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.4 Ensure SSH LogLevel is appropriate' 2>&1 | tee -a $logfile
description='- Description:\nLogLevel gives the verbosity level that is used when logging messages from sshd(8). The possible values are: QUIET, FATAL, ERROR, INFO, VERBOSE, DEBUG, DEBUG1, DEBUG2 and DEBUG3.\n\nNote: The newer OpenSSH releases do not need a verbose mode setting anymore as the required SSH key activity information is written into the syslog by the default OpenSSH config\n\n- Rationale:\nSSH provides several logging levels with varying amounts of verbosity. The DEBUG loglevels are specifically not recommended other than for strictly debugging SSH communications since it provides so much data that it is difficult to identify important security information and may violate the privacy of users.\nLogLevel INFO is the basic level that records login activity of SSH users. In many situations, such as Incident Response, it is important to determine when a particular user was active on a system. The logout record can eliminate those users who disconnected, which helps narrow the field'

check_command="sshd -T | grep --extended-regexp 'loglevel'"
score_pattern="sshd -T | grep --extended-regexp 'loglevel DEBUG|loglevel DEBUG1|loglevel DEBUG2|loglevel DEBUG3'"

call_action='case_loglevel_set'

check_if "!=" "$check_command" "$score_pattern"
