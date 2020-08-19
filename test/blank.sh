#!/usr/bin/env bash
# include functions file
source ./functions.sh

clear
echo '' 2>&1 | tee -a $logfile

check_command=""
score_pattern=""

call_action=""

check_if "==" "$check_command" "$score_pattern"
