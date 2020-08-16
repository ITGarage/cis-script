#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.14 Ensure only strong Key Exchange algorithms are used' 2>&1 | tee --append $logfile
description='- Description:\nKey exchange is any method in cryptography by which cryptographic keys are exchanged between two parties, allowing use of a cryptographic algorithm. If the sender and receiver wish to exchange encrypted messages, each must be equipped to encrypt messages to be sent and decrypt messages received.\n\nNotes:\n  \u2022 Kex algorithms have a higher preference the earlier they appear in the list\n  \u2022 Some organizations may have stricter requirements for approved Key exchange algorithms\n  \u2022 Ensure that Key exchange algorithms used are in compliance with site policy\n  \u2022 The only Key Exchange Algorithms currently FIPS 140-2 approved are:\n    \u00b0 ecdh-sha2-nistp256\n    \u00b0 ecdh-sha2-nistp384\n    \u00b0 ecdh-sha2-nistp521\n    \u00b0 diffie-hellman-group-exchange-sha256\n    \u00b0 diffie-hellman-group16-sha512\n    \u00b0 diffie-hellman-group18-sha512\n    \u00b0 diffie-hellman-group14-sha256\n  \u2022 The Key Exchange algorithms supported by OpenSSH 8.2 are:\ncurve25519-sha256, curve25519-sha256@libssh.org, diffie-hellman-group1-sha1, diffie-hellman-group14-sha1, diffie-hellman-group14-sha256, diffie-hellman-group16-sha512, diffie-hellman-group18-sha512, diffie-hellman-group-exchange-sha1, diffie-hellman-group-exchange-sha256, ecdh-sha2-nistp256,ecdh-sha2-nistp384, ecdh-sha2-nistp521, sntrup4591761x25519-sha512@tinyssh.org\n\n- Rationale:\nKey exchange methods that are considered weak should be removed. A key exchange method may be weak because too few bits are used, or the hashing algorithm is considered too weak. Using weak algorithms could expose connections to man-in-the-middle attacks.'

check_command="sshd -T | grep kexalgorithms"
score_pattern="sshd -T | grep -E 'kexalgorithms\|diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1'"

call_action=""
# TODO: create call action
check_if "==" "$check_command" "$score_pattern"
