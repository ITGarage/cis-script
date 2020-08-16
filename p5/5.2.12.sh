#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile
echo '  5.2.12 Ensure only strong Ciphers are used' 2>&1 | tee -a $logfile
description='- Description:\nThis variable limits the ciphers that SSH can use during communication.\n\nNotes:\n  \u2022 Some organizations may have stricter requirements for approved ciphers\n  \u2022 Ensure that ciphers used are in compliance with site policy\n  \u2022 The only "strong" ciphers currently FIPS 140-2 compliant are:\n    \u00b0 aes256-ctr\n    \u00b0 aes192-ctr\n    \u00b0 aes128-ctr\n  \u2022 Supported ciphers in openSSH 8.2:\n3des-cbc, aes128-cbc, aes192-cbc, aes256-cbc, aes128-ctr, aes192-ctr, aes256-ctr, aes128-gcm@openssh.com, aes256-gcm@openssh.com, chacha20-poly1305@openssh.com\n\n- Rationale:\nWeak ciphers that are used for authentication to the cryptographic module cannot be relied upon to provide confidentiality or integrity, and system data may be compromised\n  \u2022 The Triple DES ciphers, as used in SSH, have a birthday bound of approximately four billion blocks, which makes it easier for remote attackers to obtain cleartext data via a birthday attack against a long-duration encrypted session, aka a "Sweet32" attack\n  \u2022 Error handling in the SSH protocol; Client and Server, when using a block cipher algorithm in Cipher Block Chaining (CBC) mode, makes it easier for remote attackers to recover certain plaintext data from an arbitrary block of ciphertext in an SSH session via unknown vectors'

check_command="sshd -T | grep ciphers"
score_pattern="sshd -T | grep --extended-regexp 'ciphers\|3des-cbc|aes128-cbc|aes192-cbc|aes256-cbc'"

call_action=""
# TODO: create call action
check_if "!=" "$check_command" "$score_pattern"


test="sshd -T | grep --extended-regexp 'ciphers\|3des-cbc|aes128-cbc|aes192-cbc|aes256-cbc|chacha20-poly1305@openssh.com'"
