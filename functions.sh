#!/usr/bin/env bash

# set log file
logfile="log.txt"
#time_to_log=$(date +"%Y-%m-%d %H:%M:%S")

# detect type of input ($score_pattern) and compare it with $check_command
# $1 - comparison operator
# $2 - $check_command
# $3 - $score_pattern
function check_if() {
    if [[ $3 =~ ^[+-]?[0-9]+$ ]]; then #"input is an integer"
        if [ "$(eval "$2")" $1 "$3" ]; then
            check_scored_output "$1" "$2" "$3"
        else
            check_not_scored_output "$1" "$2" "$3"
        fi
    elif [[ $3 =~ ^[+-]?[0-9]+\.$ ]]; then #"input is a string"
        if [ "$(eval "$2")" $1 "$(eval "$3")" ]; then
            check_scored_output "$1" "$2" "$3"
        else
            check_not_scored_output "$1" "$2" "$3"
        fi
    elif [[ $3 =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then #"input is a float"
        if [ "$(eval "$2")" $1 "$3" ]; then
            check_scored_output "$1" "$2" "$3"
        else
            check_not_scored_output "$1" "$2" "$3"
        fi
    else #"input is a string"
        if [ "$(eval "$2")" $1 "$(eval "$3")" ]; then
            check_scored_output "$1" "$2" "$3"
        else
            check_not_scored_output "$1" "$2" "$3"
        fi
    fi
}

# detect type of input ($score_pattern) and compare it with $check_command
# $1 - comparison operator
# $2 - $check_command
# $3 - $score_pattern
function recheck_if() {
    if [[ $3 =~ ^[+-]?[0-9]+$ ]]; then #"input is an integer"
        if [ "$(eval "$2")" $1 "$3" ]; then
            recheck_scored_output "$1" "$2" "$3"
        else
            recheck_not_scored_output "$1" "$2" "$3"
        fi
    elif [[ $3 =~ ^[+-]?[0-9]+\.$ ]]; then #"input is a string"
        if [ "$(eval "$2")" $1 "$(eval "$3")" ]; then
            recheck_scored_output "$1" "$2" "$3"
        else
            recheck_not_scored_output "$1" "$2" "$3"
        fi
    elif [[ $3 =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then #"input is a float"
        if [ "$(eval "$2")" $1 "$3" ]; then
            recheck_scored_output "$1" "$2" "$3"
        else
            recheck_not_scored_output "$1" "$2" "$3"
        fi
    else #"input is a string"
        if [ "$(eval "$2")" $1 "$(eval "$3")" ]; then
            recheck_scored_output "$1" "$2" "$3"
        else
            recheck_not_scored_output "$1" "$2" "$3"
        fi
    fi
}

# output check if scored
# $1 - comparison operator
# $2 - $check_command
# $3 - $score_pattern
function check_scored_output() {
    echo -e "$description\n" 2>&1 | tee -a $logfile #| fold --spaces --width=115
    echo -e "- Current settings:\n$(eval "$2")\n" 2>&1 | tee -a $logfile
    echo -e "- Score pattern:\n"$1" "$3"\n" 2>&1 | tee -a $logfile
    echo "- Result:" 2>&1 | tee -a $logfile
    echo "scored" 2>&1 | tee -a $logfile
    echo "__________________________________________________________________________________________________________________" 2>&1 | tee -a $logfile
}

# output check if not scored
# $1 - comparison operator
# $2 - $check_command
# $3 - $score_pattern
function check_not_scored_output() {
    echo -e "$description\n" 2>&1 | tee -a $logfile #| fold --spaces --width=115
    echo -e "- Current settings:\n$(eval "$2")\n" 2>&1 | tee -a $logfile
    echo -e "- Score pattern:\n"$1" "$3"\n" 2>&1 | tee -a $logfile
    echo -e "- Command to execute:\n$call_action\n" 2>&1 | tee -a $logfile
    echo "- Result:" 2>&1 | tee -a $logfile
    echo -n "not scored" 2>&1 | tee -a $logfile
    ask_yn "$1" "$2" "$3"
    echo -e "\n__________________________________________________________________________________________________________________" 2>&1 | tee -a $logfile
}

# output recheck if scored
# $1 - comparison operator
# $2 - $check_command
# $3 - $score_pattern
function recheck_scored_output() {
    echo -e "\n" 2>&1 | tee -a $logfile
    echo -e "- Applied settings:\n$(eval "$2")\n" 2>&1 | tee -a $logfile
    echo -e "- Score pattern:\n"$1" "$3"\n" 2>&1 | tee -a $logfile
    echo "- Result:" 2>&1 | tee -a $logfile
    echo -n "scored" 2>&1 | tee -a $logfile
}

# output recheck if not scored
# $1 - comparison operator
# $2 - $check_command
# $3 - $score_pattern
function recheck_not_scored_output() {
    echo -e "\n" 2>&1 | tee -a $logfile
    echo -e "- Current settings:\n$(eval "$2")\n" 2>&1 | tee -a $logfile
    echo -e "- Score pattern:\n"$1" "$3"\n" 2>&1 | tee -a $logfile
    echo -e "- Command to execute:\n$call_action\n" 2>&1 | tee -a $logfile
    echo "- Result:" 2>&1 | tee -a $logfile
    echo -n "not scored" 2>&1 | tee -a $logfile
}

# function yes no loop to wright input, call_action on yes
function ask_yn() {
    while true; do
        read -p " do you want to score? [yes/no] : " yn
        case $yn in
        Y | y | Yes | YES | yes)
            eval "$call_action"
            recheck_if "$1" "$2" "$3"
            break
            ;;
        N | n | No | NO | no)
            echo -n " (skipped)" >>$logfile 2>&1
            break
            ;;
        *) echo "please answer yes or no" ;;
        esac
    done
}

# confirm command execution
# $1 - command to execute
function confirm_yn() {
    echo -e "command to execute:\n$1" # TODO: $value not showing
    while true; do
        read -p "do you want to set? [yes/no] : " yn
        case $yn in
        Y | y | Yes | YES | yes)
            eval $1
            break
            ;;
        N | n | No | NO | no) break ;;
        *) echo "please answer yes or no" ;;
        esac
    done
}

