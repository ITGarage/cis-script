#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.17 Ensure SSH access is limited' 2>&1 | tee --append $logfile
description='- Description:\nThere are several options available to limit which users and group can access the system via SSH. It is recommended that at least one of the following options be leveraged:\n  \u2022 AllowUsers - Gives the system administrator the option of allowing specific users to ssh into the system\n    \u00b0 The list consists of space separated user names\n    \u00b0 Numeric user IDs are not recognized with this variable\n    \u00b0 A system administrator may restrict user access further by only allowing the allowed users to log in from a particular host by specifying the entry as <user>@<host>\n  \u2022 AllowGroups - Gives the system administrator the option of allowing specific groups of users to ssh into the system\n    \u00b0 The list consists of space separated group names\n    \u00b0 Numeric group IDs are not recognized with this variable\n  \u2022 DenyUsers - Gives the system administrator the option of denying specific users to ssh into the system\n    \u00b0 The list consists of space separated user names\n    \u00b0 Numeric user IDs are not recognized with this variable\n    \u00b0 If a system administrator wants to restrict user access further by specifically denying a user'"'"'s access from a particular host by specifying the entry as <user>@<host>\n  \u2022 DenyGroups - Gives the system administrator the option of denying specific groups of users to ssh into the system\n    \u00b0 The list consists of space separated group names\n    \u00b0 Numeric group IDs are not recognized with this variable\n\n- Rationale:\nRestricting which users can remotely access the system via SSH will help ensure that only authorized users access the system.'

check_command=""
score_pattern=""

call_action=""

check_if "==" "$check_command" "$score_pattern"
