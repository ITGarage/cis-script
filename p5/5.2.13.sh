#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.13 Ensure only strong MAC algorithms are used' 2>&1 | tee --append $logfile
description='- Description:\nThis variable limits the types of MAC algorithms that SSH can use during communication.\n\nNotes:\n  \u2022 Some organizations may have stricter requirements for approved MACs\n  \u2022 Ensure that MACs used are in compliance with site policy\n  \u2022 The only "strong" MACs currently FIPS 140-2 approved are:\n    \u00b0 hmac-sha2-256\n    \u00b0 hmac-sha2-512\n  \u2022 The Supported MACs are:\nhmac-md5, hmac-md5-96, hmac-sha1, hmac-sha1-96, hmac-sha2-256, hmac-sha2-512, umac-64@openssh.com, umac-128@openssh.com, hmac-md5-etm@openssh.com, hmac-md5-96-etm@openssh.com, hmac-sha1-etm@openssh.com, hmac-sha1-96-etm@openssh.com, hmac-sha2-256-etm@openssh.com, hmac-sha2-512-etm@openssh.com, umac-64-etm@openssh.com, umac-128-etm@openssh.com\n\n- Rationale:\nMD5 and 96-bit MAC algorithms are considered weak and have been shown to increase exploitability in SSH downgrade attacks. Weak algorithms continue to have a great deal of attention as a weak spot that can be exploited with expanded computing power. An attacker that breaks the algorithm could take advantage of a MiTM position to decrypt the SSH tunnel and capture credentials and information.'

check_command="sshd -T | grep -i 'MACs'"
score_pattern="sshd -T | grep --extended-regexp 'MACs\|hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1|hmac-sha1-96|umac-64@openssh.com|umac-128@openssh.com|hmac-md5-etm@openssh.com|hmac-md5-96-etm@openssh.com|hmac-ripemd160-etm@openssh.com|hmac-sha1-etm@openssh.com|hmac-sha1-96-etm@openssh.com|umac-64-etm@openssh.com|umac-128-etm@openssh.com'"

call_action=""
# TODO: create call action
check_if "!=" "$check_command" "$score_pattern"