# function to set loglevel QUIET, FATAL, ERROR, INFO, VERBOSE, DEBUG, DEBUG1, DEBUG2, and DEBUG3
function case_loglevel_set() {
    echo "1 - QUIET"
    echo "2 - FATAL"
    echo "3 - ERROR"
    echo "4 - INFO"
    echo "5 - VERBOSE"
    echo "6 - DEBUG   - cause not scored"
    echo "7 - DEBUG1  - cause not scored"
    echo "8 - DEBUG2  - cause not scored"
    echo "9 - DEBUG3  - cause not scored"
    while true; do
        read -p "select log level: " x
        case $x in
        1)
            local value='QUIET'
            break
            ;;
        2)
            local value='FATAL'
            break
            ;;
        3)
            local value='ERROR'
            break
            ;;
        4)
            local value='INFO'
            break
            ;;
        5)
            local value='VERBOSE'
            break
            ;;
        6)
            local value='DEBUG'
            break
            ;;
        7)
            local value='DEBUG1'
            break
            ;;
        8)
            local value='DEBUG2'
            break
            ;;
        9)
            local value='DEBUG3'
            break
            ;;
        *) echo 'please select' ;;
        esac
    done
    confirm_yn "sed --in-place "'"'"s/^.*LogLevel.*$/LogLevel $value/"'"'" /etc/ssh/sshd_config"
}

# function set value
# $1 - comparison operator
# $2 - $check_command
# $3 - $score_pattern
# $4 - command
function set_value_gt0() {
    local value
    while true; do
        [ $value $1 $3 ] 2>/dev/null || [ $value -gt 0 ] 2>/dev/null
        read -p "set value $1 $3: " value
        if [ $value $1 $3 ] 2>/dev/null && [ $value -gt 0 ] 2>/dev/null; then
            break
        fi
    done
    confirm_yn "$4"
}
